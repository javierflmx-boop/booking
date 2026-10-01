// ============================================================
// ESTIMO — STATUS CONFIG
// Single source of truth for every status across the app.
// Import this wherever you build a dropdown, a status chip,
// or check/compare a status value — never hardcode the list
// in more than one place.
// ============================================================

// ---------- ESTIMATE STATUSES ----------
export const ESTIMATE_STATUSES = [
  { value: "draft",     label: "Draft",            color: "#D9D9D9", textColor: "#1A1A1A" },
  { value: "sent",      label: "Sent",             color: "#FFD58A", textColor: "#1A1A1A" },
  { value: "pending",   label: "Pending Approval", color: "#FE7F2D", textColor: "#1A1A1A" },
  { value: "approved",  label: "Approved",         color: "#3FA34D", textColor: "#FFFFFF" },
  { value: "expired",   label: "Expired",          color: "#BBBBBB", textColor: "#555555" },
  { value: "declined",  label: "Declined",         color: "#D7263D", textColor: "#FFFFFF" },
];

// ---------- JOB STATUSES ----------
export const JOB_STATUSES = [
  { value: "scheduled", label: "Scheduled",  color: "#D9D9D9", textColor: "#1A1A1A" },
  { value: "working",   label: "Working",    color: "#FE7F2D", textColor: "#1A1A1A" },
  { value: "on_hold",   label: "On Hold",    color: "#FFD58A", textColor: "#1A1A1A" },
  { value: "completed", label: "Completed",  color: "#3FA34D", textColor: "#FFFFFF" },
  { value: "cancelled", label: "Cancelled",  color: "#D7263D", textColor: "#FFFFFF" },
];

// ---------- INVOICE STATUSES ----------
export const INVOICE_STATUSES = [
  { value: "draft",    label: "Draft",    color: "#D9D9D9", textColor: "#1A1A1A" },
  { value: "sent",     label: "Sent",     color: "#FFD58A", textColor: "#1A1A1A" },
  { value: "partial",  label: "Partial",  color: "#FE7F2D", textColor: "#1A1A1A" },
  { value: "paid",     label: "Paid",     color: "#3FA34D", textColor: "#FFFFFF" },
  { value: "overdue",  label: "Overdue",  color: "#D7263D", textColor: "#FFFFFF" },
  { value: "void",     label: "Void",     color: "#BBBBBB", textColor: "#555555" },
];

// ------------------------------------------------------------
// Helper: look up a status object by its value, for any list
// Usage: getStatus(INVOICE_STATUSES, invoice.status)
// ------------------------------------------------------------
export function getStatus(list, value) {
  return list.find((s) => s.value === value) || list[0];
}

// ------------------------------------------------------------
// Helper: auto-compute invoice status from real data instead
// of trusting a manually-set field. Call this whenever you
// display or save an invoice, so "overdue" and "partial"
// are never stale.
//
// Usage:
//   const status = computeInvoiceStatus({
//     amountPaid: 16000,
//     total: 80000,
//     dueDate: '2026-11-01',
//     isVoid: false,
//     isSent: true,
//   });
// ------------------------------------------------------------
export function computeInvoiceStatus({ amountPaid, total, dueDate, isVoid, isSent }) {
  if (isVoid) return "void";
  if (!isSent) return "draft";

  const today = new Date();
  const due = dueDate ? new Date(dueDate) : null;
  const balance = total - amountPaid;

  if (balance <= 0) return "paid";
  if (due && today > due) return "overdue";
  if (amountPaid > 0) return "partial";
  return "sent";
}

// ------------------------------------------------------------
// Helper: auto-compute estimate status (expired check)
// Usage:
//   const status = computeEstimateStatus({
//     manualStatus: 'sent',
//     validUntil: '2026-11-01',
//   });
// ------------------------------------------------------------
export function computeEstimateStatus({ manualStatus, validUntil }) {
  if (["approved", "declined"].includes(manualStatus)) return manualStatus;
  if (validUntil && new Date() > new Date(validUntil)) return "expired";
  return manualStatus || "draft";
}
