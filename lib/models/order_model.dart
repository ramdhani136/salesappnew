import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? idx;
  num? docstatus;
  String? workflowState;
  String? title;
  String? namingSeries;
  String? customer;
  String? customerName;
  String? orderType;
  num? needPurchase;
  num? skipDeliveryNote;
  String? taxStatus;
  String? voucherCoupon;
  String? statusVoucher;
  String? opsiPengiriman;
  String? lokasi;
  String? keteranganDic;
  String? keteranganPurchasing;
  String? company;
  DateTime? transactionDate;
  DateTime? deliveryDate;
  num? customerCash;
  num? soTidakDigabung;
  String? statusBarang;
  DateTime? tanggalBarangDatang;
  String? sales;
  DateTime? datetimeSales;
  String? purchasing;
  DateTime? datetimePurchasing;
  String? koordinator;
  DateTime? datetimeKoordinator;
  String? supervisor;
  String? dic;
  DateTime? datetimeDic;
  String? customerAddress;
  String? addressDisplay;
  String? companyAddress;
  String? companyAddressDisplay;
  String? shippingAddressName;
  String? customerGroup;
  String? territory;
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
  num? loyaltyPoints;
  num? loyaltyAmount;
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
  num? advancePaid;
  num? disableRoundedTotal;
  String? paymentTermsTemplate;
  num? isInternalCustomer;
  String? partyAccountCurrency;
  num? groupSameItems;
  String? status;
  String? deliveryStatus;
  num? perDelivered;
  num? perBilled;
  num? perPicked;
  String? billingStatus;
  num? amountEligibleForCommission;
  num? commissionRate;
  num? totalCommission;
  num? isReturn;
  String? doctype;
  List<Item>? items;
  List<dynamic>? packedItems;
  List<dynamic>? pricingRules;
  List<dynamic>? taxes;
  List<PaymentSchedule>? paymentSchedule;
  List<SalesTeam>? salesTeam;

  OrderModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.workflowState,
    this.title,
    this.namingSeries,
    this.customer,
    this.customerName,
    this.orderType,
    this.needPurchase,
    this.skipDeliveryNote,
    this.taxStatus,
    this.voucherCoupon,
    this.statusVoucher,
    this.opsiPengiriman,
    this.lokasi,
    this.keteranganDic,
    this.keteranganPurchasing,
    this.company,
    this.transactionDate,
    this.deliveryDate,
    this.customerCash,
    this.soTidakDigabung,
    this.statusBarang,
    this.tanggalBarangDatang,
    this.sales,
    this.datetimeSales,
    this.purchasing,
    this.datetimePurchasing,
    this.koordinator,
    this.datetimeKoordinator,
    this.supervisor,
    this.dic,
    this.datetimeDic,
    this.customerAddress,
    this.addressDisplay,
    this.companyAddress,
    this.companyAddressDisplay,
    this.shippingAddressName,
    this.customerGroup,
    this.territory,
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
    this.loyaltyPoints,
    this.loyaltyAmount,
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
    this.advancePaid,
    this.disableRoundedTotal,
    this.paymentTermsTemplate,
    this.isInternalCustomer,
    this.partyAccountCurrency,
    this.groupSameItems,
    this.status,
    this.deliveryStatus,
    this.perDelivered,
    this.perBilled,
    this.perPicked,
    this.billingStatus,
    this.amountEligibleForCommission,
    this.commissionRate,
    this.totalCommission,
    this.isReturn,
    this.doctype,
    this.items,
    this.packedItems,
    this.pricingRules,
    this.taxes,
    this.paymentSchedule,
    this.salesTeam,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
        title: json["title"],
        namingSeries: json["naming_series"],
        customer: json["customer"],
        customerName: json["customer_name"],
        orderType: json["order_type"],
        needPurchase: json["need_purchase"],
        skipDeliveryNote: json["skip_delivery_note"],
        taxStatus: json["tax_status"],
        voucherCoupon: json["voucher_coupon"],
        statusVoucher: json["status_voucher"],
        opsiPengiriman: json["opsi_pengiriman"],
        lokasi: json["lokasi"],
        keteranganDic: json["keterangan_dic"],
        keteranganPurchasing: json["keterangan_purchasing"],
        company: json["company"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        customerCash: json["customer_cash"],
        soTidakDigabung: json["so_tidak_digabung"],
        statusBarang: json["status_barang"],
        tanggalBarangDatang: json["tanggal_barang_datang"] == null
            ? null
            : DateTime.parse(json["tanggal_barang_datang"]),
        sales: json["sales"],
        datetimeSales: json["datetime_sales"] == null
            ? null
            : DateTime.parse(json["datetime_sales"]),
        purchasing: json["purchasing"],
        datetimePurchasing: json["datetime_purchasing"] == null
            ? null
            : DateTime.parse(json["datetime_purchasing"]),
        koordinator: json["koordinator"],
        datetimeKoordinator: json["datetime_koordinator"] == null
            ? null
            : DateTime.parse(json["datetime_koordinator"]),
        supervisor: json["supervisor"],
        dic: json["dic"],
        datetimeDic: json["datetime_dic"] == null
            ? null
            : DateTime.parse(json["datetime_dic"]),
        customerAddress: json["customer_address"],
        addressDisplay: json["address_display"],
        companyAddress: json["company_address"],
        companyAddressDisplay: json["company_address_display"],
        shippingAddressName: json["shipping_address_name"],
        customerGroup: json["customer_group"],
        territory: json["territory"],
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
        loyaltyPoints: json["loyalty_points"],
        loyaltyAmount: json["loyalty_amount"],
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
        advancePaid: json["advance_paid"],
        disableRoundedTotal: json["disable_rounded_total"],
        paymentTermsTemplate: json["payment_terms_template"],
        isInternalCustomer: json["is_internal_customer"],
        partyAccountCurrency: json["party_account_currency"],
        groupSameItems: json["group_same_items"],
        status: json["status"],
        deliveryStatus: json["delivery_status"],
        perDelivered: json["per_delivered"],
        perBilled: json["per_billed"],
        perPicked: json["per_picked"],
        billingStatus: json["billing_status"],
        amountEligibleForCommission: json["amount_eligible_for_commission"],
        commissionRate: json["commission_rate"],
        totalCommission: json["total_commission"],
        isReturn: json["is_return"],
        doctype: json["doctype"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        packedItems: json["packed_items"] == null
            ? []
            : List<dynamic>.from(json["packed_items"]!.map((x) => x)),
        pricingRules: json["pricing_rules"] == null
            ? []
            : List<dynamic>.from(json["pricing_rules"]!.map((x) => x)),
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
        paymentSchedule: json["payment_schedule"] == null
            ? []
            : List<PaymentSchedule>.from(json["payment_schedule"]!
                .map((x) => PaymentSchedule.fromJson(x))),
        salesTeam: json["sales_team"] == null
            ? []
            : List<SalesTeam>.from(
                json["sales_team"]!.map((x) => SalesTeam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "workflow_state": workflowState,
        "title": title,
        "naming_series": namingSeries,
        "customer": customer,
        "customer_name": customerName,
        "order_type": orderType,
        "need_purchase": needPurchase,
        "skip_delivery_note": skipDeliveryNote,
        "tax_status": taxStatus,
        "voucher_coupon": voucherCoupon,
        "status_voucher": statusVoucher,
        "opsi_pengiriman": opsiPengiriman,
        "lokasi": lokasi,
        "keterangan_dic": keteranganDic,
        "keterangan_purchasing": keteranganPurchasing,
        "company": company,
        "transaction_date":
            "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "customer_cash": customerCash,
        "so_tidak_digabung": soTidakDigabung,
        "status_barang": statusBarang,
        "tanggal_barang_datang":
            "${tanggalBarangDatang!.year.toString().padLeft(4, '0')}-${tanggalBarangDatang!.month.toString().padLeft(2, '0')}-${tanggalBarangDatang!.day.toString().padLeft(2, '0')}",
        "sales": sales,
        "datetime_sales": datetimeSales?.toIso8601String(),
        "purchasing": purchasing,
        "datetime_purchasing": datetimePurchasing?.toIso8601String(),
        "koordinator": koordinator,
        "datetime_koordinator": datetimeKoordinator?.toIso8601String(),
        "supervisor": supervisor,
        "dic": dic,
        "datetime_dic": datetimeDic?.toIso8601String(),
        "customer_address": customerAddress,
        "address_display": addressDisplay,
        "company_address": companyAddress,
        "company_address_display": companyAddressDisplay,
        "shipping_address_name": shippingAddressName,
        "customer_group": customerGroup,
        "territory": territory,
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
        "loyalty_points": loyaltyPoints,
        "loyalty_amount": loyaltyAmount,
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
        "advance_paid": advancePaid,
        "disable_rounded_total": disableRoundedTotal,
        "payment_terms_template": paymentTermsTemplate,
        "is_internal_customer": isInternalCustomer,
        "party_account_currency": partyAccountCurrency,
        "group_same_items": groupSameItems,
        "status": status,
        "delivery_status": deliveryStatus,
        "per_delivered": perDelivered,
        "per_billed": perBilled,
        "per_picked": perPicked,
        "billing_status": billingStatus,
        "amount_eligible_for_commission": amountEligibleForCommission,
        "commission_rate": commissionRate,
        "total_commission": totalCommission,
        "is_return": isReturn,
        "doctype": doctype,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "packed_items": packedItems == null
            ? []
            : List<dynamic>.from(packedItems!.map((x) => x)),
        "pricing_rules": pricingRules == null
            ? []
            : List<dynamic>.from(pricingRules!.map((x) => x)),
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
        "payment_schedule": paymentSchedule == null
            ? []
            : List<dynamic>.from(paymentSchedule!.map((x) => x.toJson())),
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
  String? itemCode;
  num? ensureDeliveryBasedOnProducedSerialNo;
  num? minimumPriceHint;
  num? maximumPriceHint;
  DateTime? deliveryDate;
  num? soTidakDigabung;
  String? itemName;
  String? description;
  String? itemGroup;
  String? image;
  num? qty;
  String? stockUom;
  num? pickedQty;
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
  num? billedAmt;
  double? valuationRate;
  num? grossProfit;
  num? bottomPrice;
  num? deliveredBySupplier;
  num? weightPerUnit;
  num? totalWeight;
  String? warehouse;
  num? againstBlanketOrder;
  num? blanketOrderRate;
  num? projectedQty;
  num? actualQty;
  num? orderedQty;
  num? plannedQty;
  num? workOrderQty;
  num? producedQty;
  num? deliveredQty;
  num? netStockAvailable;
  num? returnedQty;
  num? pageBreak;
  String? itemTaxRate;
  DateTime? transactionDate;
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
    this.itemCode,
    this.ensureDeliveryBasedOnProducedSerialNo,
    this.minimumPriceHint,
    this.maximumPriceHint,
    this.deliveryDate,
    this.soTidakDigabung,
    this.itemName,
    this.description,
    this.itemGroup,
    this.image,
    this.qty,
    this.stockUom,
    this.pickedQty,
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
    this.billedAmt,
    this.valuationRate,
    this.grossProfit,
    this.bottomPrice,
    this.deliveredBySupplier,
    this.weightPerUnit,
    this.totalWeight,
    this.warehouse,
    this.againstBlanketOrder,
    this.blanketOrderRate,
    this.projectedQty,
    this.actualQty,
    this.orderedQty,
    this.plannedQty,
    this.workOrderQty,
    this.producedQty,
    this.deliveredQty,
    this.netStockAvailable,
    this.returnedQty,
    this.pageBreak,
    this.itemTaxRate,
    this.transactionDate,
    this.doctype,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        // name: json["name"],
        // owner: json["owner"],
        // creation:
        //     json["creation"] == null ? null : DateTime.parse(json["creation"]),
        // modified:
        //     json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        itemCode: json["item_code"],
        ensureDeliveryBasedOnProducedSerialNo:
            json["ensure_delivery_based_on_produced_serial_no"],
        minimumPriceHint: json["minimum_price_hint"],
        maximumPriceHint: json["maximum_price_hint"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        soTidakDigabung: json["so_tidak_digabung"],
        itemName: json["item_name"],
        description: json["description"],
        itemGroup: json["item_group"],
        image: json["image"],
        qty: json["qty"],
        stockUom: json["stock_uom"],
        pickedQty: json["picked_qty"],
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
        billedAmt: json["billed_amt"],
        valuationRate: json["valuation_rate"]?.toDouble(),
        grossProfit: json["gross_profit"],
        bottomPrice: json["bottom_price"],
        deliveredBySupplier: json["delivered_by_supplier"],
        weightPerUnit: json["weight_per_unit"],
        totalWeight: json["total_weight"],
        warehouse: json["warehouse"],
        againstBlanketOrder: json["against_blanket_order"],
        blanketOrderRate: json["blanket_order_rate"],
        projectedQty: json["projected_qty"],
        actualQty: json["actual_qty"],
        orderedQty: json["ordered_qty"],
        plannedQty: json["planned_qty"],
        workOrderQty: json["work_order_qty"],
        producedQty: json["produced_qty"],
        deliveredQty: json["delivered_qty"],
        netStockAvailable: json["net_stock_available"],
        returnedQty: json["returned_qty"],
        pageBreak: json["page_break"],
        itemTaxRate: json["item_tax_rate"],
        transactionDate: json["transaction_date"] == null
            ? null
            : DateTime.parse(json["transaction_date"]),
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
        "item_code": itemCode,
        "ensure_delivery_based_on_produced_serial_no":
            ensureDeliveryBasedOnProducedSerialNo,
        "minimum_price_hint": minimumPriceHint,
        "maximum_price_hint": maximumPriceHint,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "so_tidak_digabung": soTidakDigabung,
        "item_name": itemName,
        "description": description,
        "item_group": itemGroup,
        "image": image,
        "qty": qty,
        "stock_uom": stockUom,
        "picked_qty": pickedQty,
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
        "billed_amt": billedAmt,
        "valuation_rate": valuationRate,
        "gross_profit": grossProfit,
        "bottom_price": bottomPrice,
        "delivered_by_supplier": deliveredBySupplier,
        "weight_per_unit": weightPerUnit,
        "total_weight": totalWeight,
        "warehouse": warehouse,
        "against_blanket_order": againstBlanketOrder,
        "blanket_order_rate": blanketOrderRate,
        "projected_qty": projectedQty,
        "actual_qty": actualQty,
        "ordered_qty": orderedQty,
        "planned_qty": plannedQty,
        "work_order_qty": workOrderQty,
        "produced_qty": producedQty,
        "delivered_qty": deliveredQty,
        "net_stock_available": netStockAvailable,
        "returned_qty": returnedQty,
        "page_break": pageBreak,
        "item_tax_rate": itemTaxRate,
        "transaction_date":
            "${transactionDate!.year.toString().padLeft(4, '0')}-${transactionDate!.month.toString().padLeft(2, '0')}-${transactionDate!.day.toString().padLeft(2, '0')}",
        "doctype": doctype,
      };

  static List<OrderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderModel.fromJson(json)).toList();
  }
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
