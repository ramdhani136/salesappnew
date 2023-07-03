// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? image;
  num? idx;
  num? docstatus;
  String? workflowState;
  String? namingSeries;
  String? itemCode;
  String? itemName;
  String? itemGroup;
  String? stocker;
  String? kategoriBarang;
  String? keteranganBarang;
  String? subKategori;
  num? isItemFromHub;
  String? stockUom;
  String? jenisBarang;
  String? klasifikasiBarang;
  num? disabled;
  num? allowAlternativeItem;
  num? isStockItem;
  num? includeItemInManufacturing;
  num? openingStock;
  num? valuationRate;
  num? standardRate;
  num? isFixedAsset;
  num? autoCreateAssets;
  num? overDeliveryReceiptAllowance;
  num? overBillingAllowance;
  String? description;
  num? isUseQrCode;
  num? quantityOfItemsPerQrCode;
  num? shelfLifeInDays;
  DateTime? endOfLife;
  String? defaultMaterialRequestType;
  String? valuationMethod;
  num? weightPerUnit;
  num? hasBatchNo;
  num? createNewBatch;
  num? hasExpiryDate;
  num? retainSample;
  num? sampleQuantity;
  num? hasSerialNo;
  num? hasVariants;
  String? variantBasedOn;
  num? isPurchaseItem;
  num? minOrderQty;
  num? safetyStock;
  num? leadTimeDays;
  num? lastPurchaseRate;
  num? isCustomerProvidedItem;
  num? deliveredBySupplier;
  String? countryOfOrigin;
  num? isSalesItem;
  num? grantCommission;
  num? maxDiscount;
  num? enableDeferredRevenue;
  num? noOfMonths;
  num? enableDeferredExpense;
  num? noOfMonthsExp;
  num? inspectionRequiredBeforePurchase;
  num? inspectionRequiredBeforeDelivery;
  num? isSubContractedItem;
  String? customerCode;
  num? publishInHub;
  num? syncedWithHub;
  num? publishedInWebsite;
  num? totalProjectedQty;
  String? doctype;
  List<dynamic>? barcodes;
  List<dynamic>? reorderLevels;
  List<Uom>? uoms;
  List<dynamic>? attributes;
  List<ItemDefault>? itemDefaults;
  List<dynamic>? supplierItems;
  List<dynamic>? customerItems;
  List<dynamic>? taxes;

  ItemModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.image,
    this.docstatus,
    this.workflowState,
    this.namingSeries,
    this.itemCode,
    this.itemName,
    this.itemGroup,
    this.stocker,
    this.kategoriBarang,
    this.keteranganBarang,
    this.subKategori,
    this.isItemFromHub,
    this.stockUom,
    this.jenisBarang,
    this.klasifikasiBarang,
    this.disabled,
    this.allowAlternativeItem,
    this.isStockItem,
    this.includeItemInManufacturing,
    this.openingStock,
    this.valuationRate,
    this.standardRate,
    this.isFixedAsset,
    this.autoCreateAssets,
    this.overDeliveryReceiptAllowance,
    this.overBillingAllowance,
    this.description,
    this.isUseQrCode,
    this.quantityOfItemsPerQrCode,
    this.shelfLifeInDays,
    this.endOfLife,
    this.defaultMaterialRequestType,
    this.valuationMethod,
    this.weightPerUnit,
    this.hasBatchNo,
    this.createNewBatch,
    this.hasExpiryDate,
    this.retainSample,
    this.sampleQuantity,
    this.hasSerialNo,
    this.hasVariants,
    this.variantBasedOn,
    this.isPurchaseItem,
    this.minOrderQty,
    this.safetyStock,
    this.leadTimeDays,
    this.lastPurchaseRate,
    this.isCustomerProvidedItem,
    this.deliveredBySupplier,
    this.countryOfOrigin,
    this.isSalesItem,
    this.grantCommission,
    this.maxDiscount,
    this.enableDeferredRevenue,
    this.noOfMonths,
    this.enableDeferredExpense,
    this.noOfMonthsExp,
    this.inspectionRequiredBeforePurchase,
    this.inspectionRequiredBeforeDelivery,
    this.isSubContractedItem,
    this.customerCode,
    this.publishInHub,
    this.syncedWithHub,
    this.publishedInWebsite,
    this.totalProjectedQty,
    this.doctype,
    this.barcodes,
    this.reorderLevels,
    this.uoms,
    this.attributes,
    this.itemDefaults,
    this.supplierItems,
    this.customerItems,
    this.taxes,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        name: json["name"],
        image: json["image"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        idx: json["idx"],
        docstatus: json["docstatus"],
        workflowState: json["workflow_state"],
        namingSeries: json["naming_series"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        itemGroup: json["item_group"],
        stocker: json["stocker"],
        kategoriBarang: json["kategori_barang"],
        keteranganBarang: json["keterangan_barang"],
        subKategori: json["sub_kategori"],
        isItemFromHub: json["is_item_from_hub"],
        stockUom: json["stock_uom"],
        jenisBarang: json["jenis_barang"],
        klasifikasiBarang: json["klasifikasi_barang"],
        disabled: json["disabled"],
        allowAlternativeItem: json["allow_alternative_item"],
        isStockItem: json["is_stock_item"],
        includeItemInManufacturing: json["include_item_in_manufacturing"],
        openingStock: json["opening_stock"],
        valuationRate: json["valuation_rate"],
        standardRate: json["standard_rate"],
        isFixedAsset: json["is_fixed_asset"],
        autoCreateAssets: json["auto_create_assets"],
        overDeliveryReceiptAllowance: json["over_delivery_receipt_allowance"],
        overBillingAllowance: json["over_billing_allowance"],
        description: json["description"],
        isUseQrCode: json["is_use_qr_code"],
        quantityOfItemsPerQrCode: json["quantity_of_items_per_qr_code"],
        shelfLifeInDays: json["shelf_life_in_days"],
        endOfLife: json["end_of_life"] == null
            ? null
            : DateTime.parse(json["end_of_life"]),
        defaultMaterialRequestType: json["default_material_request_type"],
        valuationMethod: json["valuation_method"],
        weightPerUnit: json["weight_per_unit"],
        hasBatchNo: json["has_batch_no"],
        createNewBatch: json["create_new_batch"],
        hasExpiryDate: json["has_expiry_date"],
        retainSample: json["retain_sample"],
        sampleQuantity: json["sample_quantity"],
        hasSerialNo: json["has_serial_no"],
        hasVariants: json["has_variants"],
        variantBasedOn: json["variant_based_on"],
        isPurchaseItem: json["is_purchase_item"],
        minOrderQty: json["min_order_qty"],
        safetyStock: json["safety_stock"],
        leadTimeDays: json["lead_time_days"],
        lastPurchaseRate: json["last_purchase_rate"],
        isCustomerProvidedItem: json["is_customer_provided_item"],
        deliveredBySupplier: json["delivered_by_supplier"],
        countryOfOrigin: json["country_of_origin"],
        isSalesItem: json["is_sales_item"],
        grantCommission: json["grant_commission"],
        maxDiscount: json["max_discount"],
        enableDeferredRevenue: json["enable_deferred_revenue"],
        noOfMonths: json["no_of_months"],
        enableDeferredExpense: json["enable_deferred_expense"],
        noOfMonthsExp: json["no_of_months_exp"],
        inspectionRequiredBeforePurchase:
            json["inspection_required_before_purchase"],
        inspectionRequiredBeforeDelivery:
            json["inspection_required_before_delivery"],
        isSubContractedItem: json["is_sub_contracted_item"],
        customerCode: json["customer_code"],
        publishInHub: json["publish_in_hub"],
        syncedWithHub: json["synced_with_hub"],
        publishedInWebsite: json["published_in_website"],
        totalProjectedQty: json["total_projected_qty"],
        doctype: json["doctype"],
        barcodes: json["barcodes"] == null
            ? []
            : List<dynamic>.from(json["barcodes"]!.map((x) => x)),
        reorderLevels: json["reorder_levels"] == null
            ? []
            : List<dynamic>.from(json["reorder_levels"]!.map((x) => x)),
        uoms: json["uoms"] == null
            ? []
            : List<Uom>.from(json["uoms"]!.map((x) => Uom.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        itemDefaults: json["item_defaults"] == null
            ? []
            : List<ItemDefault>.from(
                json["item_defaults"]!.map((x) => ItemDefault.fromJson(x))),
        supplierItems: json["supplier_items"] == null
            ? []
            : List<dynamic>.from(json["supplier_items"]!.map((x) => x)),
        customerItems: json["customer_items"] == null
            ? []
            : List<dynamic>.from(json["customer_items"]!.map((x) => x)),
        taxes: json["taxes"] == null
            ? []
            : List<dynamic>.from(json["taxes"]!.map((x) => x)),
      );

  static List<ItemModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ItemModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "idx": idx,
        "docstatus": docstatus,
        "workflow_state": workflowState,
        "naming_series": namingSeries,
        "item_code": itemCode,
        "item_name": itemName,
        "item_group": itemGroup,
        "stocker": stocker,
        "kategori_barang": kategoriBarang,
        "keterangan_barang": keteranganBarang,
        "sub_kategori": subKategori,
        "is_item_from_hub": isItemFromHub,
        "stock_uom": stockUom,
        "jenis_barang": jenisBarang,
        "klasifikasi_barang": klasifikasiBarang,
        "disabled": disabled,
        "allow_alternative_item": allowAlternativeItem,
        "is_stock_item": isStockItem,
        "include_item_in_manufacturing": includeItemInManufacturing,
        "opening_stock": openingStock,
        "valuation_rate": valuationRate,
        "standard_rate": standardRate,
        "is_fixed_asset": isFixedAsset,
        "auto_create_assets": autoCreateAssets,
        "over_delivery_receipt_allowance": overDeliveryReceiptAllowance,
        "over_billing_allowance": overBillingAllowance,
        "description": description,
        "is_use_qr_code": isUseQrCode,
        "quantity_of_items_per_qr_code": quantityOfItemsPerQrCode,
        "shelf_life_in_days": shelfLifeInDays,
        "end_of_life":
            "${endOfLife!.year.toString().padLeft(4, '0')}-${endOfLife!.month.toString().padLeft(2, '0')}-${endOfLife!.day.toString().padLeft(2, '0')}",
        "default_material_request_type": defaultMaterialRequestType,
        "valuation_method": valuationMethod,
        "weight_per_unit": weightPerUnit,
        "has_batch_no": hasBatchNo,
        "create_new_batch": createNewBatch,
        "has_expiry_date": hasExpiryDate,
        "retain_sample": retainSample,
        "sample_quantity": sampleQuantity,
        "has_serial_no": hasSerialNo,
        "has_variants": hasVariants,
        "variant_based_on": variantBasedOn,
        "is_purchase_item": isPurchaseItem,
        "min_order_qty": minOrderQty,
        "safety_stock": safetyStock,
        "lead_time_days": leadTimeDays,
        "last_purchase_rate": lastPurchaseRate,
        "is_customer_provided_item": isCustomerProvidedItem,
        "delivered_by_supplier": deliveredBySupplier,
        "country_of_origin": countryOfOrigin,
        "is_sales_item": isSalesItem,
        "grant_commission": grantCommission,
        "max_discount": maxDiscount,
        "enable_deferred_revenue": enableDeferredRevenue,
        "no_of_months": noOfMonths,
        "enable_deferred_expense": enableDeferredExpense,
        "no_of_months_exp": noOfMonthsExp,
        "inspection_required_before_purchase": inspectionRequiredBeforePurchase,
        "inspection_required_before_delivery": inspectionRequiredBeforeDelivery,
        "is_sub_contracted_item": isSubContractedItem,
        "customer_code": customerCode,
        "publish_in_hub": publishInHub,
        "synced_with_hub": syncedWithHub,
        "published_in_website": publishedInWebsite,
        "total_projected_qty": totalProjectedQty,
        "doctype": doctype,
        "barcodes":
            barcodes == null ? [] : List<dynamic>.from(barcodes!.map((x) => x)),
        "reorder_levels": reorderLevels == null
            ? []
            : List<dynamic>.from(reorderLevels!.map((x) => x)),
        "uoms": uoms == null
            ? []
            : List<dynamic>.from(uoms!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "item_defaults": itemDefaults == null
            ? []
            : List<dynamic>.from(itemDefaults!.map((x) => x.toJson())),
        "supplier_items": supplierItems == null
            ? []
            : List<dynamic>.from(supplierItems!.map((x) => x)),
        "customer_items": customerItems == null
            ? []
            : List<dynamic>.from(customerItems!.map((x) => x)),
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
      };
}

class ItemDefault {
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
  String? company;
  String? buyingCostCenter;
  String? expenseAccount;
  String? sellingCostCenter;
  String? incomeAccount;
  String? doctype;

  ItemDefault({
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
    this.company,
    this.buyingCostCenter,
    this.expenseAccount,
    this.sellingCostCenter,
    this.incomeAccount,
    this.doctype,
  });

  factory ItemDefault.fromJson(Map<String, dynamic> json) => ItemDefault(
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
        company: json["company"],
        buyingCostCenter: json["buying_cost_center"],
        expenseAccount: json["expense_account"],
        sellingCostCenter: json["selling_cost_center"],
        incomeAccount: json["income_account"],
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
        "company": company,
        "buying_cost_center": buyingCostCenter,
        "expense_account": expenseAccount,
        "selling_cost_center": sellingCostCenter,
        "income_account": incomeAccount,
        "doctype": doctype,
      };
}

class Uom {
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
  String? uom;
  num? conversionFactor;
  String? doctype;

  Uom({
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
    this.uom,
    this.conversionFactor,
    this.doctype,
  });

  factory Uom.fromJson(Map<String, dynamic> json) => Uom(
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
        uom: json["uom"],
        conversionFactor: json["conversion_factor"],
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
        "uom": uom,
        "conversion_factor": conversionFactor,
        "doctype": doctype,
      };
}
