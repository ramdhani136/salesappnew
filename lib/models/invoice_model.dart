// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? title;
  String? manualNaming;
  String? namingSeries;
  num? customerCash;
  String? customer;
  String? customerName;
  num? isTax;
  num? isPos;
  num? isConsolidated;
  num? isReturn;
  String? taxStatus;
  num? isDebitNote;
  num? updateBilledAmountInSalesOrder;
  String? company;
  DateTime? postingDate;
  String? postingTime;
  num? setPostingTime;
  DateTime? dueDate;
  num? barangSudahTerkirim;
  String? poNo;
  String? customerAddress;
  String? addressDisplay;
  String? territory;
  String? shippingAddressName;
  String? companyAddress;
  String? companyAddressDisplay;
  String? currency;
  num? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  num? plcConversionRate;
  num? ignorePricingRule;
  String? setWarehouse;
  num? updateStock;
  num? totalBillingAmount;
  num? totalBillingHours;
  num? totalQty;
  num? baseTotal;
  num? baseNetTotal;
  num? totalNetWeight;
  num? total;
  num? netTotal;
  String? taxCategory;
  num? baseTotalTaxesAndCharges;
  num? totalTaxesAndCharges;
  num? loyaltyPoints;
  num? loyaltyAmount;
  num? redeemLoyaltyPoints;
  String? applyDiscountOn;
  num? baseDiscountAmount;
  num? additionalDiscountPercentage;
  num? discountAmount;
  num? baseGrandTotal;
  num? baseRoundingAdjustment;
  num? baseRoundedTotal;
  String? baseInWords;
  num? grandTotal;
  num? roundingAdjustment;
  num? roundedTotal;
  String? inWords;
  num? totalAdvance;
  num? outstandingAmount;
  num? disableRoundedTotal;
  num? writeOffAmount;
  num? baseWriteOffAmount;
  num? writeOffOutstandingAmountAutomatically;
  num? allocateAdvancesAutomatically;
  num? ignoreDefaultPaymentTermsTemplate;
  String? paymentTermsTemplate;
  num? basePaidAmount;
  num? paidAmount;
  num? baseChangeAmount;
  num? changeAmount;
  num? groupSameItems;
  String? status;
  String? customerGroup;
  num? isInternalCustomer;
  num? isDiscounted;
  String? debitTo;
  String? partyAccountCurrency;
  String? isOpening;
  String? cFormApplicable;
  String? remarks;
  num? amountEligibleForCommission;
  num? commissionRate;
  num? totalCommission;
  String? nomorSalesOrder;
  String? againstIncomeAccount;
  String? doctype;
  List<Item>? items;
  List<dynamic>? pricingRules;
  List<dynamic>? packedItems;
  List<dynamic>? timesheets;
  List<dynamic>? taxes;
  List<dynamic>? advances;
  List<PaymentSchedule>? paymentSchedule;
  List<dynamic>? payments;
  List<SalesTeam>? salesTeam;

  InvoiceModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.title,
    this.manualNaming,
    this.namingSeries,
    this.customerCash,
    this.customer,
    this.customerName,
    this.isTax,
    this.isPos,
    this.isConsolidated,
    this.isReturn,
    this.taxStatus,
    this.isDebitNote,
    this.updateBilledAmountInSalesOrder,
    this.company,
    this.postingDate,
    this.postingTime,
    this.setPostingTime,
    this.dueDate,
    this.barangSudahTerkirim,
    this.poNo,
    this.customerAddress,
    this.addressDisplay,
    this.territory,
    this.shippingAddressName,
    this.companyAddress,
    this.companyAddressDisplay,
    this.currency,
    this.conversionRate,
    this.sellingPriceList,
    this.priceListCurrency,
    this.plcConversionRate,
    this.ignorePricingRule,
    this.setWarehouse,
    this.updateStock,
    this.totalBillingAmount,
    this.totalBillingHours,
    this.totalQty,
    this.baseTotal,
    this.baseNetTotal,
    this.totalNetWeight,
    this.total,
    this.netTotal,
    this.taxCategory,
    this.baseTotalTaxesAndCharges,
    this.totalTaxesAndCharges,
    this.loyaltyPoints,
    this.loyaltyAmount,
    this.redeemLoyaltyPoints,
    this.applyDiscountOn,
    this.baseDiscountAmount,
    this.additionalDiscountPercentage,
    this.discountAmount,
    this.baseGrandTotal,
    this.baseRoundingAdjustment,
    this.baseRoundedTotal,
    this.baseInWords,
    this.grandTotal,
    this.roundingAdjustment,
    this.roundedTotal,
    this.inWords,
    this.totalAdvance,
    this.outstandingAmount,
    this.disableRoundedTotal,
    this.writeOffAmount,
    this.baseWriteOffAmount,
    this.writeOffOutstandingAmountAutomatically,
    this.allocateAdvancesAutomatically,
    this.ignoreDefaultPaymentTermsTemplate,
    this.paymentTermsTemplate,
    this.basePaidAmount,
    this.paidAmount,
    this.baseChangeAmount,
    this.changeAmount,
    this.groupSameItems,
    this.status,
    this.customerGroup,
    this.isInternalCustomer,
    this.isDiscounted,
    this.debitTo,
    this.partyAccountCurrency,
    this.isOpening,
    this.cFormApplicable,
    this.remarks,
    this.amountEligibleForCommission,
    this.commissionRate,
    this.totalCommission,
    this.nomorSalesOrder,
    this.againstIncomeAccount,
    this.doctype,
    this.items,
    this.pricingRules,
    this.packedItems,
    this.timesheets,
    this.taxes,
    this.advances,
    this.paymentSchedule,
    this.payments,
    this.salesTeam,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        title: json["title"],
        manualNaming: json["manual_naming"],
        namingSeries: json["naming_series"],
        customerCash: json["customer_cash"],
        customer: json["customer"],
        customerName: json["customer_name"],
        isTax: json["is_tax"],
        isPos: json["is_pos"],
        isConsolidated: json["is_consolidated"],
        isReturn: json["is_return"],
        taxStatus: json["tax_status"],
        isDebitNote: json["is_debit_note"],
        updateBilledAmountInSalesOrder:
            json["update_billed_amount_in_sales_order"],
        company: json["company"],
        postingDate: json["posting_date"] == null
            ? null
            : DateTime.parse(json["posting_date"]),
        postingTime: json["posting_time"],
        setPostingTime: json["set_posting_time"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        barangSudahTerkirim: json["barang_sudah_terkirim"],
        poNo: json["po_no"],
        customerAddress: json["customer_address"],
        addressDisplay: json["address_display"],
        territory: json["territory"],
        shippingAddressName: json["shipping_address_name"],
        companyAddress: json["company_address"],
        companyAddressDisplay: json["company_address_display"],
        currency: json["currency"],
        conversionRate: json["conversion_rate"],
        sellingPriceList: json["selling_price_list"],
        priceListCurrency: json["price_list_currency"],
        plcConversionRate: json["plc_conversion_rate"],
        ignorePricingRule: json["ignore_pricing_rule"],
        setWarehouse: json["set_warehouse"],
        updateStock: json["update_stock"],
        totalBillingAmount: json["total_billing_amount"],
        totalBillingHours: json["total_billing_hours"],
        totalQty: json["total_qty"],
        baseTotal: json["base_total"],
        baseNetTotal: json["base_net_total"],
        totalNetWeight: json["total_net_weight"],
        total: json["total"],
        netTotal: json["net_total"],
        taxCategory: json["tax_category"],
        baseTotalTaxesAndCharges: json["base_total_taxes_and_charges"],
        totalTaxesAndCharges: json["total_taxes_and_charges"],
        loyaltyPoints: json["loyalty_points"],
        loyaltyAmount: json["loyalty_amount"],
        redeemLoyaltyPoints: json["redeem_loyalty_points"],
        applyDiscountOn: json["apply_discount_on"],
        baseDiscountAmount: json["base_discount_amount"],
        additionalDiscountPercentage: json["additional_discount_percentage"],
        discountAmount: json["discount_amount"],
        baseGrandTotal: json["base_grand_total"],
        baseRoundingAdjustment: json["base_rounding_adjustment"],
        baseRoundedTotal: json["base_rounded_total"],
        baseInWords: json["base_in_words"],
        grandTotal: json["grand_total"],
        roundingAdjustment: json["rounding_adjustment"],
        roundedTotal: json["rounded_total"],
        inWords: json["in_words"],
        totalAdvance: json["total_advance"],
        outstandingAmount: json["outstanding_amount"],
        disableRoundedTotal: json["disable_rounded_total"],
        writeOffAmount: json["write_off_amount"],
        baseWriteOffAmount: json["base_write_off_amount"],
        writeOffOutstandingAmountAutomatically:
            json["write_off_outstanding_amount_automatically"],
        allocateAdvancesAutomatically: json["allocate_advances_automatically"],
        ignoreDefaultPaymentTermsTemplate:
            json["ignore_default_payment_terms_template"],
        paymentTermsTemplate: json["payment_terms_template"],
        basePaidAmount: json["base_paid_amount"],
        paidAmount: json["paid_amount"],
        baseChangeAmount: json["base_change_amount"],
        changeAmount: json["change_amount"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        customerGroup: json["customer_group"],
        isInternalCustomer: json["is_internal_customer"],
        isDiscounted: json["is_discounted"],
        debitTo: json["debit_to"],
        partyAccountCurrency: json["party_account_currency"],
        isOpening: json["is_opening"],
        cFormApplicable: json["c_form_applicable"],
        remarks: json["remarks"],
        amountEligibleForCommission: json["amount_eligible_for_commission"],
        commissionRate: json["commission_rate"],
        totalCommission: json["total_commission"],
        nomorSalesOrder: json["nomor_sales_order"],
        againstIncomeAccount: json["against_income_account"],
        doctype: json["doctype"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        pricingRules: json["pricing_rules"] == null
            ? []
            : List<dynamic>.from(json["pricing_rules"]!.map((x) => x)),
        packedItems: json["packed_items"] == null
            ? []
            : List<dynamic>.from(json["packed_items"]!.map((x) => x)),
        timesheets: json["timesheets"] == null
            ? []
            : List<dynamic>.from(json["timesheets"]!.map((x) => x)),
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
        advances: json["advances"] == null
            ? []
            : List<dynamic>.from(json["advances"]!.map((x) => x)),
        paymentSchedule: json["payment_schedule"] == null
            ? []
            : List<PaymentSchedule>.from(json["payment_schedule"]!
                .map((x) => PaymentSchedule.fromJson(x))),
        payments: json["payments"] == null
            ? []
            : List<dynamic>.from(json["payments"]!.map((x) => x)),
        salesTeam: json["sales_team"] == null
            ? []
            : List<SalesTeam>.from(
                json["sales_team"]!.map((x) => SalesTeam.fromJson(x))),
      );

  static List<InvoiceModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => InvoiceModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "title": title,
        "manual_naming": manualNaming,
        "naming_series": namingSeries,
        "customer_cash": customerCash,
        "customer": customer,
        "customer_name": customerName,
        "is_tax": isTax,
        "is_pos": isPos,
        "is_consolidated": isConsolidated,
        "is_return": isReturn,
        "tax_status": taxStatus,
        "is_debit_note": isDebitNote,
        "update_billed_amount_in_sales_order": updateBilledAmountInSalesOrder,
        "company": company,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "posting_time": postingTime,
        "set_posting_time": setPostingTime,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "barang_sudah_terkirim": barangSudahTerkirim,
        "po_no": poNo,
        "customer_address": customerAddress,
        "address_display": addressDisplay,
        "territory": territory,
        "shipping_address_name": shippingAddressName,
        "company_address": companyAddress,
        "company_address_display": companyAddressDisplay,
        "currency": currency,
        "conversion_rate": conversionRate,
        "selling_price_list": sellingPriceList,
        "price_list_currency": priceListCurrency,
        "plc_conversion_rate": plcConversionRate,
        "ignore_pricing_rule": ignorePricingRule,
        "set_warehouse": setWarehouse,
        "update_stock": updateStock,
        "total_billing_amount": totalBillingAmount,
        "total_billing_hours": totalBillingHours,
        "total_qty": totalQty,
        "base_total": baseTotal,
        "base_net_total": baseNetTotal,
        "total_net_weight": totalNetWeight,
        "total": total,
        "net_total": netTotal,
        "tax_category": taxCategory,
        "base_total_taxes_and_charges": baseTotalTaxesAndCharges,
        "total_taxes_and_charges": totalTaxesAndCharges,
        "loyalty_points": loyaltyPoints,
        "loyalty_amount": loyaltyAmount,
        "redeem_loyalty_points": redeemLoyaltyPoints,
        "apply_discount_on": applyDiscountOn,
        "base_discount_amount": baseDiscountAmount,
        "additional_discount_percentage": additionalDiscountPercentage,
        "discount_amount": discountAmount,
        "base_grand_total": baseGrandTotal,
        "base_rounding_adjustment": baseRoundingAdjustment,
        "base_rounded_total": baseRoundedTotal,
        "base_in_words": baseInWords,
        "grand_total": grandTotal,
        "rounding_adjustment": roundingAdjustment,
        "rounded_total": roundedTotal,
        "in_words": inWords,
        "total_advance": totalAdvance,
        "outstanding_amount": outstandingAmount,
        "disable_rounded_total": disableRoundedTotal,
        "write_off_amount": writeOffAmount,
        "base_write_off_amount": baseWriteOffAmount,
        "write_off_outstanding_amount_automatically":
            writeOffOutstandingAmountAutomatically,
        "allocate_advances_automatically": allocateAdvancesAutomatically,
        "ignore_default_payment_terms_template":
            ignoreDefaultPaymentTermsTemplate,
        "payment_terms_template": paymentTermsTemplate,
        "base_paid_amount": basePaidAmount,
        "paid_amount": paidAmount,
        "base_change_amount": baseChangeAmount,
        "change_amount": changeAmount,
        "group_same_items": groupSameItems,
        "status": status,
        "customer_group": customerGroup,
        "is_internal_customer": isInternalCustomer,
        "is_discounted": isDiscounted,
        "debit_to": debitTo,
        "party_account_currency": partyAccountCurrency,
        "is_opening": isOpening,
        "c_form_applicable": cFormApplicable,
        "remarks": remarks,
        "amount_eligible_for_commission": amountEligibleForCommission,
        "commission_rate": commissionRate,
        "total_commission": totalCommission,
        "nomor_sales_order": nomorSalesOrder,
        "against_income_account": againstIncomeAccount,
        "doctype": doctype,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pricing_rules": pricingRules == null
            ? []
            : List<dynamic>.from(pricingRules!.map((x) => x)),
        "packed_items": packedItems == null
            ? []
            : List<dynamic>.from(packedItems!.map((x) => x)),
        "timesheets": timesheets == null
            ? []
            : List<dynamic>.from(timesheets!.map((x) => x)),
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
        "advances":
            advances == null ? [] : List<dynamic>.from(advances!.map((x) => x)),
        "payment_schedule": paymentSchedule == null
            ? []
            : List<dynamic>.from(paymentSchedule!.map((x) => x.toJson())),
        "payments":
            payments == null ? [] : List<dynamic>.from(payments!.map((x) => x)),
        "sales_team": salesTeam == null
            ? []
            : List<dynamic>.from(salesTeam!.map((x) => x.toJson())),
      };
}

