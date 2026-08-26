-- ============================================================
-- CONTRACTOR OS — Supabase schema
-- One company = one contractor business. Built multi-tenant
-- from day one so this can be resold to other contractors later.
-- ============================================================

-- ---------- COMPANIES ----------
create table companies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  industry text,
  phone text,
  address text,
  logo_url text,
  created_at timestamptz default now()
);

-- ---------- USERS (extends Supabase auth.users) ----------
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  company_id uuid references companies(id) on delete cascade,
  full_name text not null,
  phone text,
  role text not null check (role in ('owner','helper')) default 'helper',
  created_at timestamptz default now()
);

-- ---------- CUSTOMERS ----------
create table customers (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  phone text,
  email text,
  address text,
  notes text,
  created_at timestamptz default now()
);

-- ---------- PRICE BOOK ----------
create table price_book_items (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  description text,
  unit text default 'each',
  unit_price numeric(10,2) not null default 0,
  created_at timestamptz default now()
);

-- ---------- JOBS ----------
create table jobs (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  customer_id uuid references customers(id) on delete set null,
  title text not null,
  description text,
  status text not null check (status in ('scheduled','in_progress','completed','invoiced','cancelled')) default 'scheduled',
  scheduled_start timestamptz,
  scheduled_end timestamptz,
  address text,
  created_by uuid references profiles(id),
  created_at timestamptz default now()
);

-- helpers assigned to a job (many-to-many)
create table job_assignments (
  job_id uuid references jobs(id) on delete cascade,
  profile_id uuid references profiles(id) on delete cascade,
  primary key (job_id, profile_id)
);

-- photos / notes a helper adds from the field
create table job_updates (
  id uuid primary key default gen_random_uuid(),
  job_id uuid references jobs(id) on delete cascade,
  profile_id uuid references profiles(id),
  note text,
  photo_url text,
  created_at timestamptz default now()
);

-- clock in/out per job
create table timecards (
  id uuid primary key default gen_random_uuid(),
  job_id uuid references jobs(id) on delete cascade,
  profile_id uuid references profiles(id),
  clock_in timestamptz not null default now(),
  clock_out timestamptz
);

-- ---------- ESTIMATES ----------
create table estimates (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  customer_id uuid references customers(id),
  job_id uuid references jobs(id),
  status text not null check (status in ('draft','sent','approved','declined')) default 'draft',
  line_items jsonb not null default '[]',  -- [{name, qty, unit_price}]
  total numeric(10,2) not null default 0,
  notes text,
  created_at timestamptz default now()
);

-- ---------- INVOICES ----------
create table invoices (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  customer_id uuid references customers(id),
  job_id uuid references jobs(id),
  estimate_id uuid references estimates(id),
  status text not null check (status in ('draft','sent','paid','overdue')) default 'draft',
  line_items jsonb not null default '[]',
  total numeric(10,2) not null default 0,
  due_date date,
  paid_at timestamptz,
  created_at timestamptz default now()
);

-- ============================================================
-- ROW LEVEL SECURITY — everyone only sees their own company's data.
-- Helpers get cut down further in the app layer (owner-only screens).
-- ============================================================
alter table companies enable row level security;
alter table profiles enable row level security;
alter table customers enable row level security;
alter table price_book_items enable row level security;
alter table jobs enable row level security;
alter table job_assignments enable row level security;
alter table job_updates enable row level security;
alter table timecards enable row level security;
alter table estimates enable row level security;
alter table invoices enable row level security;

create or replace function my_company_id() returns uuid as $$
  select company_id from profiles where id = auth.uid()
$$ language sql stable security definer;

create policy "own company" on companies for select using (id = my_company_id());
create policy "own company profiles" on profiles for select using (company_id = my_company_id());
create policy "own company customers" on customers for all using (company_id = my_company_id());
create policy "own company price book" on price_book_items for all using (company_id = my_company_id());
create policy "own company jobs" on jobs for all using (company_id = my_company_id());
create policy "own company estimates" on estimates for all using (company_id = my_company_id());
create policy "own company invoices" on invoices for all using (company_id = my_company_id());
create policy "assignments via job" on job_assignments for all using (
  job_id in (select id from jobs where company_id = my_company_id())
);
create policy "updates via job" on job_updates for all using (
  job_id in (select id from jobs where company_id = my_company_id())
);
create policy "timecards via job" on timecards for all using (
  job_id in (select id from jobs where company_id = my_company_id())
);
