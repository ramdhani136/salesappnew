import 'dart:convert';

DnModel dnModelFromJson(String str) => DnModel.fromJson(json.decode(str));

String dnModelToJson(DnModel data) => json.encode(data.toJson());

class DnModel {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? workflowState;
  String? confirmationDocument;
  String? title;
  String? namingSeries;
  String? customer;
  String? catatan;
  num? kirimanLangsung;
  num? noteSudahDibaca;
  String? customerName;
  String? taxStatus;
  String? voucherCoupon;
  String? opsiPengiriman;
  String? company;
  DateTime? postingDate;
  String? postingTime;
  num? setPostingTime;
  num? customerCash;
  num? isReturn;
  num? barangSudahTerkirim;
  num? issueCreditNote;
  String? poNo;
  String? shippingAddressName;
  String? customerAddress;
  String? addressDisplay;
  String? companyAddress;
  String? companyAddressDisplay;
  String? currency;
  num? conversionRate;
  String? sellingPriceList;
  String? priceListCurrency;
  num? plcConversionRate;
  num? ignorePricingRule;
  String? setWarehouse;
  num? totalQty;
  num? baseTotal;
  num? baseNetTotal;
  num? totalNetWeight;
  num? total;
  num? netTotal;
  String? taxCategory;
  num? baseTotalTaxesAndCharges;
  num? totalTaxesAndCharges;
  String? couponCode;
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
  num? disableRoundedTotal;
  DateTime? lrDate;
  num? isInternalCustomer;
  num? perBilled;
  String? customerGroup;
  String? territory;
  num? printWithoutAmount;
  num? groupSameItems;
  String? status;
  num? perInstalled;
  String? installationStatus;
  num? perReturned;
  num? amountEligibleForCommission;
  num? commissionRate;
  num? totalCommission;
  String? doctype;
  List<Item>? items;
  List<dynamic>? pricingRules;
  List<dynamic>? packedItems;
  List<dynamic>? taxes;
  List<SalesTeam>? salesTeam;

  DnModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.workflowState,
    this.confirmationDocument,
    this.title,
    this.namingSeries,
    this.customer,
    this.catatan,
    this.kirimanLangsung,
    this.noteSudahDibaca,
    this.customerName,
    this.taxStatus,
    this.voucherCoupon,
    this.opsiPengiriman,
    this.company,
    this.postingDate,
    this.postingTime,
    this.setPostingTime,
    this.customerCash,
    this.isReturn,
    this.barangSudahTerkirim,
    this.issueCreditNote,
    this.poNo,
    this.shippingAddressName,
    this.customerAddress,
    this.addressDisplay,
    this.companyAddress,
    this.companyAddressDisplay,
    this.currency,
    this.conversionRate,
    this.sellingPriceList,
    this.priceListCurrency,
    this.plcConversionRate,
    this.ignorePricingRule,
    this.setWarehouse,
    this.totalQty,
    this.baseTotal,
    this.baseNetTotal,
    this.totalNetWeight,
    this.total,
    this.netTotal,
    this.taxCategory,
    this.baseTotalTaxesAndCharges,
    this.totalTaxesAndCharges,
    this.couponCode,
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
    this.disableRoundedTotal,
    this.lrDate,
    this.isInternalCustomer,
    this.perBilled,
    this.customerGroup,
    this.territory,
    this.printWithoutAmount,
    this.groupSameItems,
    this.status,
    this.perInstalled,
    this.installationStatus,
    this.perReturned,
    this.amountEligibleForCommission,
    this.commissionRate,
    this.totalCommission,
    this.doctype,
    this.items,
    this.pricingRules,
    this.packedItems,
    this.taxes,
    this.salesTeam,
  });

  factory DnModel.fromJson(Map<String, dynamic> json) => DnModel(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        workflowState: json["workflow_state"],
        confirmationDocument: json["confirmation_document"],
        title: json["title"],
        namingSeries: json["naming_series"],
        customer: json["customer"],
        catatan: json["catatan"],
        kirimanLangsung: json["kiriman_langsung"],
        noteSudahDibaca: json["note_sudah_dibaca"],
        customerName: json["customer_name"],
        taxStatus: json["tax_status"],
        voucherCoupon: json["voucher_coupon"],
        opsiPengiriman: json["opsi_pengiriman"],
        company: json["company"],
        postingDate: json["posting_date"] == null
            ? null
            : DateTime.parse(json["posting_date"]),
        postingTime: json["posting_time"],
        setPostingTime: json["set_posting_time"],
        customerCash: json["customer_cash"],
        isReturn: json["is_return"],
        barangSudahTerkirim: json["barang_sudah_terkirim"],
        issueCreditNote: json["issue_credit_note"],
        poNo: json["po_no"],
        shippingAddressName: json["shipping_address_name"],
        customerAddress: json["customer_address"],
        addressDisplay: json["address_display"],
        companyAddress: json["company_address"],
        companyAddressDisplay: json["company_address_display"],
        currency: json["currency"],
        conversionRate: json["conversion_rate"],
        sellingPriceList: json["selling_price_list"],
        priceListCurrency: json["price_list_currency"],
        plcConversionRate: json["plc_conversion_rate"],
        ignorePricingRule: json["ignore_pricing_rule"],
        setWarehouse: json["set_warehouse"],
        totalQty: json["total_qty"],
        baseTotal: json["base_total"],
        baseNetTotal: json["base_net_total"],
        totalNetWeight: json["total_net_weight"],
        total: json["total"],
        netTotal: json["net_total"],
        taxCategory: json["tax_category"],
        baseTotalTaxesAndCharges: json["base_total_taxes_and_charges"],
        totalTaxesAndCharges: json["total_taxes_and_charges"],
        couponCode: json["coupon_code"],
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
        disableRoundedTotal: json["disable_rounded_total"],
        lrDate:
            json["lr_date"] == null ? null : DateTime.parse(json["lr_date"]),
        isInternalCustomer: json["is_internal_customer"],
        perBilled: json["per_billed"],
        customerGroup: json["customer_group"],
        territory: json["territory"],
        printWithoutAmount: json["print_without_amount"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        perInstalled: json["per_installed"],
        installationStatus: json["installation_status"],
        perReturned: json["per_returned"],
        amountEligibleForCommission: json["amount_eligible_for_commission"],
        commissionRate: json["commission_rate"],
        totalCommission: json["total_commission"],
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
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
        salesTeam: json["sales_team"] == null
            ? []
            : List<SalesTeam>.from(
                json["sales_team"]!.map((x) => SalesTeam.fromJson(x))),
      );

  static List<DnModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DnModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "workflow_state": workflowState,
        "confirmation_document": confirmationDocument,
        "title": title,
        "naming_series": namingSeries,
        "customer": customer,
        "catatan": catatan,
        "kiriman_langsung": kirimanLangsung,
        "note_sudah_dibaca": noteSudahDibaca,
        "customer_name": customerName,
        "tax_status": taxStatus,
        "voucher_coupon": voucherCoupon,
        "opsi_pengiriman": opsiPengiriman,
        "company": company,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "posting_time": postingTime,
        "set_posting_time": setPostingTime,
        "customer_cash": customerCash,
        "is_return": isReturn,
        "barang_sudah_terkirim": barangSudahTerkirim,
        "issue_credit_note": issueCreditNote,
        "po_no": poNo,
        "shipping_address_name": shippingAddressName,
        "customer_address": customerAddress,
        "address_display": addressDisplay,
        "company_address": companyAddress,
        "company_address_display": companyAddressDisplay,
        "currency": currency,
        "conversion_rate": conversionRate,
        "selling_price_list": sellingPriceList,
        "price_list_currency": priceListCurrency,
        "plc_conversion_rate": plcConversionRate,
        "ignore_pricing_rule": ignorePricingRule,
        "set_warehouse": setWarehouse,
        "total_qty": totalQty,
        "base_total": baseTotal,
        "base_net_total": baseNetTotal,
        "total_net_weight": totalNetWeight,
        "total": total,
        "net_total": netTotal,
        "tax_category": taxCategory,
        "base_total_taxes_and_charges": baseTotalTaxesAndCharges,
        "total_taxes_and_charges": totalTaxesAndCharges,
        "coupon_code": couponCode,
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
        "disable_rounded_total": disableRoundedTotal,
        "lr_date":
            "${lrDate!.year.toString().padLeft(4, '0')}-${lrDate!.month.toString().padLeft(2, '0')}-${lrDate!.day.toString().padLeft(2, '0')}",
        "is_internal_customer": isInternalCustomer,
        "per_billed": perBilled,
        "customer_group": customerGroup,
        "territory": territory,
        "print_without_amount": printWithoutAmount,
        "group_same_items": groupSameItems,
        "status": status,
        "per_installed": perInstalled,
        "installation_status": installationStatus,
        "per_returned": perReturned,
        "amount_eligible_for_commission": amountEligibleForCommission,
        "commission_rate": commissionRate,
        "total_commission": totalCommission,
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
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
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
  String? itemName;
  num? soTidakDigabung;
  String? keteranganMuat;
  String? keteranganCheck;
  String? catatan;
  num? qtyPpn;
  String? description;
  String? itemGroup;
  String? image;
  num? qtyOrdered;
  num? ppnQty;
  num? qty;
  String? stockUom;
  String? uom;
  num? conversionFactor;
  num? stockQty;
  num? returnedQty;
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
  num? billedAmt;
  num? incomingRate;
  num? weightPerUnit;
  num? totalWeight;
  String? warehouse;
  String? againstSalesOrder;
  String? soDetail;
  num? actualBatchQty;
  num? actualQty;
  num? installedQty;
  String? itemTaxRate;
  String? expenseAccount;
  num? allowZeroValuationRate;
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
    this.itemName,
    this.soTidakDigabung,
    this.keteranganMuat,
    this.keteranganCheck,
    this.catatan,
    this.qtyPpn,
    this.description,
    this.itemGroup,
    this.image,
    this.qtyOrdered,
    this.ppnQty,
    this.qty,
    this.stockUom,
    this.uom,
    this.conversionFactor,
    this.stockQty,
    this.returnedQty,
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
    this.billedAmt,
    this.incomingRate,
    this.weightPerUnit,
    this.totalWeight,
    this.warehouse,
    this.againstSalesOrder,
    this.soDetail,
    this.actualBatchQty,
    this.actualQty,
    this.installedQty,
    this.itemTaxRate,
    this.expenseAccount,
    this.allowZeroValuationRate,
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
        itemName: json["item_name"],
        soTidakDigabung: json["so_tidak_digabung"],
        keteranganMuat: json["keterangan_muat"],
        keteranganCheck: json["keterangan_check"],
        catatan: json["catatan"],
        qtyPpn: json["qty_ppn"],
        description: json["description"],
        itemGroup: json["item_group"],
        image: json["image"],
        qtyOrdered: json["qty_ordered"],
        ppnQty: json["ppn_qty"],
        qty: json["qty"],
        stockUom: json["stock_uom"],
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
        stockQty: json["stock_qty"],
        returnedQty: json["returned_qty"],
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
        billedAmt: json["billed_amt"],
        incomingRate: json["incoming_rate"],
        weightPerUnit: json["weight_per_unit"],
        totalWeight: json["total_weight"],
        warehouse: json["warehouse"],
        againstSalesOrder: json["against_sales_order"],
        soDetail: json["so_detail"],
        actualBatchQty: json["actual_batch_qty"],
        actualQty: json["actual_qty"],
        installedQty: json["installed_qty"],
        itemTaxRate: json["item_tax_rate"],
        expenseAccount: json["expense_account"],
        allowZeroValuationRate: json["allow_zero_valuation_rate"],
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
        "item_name": itemName,
        "so_tidak_digabung": soTidakDigabung,
        "keterangan_muat": keteranganMuat,
        "keterangan_check": keteranganCheck,
        "catatan": catatan,
        "qty_ppn": qtyPpn,
        "description": description,
        "item_group": itemGroup,
        "image": image,
        "qty_ordered": qtyOrdered,
        "ppn_qty": ppnQty,
        "qty": qty,
        "stock_uom": stockUom,
        "uom": uom,
        "conversion_factor": conversionFactor,
        "stock_qty": stockQty,
        "returned_qty": returnedQty,
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
        "billed_amt": billedAmt,
        "incoming_rate": incomingRate,
        "weight_per_unit": weightPerUnit,
        "total_weight": totalWeight,
        "warehouse": warehouse,
        "against_sales_order": againstSalesOrder,
        "so_detail": soDetail,
        "actual_batch_qty": actualBatchQty,
        "actual_qty": actualQty,
        "installed_qty": installedQty,
        "item_tax_rate": itemTaxRate,
        "expense_account": expenseAccount,
        "allow_zero_valuation_rate": allowZeroValuationRate,
        "cost_center": costCenter,
        "page_break": pageBreak,
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