class Item {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  num? idx;
  num? docstatus;
  num? batalKirim;
  String? itemCode;
  num? minimumPriceHint;
  num? maximumPriceHint;
  String? itemName;
  String? description;
  String? itemGroup;
  String? image;
  num? qty;
  String? stockUom;
  String? uom;
  num? conversionFactor;
  num? stockQty;
  num? priceListRate;
  num? basePriceListRate;
  String? marginType;
  num? marginRateOrAmount;
  num? rateWithMargin;
  num? discountPercentage;
  num? discountAmount;
  num? baseRateWithMargin;
  num? rate;
  num? amount;
  num? baseRate;
  num? baseAmount;
  num? stockUomRate;
  num? isFreeItem;
  num? grantCommission;
  num? netRate;
  num? netAmount;
  num? baseNetRate;
  num? baseNetAmount;
  num? deliveredBySupplier;
  String? incomeAccount;
  num? isFixedAsset;
  String? expenseAccount;
  num? enableDeferredRevenue;
  num? weightPerUnit;
  num? totalWeight;
  String? warehouse;
  num? incomingRate;
  num? allowZeroValuationRate;
  String? itemTaxRate;
  num? actualBatchQty;
  num? actualQty;
  String? salesOrder;
  String? soDetail;
  num? salesOrderAmount;
  String? deliveryNote;
  String? dnDetail;
  num? deliveredQty;
  String? costCenter;
  num? pageBreak;
  String? doctype;

