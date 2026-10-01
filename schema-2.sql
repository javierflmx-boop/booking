<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Invoice</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Archivo+Expanded:wght@700;800&family=Inter:wght@400;500;600;700&display=swap');

  :root {
    --charcoal: #233D4D;
    --orange: #FE7F2D;
    --paper: #FFFFFF;
    --ink: #1A1A1A;
    --grey: #6B6B6B;
    --line: #E4E1DA;
  }

  * { box-sizing: border-box; }

  body {
    margin: 0;
    background: #F4F2EE;
    font-family: 'Inter', sans-serif;
    color: var(--ink);
  }

  .sheet {
    width: 850px;
    margin: 32px auto;
    background: var(--paper);
    border: 3px solid var(--ink);
    box-shadow: 10px 10px 0 var(--orange);
    padding: 48px 52px 40px;
  }

  /* ---- HEADER ---- */
  .header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    border-bottom: 4px solid var(--ink);
    padding-bottom: 24px;
    margin-bottom: 28px;
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 14px;
  }
  .brand-mark {
    width: 54px; height: 54px;
    background: var(--charcoal);
    border: 3px solid var(--ink);
    display: flex; align-items: center; justify-content: center;
    box-shadow: 4px 4px 0 var(--orange);
    flex-shrink: 0;
  }
  .brand-mark span {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    color: #fff;
    font-size: 20px;
  }
  .brand-name {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    font-size: 24px;
    letter-spacing: -0.5px;
    color: var(--ink);
    line-height: 1.1;
  }
  .brand-sub {
    font-size: 12px;
    color: var(--grey);
    margin-top: 4px;
    letter-spacing: 0.3px;
  }
  .invoice-tag {
    text-align: right;
  }
  .invoice-tag .label {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    font-size: 30px;
    color: var(--orange);
    letter-spacing: 1px;
    -webkit-text-stroke: 1px var(--ink);
  }
  .invoice-tag .num {
    font-size: 13px;
    color: var(--grey);
    margin-top: 2px;
    font-weight: 600;
  }

  /* ---- META GRID ---- */
  .meta {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
    margin-bottom: 28px;
  }
  .meta-block {
    border: 2px solid var(--ink);
    padding: 14px 16px;
    background: #FAF9F6;
  }
  .meta-block .k {
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--grey);
    font-weight: 700;
    margin-bottom: 6px;
  }
  .meta-block .v {
    font-size: 14px;
    font-weight: 600;
    line-height: 1.5;
  }
  .meta-row {
    display: flex;
    justify-content: space-between;
    font-size: 13px;
    margin-top: 6px;
  }
  .meta-row .k2 { color: var(--grey); font-weight: 600; }
  .meta-row .v2 { font-weight: 700; }

  /* ---- STATUS CHIP ---- */
  .chip {
    display: inline-block;
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    font-size: 11px;
    letter-spacing: 1px;
    text-transform: uppercase;
    padding: 5px 12px;
    border: 2px solid var(--ink);
    background: var(--orange);
    color: var(--ink);
    box-shadow: 3px 3px 0 var(--ink);
  }
  /* Invoice status variants */
  .chip-draft    { background: #D9D9D9; color: var(--ink); }
  .chip-sent     { background: #FFD58A; color: var(--ink); }
  .chip-partial  { background: var(--orange); color: var(--ink); }
  .chip-paid     { background: #3FA34D; color: #fff; }
  .chip-overdue  { background: #D7263D; color: #fff; }
  .chip-void     { background: #BBBBBB; color: #555; text-decoration: line-through; }

  /* ---- LINE ITEMS ---- */
  table.items {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    border: 2px solid var(--ink);
  }
  table.items thead th {
    background: var(--ink);
    color: #fff;
    font-family: 'Archivo Expanded', sans-serif;
    font-size: 11px;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    padding: 10px 14px;
    text-align: left;
  }
  table.items thead th.amt { text-align: right; }
  table.items tbody td {
    padding: 14px;
    border-top: 1px solid var(--line);
    font-size: 14px;
    vertical-align: top;
  }
  table.items tbody td.amt {
    text-align: right;
    font-weight: 700;
    white-space: nowrap;
  }
  table.items tbody .desc-title { font-weight: 700; margin-bottom: 4px; }
  table.items tbody .desc-sub { color: var(--grey); font-size: 12.5px; line-height: 1.5; }
  table.items tbody tr:nth-child(even) { background: #FAF9F6; }

  /* ---- SCOPE OF WORK ---- */
  .scope-head {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    font-size: 13px;
    letter-spacing: 0.6px;
    text-transform: uppercase;
    color: var(--ink);
    border-bottom: 2px solid var(--ink);
    padding-bottom: 8px;
    margin-bottom: 14px;
  }
  .scope-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 36px;
    margin-bottom: 26px;
  }
  .scope-cat {
    margin-bottom: 16px;
    break-inside: avoid;
  }
  .scope-cat .cat-title {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 700;
    font-size: 12.5px;
    color: var(--orange);
    text-transform: uppercase;
    letter-spacing: 0.4px;
    margin-bottom: 5px;
    padding-left: 10px;
    border-left: 3px solid var(--orange);
  }
  .scope-cat ul {
    margin: 0;
    padding: 0 0 0 10px;
    list-style: none;
  }
  .scope-cat li {
    font-size: 12px;
    line-height: 1.55;
    color: var(--ink);
    position: relative;
    padding-left: 12px;
  }
  .scope-cat li::before {
    content: "•";
    position: absolute;
    left: 0;
    color: var(--grey);
  }

  /* ---- SCOPE CHANGE BOX ---- */
  .notice {
    border: 2px dashed var(--orange);
    background: #FFF6EE;
    padding: 14px 16px;
    margin-bottom: 24px;
    font-size: 12.5px;
  }
  .notice .t {
    font-family: 'Archivo Expanded', sans-serif;
    font-weight: 800;
    font-size: 11px;
    letter-spacing: 0.8px;
    text-transform: uppercase;
    color: var(--orange);
    margin-bottom: 6px;
  }
  .notice b { color: var(--ink); }

  /* ---- TOTALS ---- */
  .totals {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 30px;
  }
  .totals-box {
    width: 320px;
    border: 2px solid var(--ink);
  }
  .totals-row {
    display: flex;
    justify-content: space-between;
    padding: 10px 16px;
    font-size: 13.5px;
    border-bottom: 1px solid var(--line);
  }
  .totals-row .k { color: var(--grey); font-weight: 600; }
  .totals-row .v { font-weight: 700; }
  .totals-row.grand {
    background: var(--charcoal);
    border-bottom: none;
  }
  .totals-row.grand .k, .totals-row.grand .v {
    color: #fff;
    font-family: 'Archivo Expanded', sans-serif;
    font-size: 16px;
    font-weight: 800;
  }
  .totals-row.due .v { color: var(--orange); }

  /* ---- FOOTER ---- */
  .footer {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    border-top: 3px solid var(--ink);
    padding-top: 20px;
  }
  .footer .terms {
    font-size: 11.5px;
    color: var(--grey);
    max-width: 440px;
    line-height: 1.6;
  }
  .footer .pay {
    text-align: right;
    font-size: 12.5px;
  }
  .footer .pay .k { font-weight: 700; margin-bottom: 4px; }
</style>
</head>
<body>

<div class="sheet">

  <div class="header">
    <div class="brand">
      <div class="brand-mark"><span>407</span></div>
      <div>
        <div class="brand-name">407 RENOVATIONS</div>
        <div class="brand-sub">Javier Flores, Owner &nbsp;•&nbsp; 2347 Quaker Ct, Orlando, FL 32837</div>
        <div class="brand-sub">(407) 432-1935 &nbsp;•&nbsp; javierflmx@me.com</div>
      </div>
    </div>
    <div class="invoice-tag">
      <div class="label">INVOICE</div>
      <div class="num">No. {{invoice_number}}</div>
    </div>
  </div>

  <div class="meta">
    <div class="meta-block">
      <div class="k">Bill To</div>
      <div class="v">{{client_name}}<br>{{project_address}}</div>
    </div>
    <div class="meta-block">
      <div class="meta-row"><span class="k2">Invoice Date</span><span class="v2">{{invoice_date}}</span></div>
      <div class="meta-row"><span class="k2">Project</span><span class="v2">Salon Build-Out, {{sqft}} SF</span></div>
      <div class="meta-row"><span class="k2">Target Completion</span><span class="v2">{{completion_date}}</span></div>
      <div class="meta-row"><span class="k2">Status</span><span class="v2"><span class="chip chip-{{status_class}}">{{status}}</span></span></div>
    </div>
  </div>

  <table class="items">
    <thead>
      <tr>
        <th style="width:72%">Description</th>
        <th class="amt" style="width:28%">Amount</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div class="desc-title">Salon Renovation — Full Scope of Work</div>
          <div class="desc-sub">See full itemized scope of work below.</div>
        </td>
        <td class="amt">{{contract_total}}</td>
      </tr>
    </tbody>
  </table>

  <div class="scope-head">Project Scope of Work</div>
  <div class="scope-grid">
    <div>
      <div class="scope-cat">
        <div class="cat-title">Demolition</div>
        <ul>
          <li>Remove existing carpet throughout</li>
          <li>Remove old, unsafe electrical wiring left by the previous tenant</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">Walls &amp; Framing</div>
        <ul>
          <li>Build and reconfigure walls to create the 2 shampoo/bowl sink rooms</li>
          <li>Build the new nail room</li>
          <li>Rework the large accent wall to create a dedicated TV wall section</li>
          <li>Install a custom 48" door for access to the bathroom and back hallway</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">Flooring</div>
        <ul>
          <li>Replace flooring throughout — approx. {{sqft}} sf</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">Ceiling</div>
        <ul>
          <li>Remove the existing 24"x48" halogen panel fixtures</li>
          <li>See Scope Change note below for the ceiling panel/paint revision</li>
        </ul>
      </div>
    </div>
    <div>
      <div class="scope-cat">
        <div class="cat-title">Electrical</div>
        <ul>
          <li>Fix and bring all electrical up to a modern standard throughout</li>
          <li>Replace all switches with modern smart switches</li>
          <li>Add LED lighting throughout for a modern, smart look</li>
          <li>Install a long LED track lighting run</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">HVAC</div>
        <ul>
          <li>Move ductwork to bring A/C service to the 2 new rooms</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">Plumbing</div>
        <ul>
          <li>Renovate the bathroom</li>
          <li>Plumbing for the 2 bowl sink rooms</li>
          <li>Add plumbing for the laundry area</li>
        </ul>
      </div>
      <div class="scope-cat">
        <div class="cat-title">Custom Carpentry &amp; Millwork</div>
        <ul>
          <li>Custom wall paneling in 3 rooms plus the large accent wall</li>
          <li>Build the European-style color-mixing "kitchen" area</li>
          <li>Build a short 36" tall wall to define the 5-seat styling area</li>
          <li>Install 6" baseboards throughout</li>
          <li>Finish remaining walls (without paneling) with a smooth look</li>
        </ul>
      </div>
    </div>
  </div>

  <div class="notice">
    <div class="t">Scope Change — Agreed by Both Parties</div>
    <b>Original:</b> Remove and replace all ceiling panels with new panels throughout.
    &nbsp;→&nbsp;
    <b>Revised:</b> Repair existing ceiling and finish with full black paint throughout, in place of new panel replacement.
  </div>

  <div class="totals">
    <div class="totals-box">
      <div class="totals-row"><span class="k">Contract Total</span><span class="v">{{contract_total}}</span></div>
      <div class="totals-row"><span class="k">Paid to Date</span><span class="v">{{paid_to_date}}</span></div>
      <div class="totals-row due"><span class="k">Balance Due</span><span class="v">{{balance_due}}</span></div>
      <div class="totals-row grand"><span class="k">Total</span><span class="v">{{contract_total}}</span></div>
    </div>
  </div>

  <div class="footer">
    <div class="terms">
      This invoice reflects the agreed full project scope and total contract price. It is not an itemized accounting of materials or labor costs. Payments recorded via {{payment_method}}.
      <br><br>
      {{license_line}}
    </div>
    <div class="pay">
      <div class="k">Javier Flores</div>
      <div>407 Renovations</div>
      <div>2347 Quaker Ct, Orlando, FL 32837</div>
      <div>javierflmx@me.com &nbsp;•&nbsp; (407) 432-1935</div>
    </div>
  </div>

</div>

</body>
</html>
