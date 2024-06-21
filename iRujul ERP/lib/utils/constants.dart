
import 'package:get/get.dart';

final appMenus = [
  "HOME".tr, "ADMIN".tr, "SALES".tr, "PROCUREMENT".tr, "FINANCE".tr, "ACCOUNTING".tr, "REPORT".tr, "BI".tr, "CRM".tr, "HRM".tr,
];

final menuOptions = [
  {
    "SALES": [
      {
        "menu":"Organization",
        "options": [
          "Update Customer Info"
        ]
      },
      {
        "menu":"Day Close",
        "options": [
          "Day Open Summary",
          "Day Close List",
          "Day Close Cancellation",
          "Day End",
          "Transaction Verification",
          "Day End Detail",
          "Daily Sales Statement",
          "Daily Collections",
          "Footfall Details",
          "Day Close Apparel"
        ]
      },
      {
        "menu": "Master",
        "options": [
          "Customer List",
          "Customer",
          "Financier",
          "Item MRP List",
          "Buyback Vendor",
          "Enquiry Stage",
          "Lead / Customer List",
          "Sale Price Lists"
        ]
      },
      {
        "menu": "Approvals",
        "options": [
          "Quote Approval",
          "Sales Order Approval"
        ]
      },
      {
        "menu": "CNDN",
        "options": [
          "Direct Sale Return",
          "Direct Sale Return List"
        ]
      },
      {
        "menu": "Order",
        "options": [
          "Refund Request",
          "Delivery Challan",
          "Quotation",
          "Delivery Challan List",
          "Quotation List",
          "Refund Proceed",
          "Sale Order",
          "Sale Order List",
          "Optical Prescription",
          "Optical Prescription List",
          "SO Stock Allocation",
          "Ecom Sale Order Statement"
        ]
      },
      {
        "menu": "Reports",
        "options": [
          "Daily Sales Report"
        ]
      },
      {
        "menu": "Invoice",
        "options": [
          "E-Invoicing",
          "Sale Invoice",
          "Sale Invoice List",
          "E-Way Bill",
          "Distributed Sale Invoice",
          "Distributed Sale Invoice List",
          "Bulk Sale Invoice",
          "Bulk Sale Invoice List",
          "Buyback Handover Process",
          "Generated E-invoice",
          "Dispatch Details",
          "Delivery Stage",
          "Dispatch Transaction",
          "Dispatch Transaction List"
        ]
      },
    ]
  }
];