  Item({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.batalKirim,
    this.itemCode,
    this.minimumPriceHint,
    this.maximumPriceHint,
    this.itemName,
    this.description,
    this.itemGroup,
    this.image,
    this.qty,
    this.stockUom,
    this.uom,
    this.conversionFactor,
    this.stockQty,
    this.priceListRate,
    this.basePriceListRate,
    this.marginType,
    this.marginRateOrAmount,
    this.rateWithMargin,
    this.discountPercentage,
    this.discountAmount,
    this.baseRateWithMargin,
    this.rate,
    this.amount,
    this.baseRate,
    this.baseAmount,
    this.stockUomRate,
    this.isFreeItem,
    this.grantCommission,
    this.netRate,
    this.netAmount,
    this.baseNetRate,
    this.baseNetAmount,
    this.deliveredBySupplier,
    this.incomeAccount,
    this.isFixedAsset,
    this.expenseAccount,
    this.enableDeferredRevenue,
    this.weightPerUnit,
    this.totalWeight,
    this.warehouse,
    this.incomingRate,
    this.allowZeroValuationRate,
    this.itemTaxRate,
    this.actualBatchQty,
    this.actualQty,
    this.salesOrder,
    this.soDetail,
    this.salesOrderAmount,
    this.deliveryNote,
    this.dnDetail,
    this.deliveredQty,
    this.costCenter,
    this.pageBreak,
    this.doctype,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        batalKirim: json["batal_kirim"],
        itemCode: json["item_code"],
        minimumPriceHint: json["minimum_price_hint"],
        maximumPriceHint: json["maximum_price_hint"],
        itemName: json["item_name"],
        description: json["description"],
        itemGroup: json["item_group"],
        image: json["image"],
        qty: json["qty"],
        stockUom: json["stock_uom"],
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
        stockQty: json["stock_qty"],
        priceListRate: json["price_list_rate"],
        basePriceListRate: json["base_price_list_rate"],
        marginType: json["margin_type"],
        marginRateOrAmount: json["margin_rate_or_amount"],
        rateWithMargin: json["rate_with_margin"],
        discountPercentage: json["discount_percentage"],
        discountAmount: json["discount_amount"],
        baseRateWithMargin: json["base_rate_with_margin"],
        rate: json["rate"],
        amount: json["amount"],
        baseRate: json["base_rate"],
        baseAmount: json["base_amount"],
        stockUomRate: json["stock_uom_rate"],
        isFreeItem: json["is_free_item"],
        grantCommission: json["grant_commission"],
        netRate: json["net_rate"],
        netAmount: json["net_amount"],
        baseNetRate: json["base_net_rate"],
        baseNetAmount: json["base_net_amount"],
        deliveredBySupplier: json["delivered_by_supplier"],
        incomeAccount: json["income_account"],
        isFixedAsset: json["is_fixed_asset"],
        expenseAccount: json["expense_account"],
        enableDeferredRevenue: json["enable_deferred_revenue"],
        weightPerUnit: json["weight_per_unit"],
        totalWeight: json["total_weight"],
        warehouse: json["warehouse"],
        incomingRate: json["incoming_rate"]?.toDouble(),
        allowZeroValuationRate: json["allow_zero_valuation_rate"],
        itemTaxRate: json["item_tax_rate"],
        actualBatchQty: json["actual_batch_qty"],
        actualQty: json["actual_qty"],
        salesOrder: json["sales_order"],
        soDetail: json["so_detail"],
        salesOrderAmount: json["sales_order_amount"],
        deliveryNote: json["delivery_note"],
        dnDetail: json["dn_detail"],
        deliveredQty: json["delivered_qty"],
        costCenter: json["cost_center"],
        pageBreak: json["page_break"],
        doctype: json["doctype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "batal_kirim": batalKirim,
        "item_code": itemCode,
        "minimum_price_hint": minimumPriceHint,
        "maximum_price_hint": maximumPriceHint,
        "item_name": itemName,
        "description": description,
        "item_group": itemGroup,
        "image": image,
        "qty": qty,
        "stock_uom": stockUom,
        "uom": uom,
        "conversion_factor": conversionFactor,
        "stock_qty": stockQty,
        "price_list_rate": priceListRate,
        "base_price_list_rate": basePriceListRate,
        "margin_type": marginType,
        "margin_rate_or_amount": marginRateOrAmount,
        "rate_with_margin": rateWithMargin,
        "discount_percentage": discountPercentage,
        "discount_amount": discountAmount,
        "base_rate_with_margin": baseRateWithMargin,
        "rate": rate,
        "amount": amount,
        "base_rate": baseRate,
        "base_amount": baseAmount,
        "stock_uom_rate": stockUomRate,
        "is_free_item": isFreeItem,
        "grant_commission": grantCommission,
        "net_rate": netRate,
        "net_amount": netAmount,
        "base_net_rate": baseNetRate,
        "base_net_amount": baseNetAmount,
        "delivered_by_supplier": deliveredBySupplier,
        "income_account": incomeAccount,
        "is_fixed_asset": isFixedAsset,
        "expense_account": expenseAccount,
        "enable_deferred_revenue": enableDeferredRevenue,
        "weight_per_unit": weightPerUnit,
        "total_weight": totalWeight,
        "warehouse": warehouse,
        "incoming_rate": incomingRate,
        "allow_zero_valuation_rate": allowZeroValuationRate,
        "item_tax_rate": itemTaxRate,
        "actual_batch_qty": actualBatchQty,
        "actual_qty": actualQty,
        "sales_order": salesOrder,
        "so_detail": soDetail,
        "sales_order_amount": salesOrderAmount,
        "delivery_note": deliveryNote,
        "dn_detail": dnDetail,
        "delivered_qty": deliveredQty,
        "cost_center": costCenter,
        "page_break": pageBreak,
        "doctype": doctype,
      };
}

class PaymentSchedule {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  num? idx;
  num? docstatus;
  String? paymentTerm;
  String? description;
  DateTime? dueDate;
  num? invoicePortion;
  String? discountType;
  DateTime? discountDate;
  num? discount;
  num? paymentAmount;
  num? outstanding;
  num? paidAmount;
  num? discountedAmount;
  num? basePaymentAmount;
  String? doctype;

  PaymentSchedule({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.paymentTerm,
    this.description,
    this.dueDate,
    this.invoicePortion,
    this.discountType,
    this.discountDate,
    this.discount,
    this.paymentAmount,
    this.outstanding,
    this.paidAmount,
    this.discountedAmount,
    this.basePaymentAmount,
    this.doctype,
  });

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      PaymentSchedule(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        paymentTerm: json["payment_term"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        invoicePortion: json["invoice_portion"],
        discountType: json["discount_type"],
        discountDate: json["discount_date"] == null
            ? null
            : DateTime.parse(json["discount_date"]),
        discount: json["discount"],
        paymentAmount: json["payment_amount"],
        outstanding: json["outstanding"],
        paidAmount: json["paid_amount"],
        discountedAmount: json["discounted_amount"],
        basePaymentAmount: json["base_payment_amount"],
        doctype: json["doctype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "payment_term": paymentTerm,
        "description": description,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "invoice_portion": invoicePortion,
        "discount_type": discountType,
        "discount_date":
            "${discountDate!.year.toString().padLeft(4, '0')}-${discountDate!.month.toString().padLeft(2, '0')}-${discountDate!.day.toString().padLeft(2, '0')}",
        "discount": discount,
        "payment_amount": paymentAmount,
        "outstanding": outstanding,
        "paid_amount": paidAmount,
        "discounted_amount": discountedAmount,
        "base_payment_amount": basePaymentAmount,
        "doctype": doctype,
      };
}

class SalesTeam {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  num? idx;
  num? docstatus;
  String? salesPerson;
  num? allocatedPercentage;
  num? allocatedAmount;
  num? incentives;
  String? doctype;

  SalesTeam({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.salesPerson,
    this.allocatedPercentage,
    this.allocatedAmount,
    this.incentives,
    this.doctype,
  });

  factory SalesTeam.fromJson(Map<String, dynamic> json) => SalesTeam(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        salesPerson: json["sales_person"],
        allocatedPercentage: json["allocated_percentage"],
        allocatedAmount: json["allocated_amount"],
        incentives: json["incentives"],
        doctype: json["doctype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "docstatus": docstatus,
        "sales_person": salesPerson,
        "allocated_percentage": allocatedPercentage,
        "allocated_amount": allocatedAmount,
        "incentives": incentives,
        "doctype": doctype,
      };
}
