// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, require_trailing_commas, prefer_const_constructors, unnecessary_new, omit_local_variable_types, noop_primitive_operations, prefer_single_quotes, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, prefer_if_elements_to_conditional_expressions, type_annotate_public_apis, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/items_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/mainGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/items_api/mainsubApi/subGroup.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/EditApi/Get_PackSize_TinsPerBox_Api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/EditApi/PostPut_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sales_quotations_api/post_api/post_sales_quot.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/special%20discount%20api/specialDiscountApi.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_details.modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/item_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/mainModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/headerEdit_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/SalesQuotEdit/widget/creation/logisticEdit_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/widget/logistic_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/create_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/content_creation.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/creation/header_creation.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:uuid/uuid.dart';

import '../../../../Modal/service_layer_modal/sales_quot/QuotPutModel.dart';

class ContentEditCreation extends StatefulWidget {
  ContentEditCreation({Key? key, required this.getdocumentApprovalValue})
      : super(key: key);
  List<DocumentApprovalValue> getdocumentApprovalValue = [];
  @override
  ContentEditCreationState createState() => ContentEditCreationState();
}

class ContentEditCreationState extends State<ContentEditCreation> {
  PageController pageController = PageController();
  static bool isCameFromqutation = false;

  static List<AddItem2> contentitemsDetails = [];
  static List<AddItem2> editcontentitemsDetailss = [];

  static int itemlen = 0;
  int pageChanged = 0;
  //
  List<ItemValue> itemValue = [];
  List<ItemValue> filteritemValue = [];
  ScrollController scrollController = ScrollController();
  int lenthofList = 0;
  int minuslength = 0;
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  //
  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];
  @override
  void initState() {
    MainGroupAPi.getGlobalData().then((value) {
      if (mounted) {
        setState(() {
          print(value.itemValueValue![0].code);
          mainValueValue = value.itemValueValue!;
        });
      }
    });

    SubGroupAPi.getGlobalData().then((value) {
      if (mounted) {
        setState(() {
          value.itemValueValue![0].code;
          subValueValue = value.itemValueValue!;
        });
      }
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (mycontroller[0].text.isEmpty) {
          if (ItemsAPi.nextUrl != 'null') {
            getmoredata();
          }
        }
      }
    });
    if (isCameFromqutation == true) {
      getEditQuatationDetails();
    }
  }

  GetTaxName(AddItem2? contentitemsDetails) {
    if (contentitemsDetails!.taxCode == 'O0') {
      // print("" + contentitemsDetails[i].taxCode.toString());
      valueChossed = 'O0 - 0 % Output VAT';
      valueChosedReason = '0';
      taxCode = 'O0';
      taxSelected = 0.00;
      taxSelected = double.parse(valueChosedReason.toString());
    } else if (contentitemsDetails.taxCode == 'O1') {
      //01
      valueChossed = 'O1 - 18 % Output VAT';
      valueChosedReason = '18';
      taxCode = 'O1';
      taxSelected = 0.00;
      taxSelected = double.parse(valueChosedReason.toString());
    } else if (contentitemsDetails.taxCode == '01') {
      //01
      valueChossed = 'O1 - 18 % Output VAT';
      valueChosedReason = '18';
      taxCode = 'O1';
      taxSelected = 0.00;
      taxSelected = double.parse(valueChosedReason.toString());
    } else if (contentitemsDetails.taxCode == 'O3') {
      valueChossed = 'O3 - Exempted Output VAT';
      taxCode = 'O3';
      valueChosedReason = '0';
      taxSelected = 0.00;
      taxSelected = double.parse(valueChosedReason.toString());
    } else if (contentitemsDetails.taxCode == 'X0') {
      valueChossed = 'X0 - Exempt Output';
      valueChosedReason = '0';
      taxCode = 'X0';
      taxSelected = 0.00;
      taxSelected = double.parse(valueChosedReason.toString());
    }
    return valueChossed == null || valueChossed!.isEmpty
        ? ""
        : valueChossed.toString();
  }

  getEditQuatationDetails() {
    contentitemsDetails = [];

    for (int i = 0; i < widget.getdocumentApprovalValue.length; i++) {
      log("Message:::${i}");
      print("Total::" + widget.getdocumentApprovalValue[i].total.toString());
      print(
          "Tacode::" + widget.getdocumentApprovalValue[i].taxTotal.toString());
      // print("Tacode::" + widget.getdocumentApprovalValue[i].toString());
      double taxtotall = widget.getdocumentApprovalValue[i].taxTotal == null
          ? 0
          : widget.getdocumentApprovalValue[i].taxTotal!;
      contentitemsDetails.add(AddItem2(
        warehouse: widget.getdocumentApprovalValue[i].warehouseCode,
        itemCode: widget.getdocumentApprovalValue[i].itemCode,
        itemName: widget.getdocumentApprovalValue[i].itemDescription,
        price: widget.getdocumentApprovalValue[i].unitPrice,
        discount: widget.getdocumentApprovalValue[i].discountPercent,
        qty: double.parse(
            widget.getdocumentApprovalValue[i].quantity!.toStringAsFixed(0)),
        total: widget.getdocumentApprovalValue[i].lineTotal,
        valuechoosed: widget.getdocumentApprovalValue[i].taxCode.toString(),
        discounpercent: widget.getdocumentApprovalValue[i].discountPercent,
        tax: widget.getdocumentApprovalValue[i].taxTotal,
        taxCode: widget.getdocumentApprovalValue[i].taxCode == null ||
                widget.getdocumentApprovalValue[i].taxCode == 'null' ||
                widget.getdocumentApprovalValue[i].taxCode == 0
            ? isTaxApplied(
                widget.getdocumentApprovalValue[i].lineTotal!, taxtotall)
            : widget.getdocumentApprovalValue[i].taxCode!,
        lineNoo: i,

        // double.parse( widget.getdocumentApprovalValue[i].TaxCode.toString()) == null ||
        //        double.parse( widget.getdocumentApprovalValue[i].TaxCode) ==0
        // ? isTaxApplied(widget.getdocumentApprovalValue[i].LineTotal!,
        //     widget.getdocumentApprovalValue[i].TaxTotal!)
        //     :     double.parse( widget.getdocumentApprovalValue[i].TaxCode!),
        taxPer: caluclateTaxpercent(
            widget.getdocumentApprovalValue[i].lineTotal!, taxtotall!),
        // wareHouseCode: GetValues.branch.toString(),
        // // getdocumentApprovalValue[i]
        // //     .warehouseCode,
        // taxName: "",
        // baseline: getdocumentApprovalValue[i].LineNum.toString(),
        // basedocentry: docEntryforSO
        lineNumm: i,
        itemDescription: widget.getdocumentApprovalValue[i].itemDescription,
        quantity: widget.getdocumentApprovalValue[i].quantity,
        shipDate: widget.getdocumentApprovalValue[i].shipDate,
        priceAfterVat: widget.getdocumentApprovalValue[i].total,
        currency: widget.getdocumentApprovalValue[i].currency,
        rate: widget.getdocumentApprovalValue[i].rate,
        discountPercent: widget.getdocumentApprovalValue[i].discountPercent,
        vendorNum: widget.getdocumentApprovalValue[i].vendorNum,
        serialNum: widget.getdocumentApprovalValue[i].serialNum,
        warehouseCode: widget.getdocumentApprovalValue[i].warehouseCode,
        salesPersonCode: widget.getdocumentApprovalValue[i].salesPersonCode,
        commisionPercent: widget.getdocumentApprovalValue[i].commisionPercent,
        treeType: widget.getdocumentApprovalValue[i].treeType,
        accountCode: widget.getdocumentApprovalValue[i].accountCode,
        useBaseUnits: widget.getdocumentApprovalValue[i].useBaseUnits,
        supplierCatNum: widget.getdocumentApprovalValue[i].supplierCatNum,
        costingCode: widget.getdocumentApprovalValue[i].costingCode,
        projectCode: widget.getdocumentApprovalValue[i].projectCode,
        barCode: widget.getdocumentApprovalValue[i].barCode,
        vatGroup: widget.getdocumentApprovalValue[i].vatGroup,
        height1: widget.getdocumentApprovalValue[i].height1,
        hight1Unit: widget.getdocumentApprovalValue[i].hight1Unit,
        height2: widget.getdocumentApprovalValue[i].height2,
        height2Unit: widget.getdocumentApprovalValue[i].height2Unit,
        lengh1: widget.getdocumentApprovalValue[i].lengh1,
        lengh1Unit: widget.getdocumentApprovalValue[i].lengh1Unit,
        lengh2: widget.getdocumentApprovalValue[i].lengh2,
        lengh2Unit: widget.getdocumentApprovalValue[i].lengh2Unit,
        weight1: widget.getdocumentApprovalValue[i].weight1,
        weight1Unit: widget.getdocumentApprovalValue[i].weight1Unit,
        weight2: widget.getdocumentApprovalValue[i].weight2,
        weight2Unit: widget.getdocumentApprovalValue[i].weight2Unit,
        factor1: widget.getdocumentApprovalValue[i].factor1,
        factor2: widget.getdocumentApprovalValue[i].factor2,
        factor3: widget.getdocumentApprovalValue[i].factor3,
        factor4: widget.getdocumentApprovalValue[i].factor4,
        baseType: widget.getdocumentApprovalValue[i].baseType,
        baseEntry: widget.getdocumentApprovalValue[i].baseEntry,
        baseLine: widget.getdocumentApprovalValue[i].baseLine,
        volume: widget.getdocumentApprovalValue[i].volume,
        volumeUnit: widget.getdocumentApprovalValue[i].volumeUnit,
        width1: widget.getdocumentApprovalValue[i].width1,
        width1Unit: widget.getdocumentApprovalValue[i].width1Unit,
        width2: widget.getdocumentApprovalValue[i].width2,
        width2Unit: widget.getdocumentApprovalValue[i].width2Unit,
        address: widget.getdocumentApprovalValue[i].address,
        taxType: widget.getdocumentApprovalValue[i].taxType,
        taxLiable: widget.getdocumentApprovalValue[i].taxLiable,
        pickStatus: widget.getdocumentApprovalValue[i].pickStatus,
        pickQuantity: widget.getdocumentApprovalValue[i].pickQuantity,
        pickListIdNumber: widget.getdocumentApprovalValue[i].pickListIdNumber,
        originalItem: widget.getdocumentApprovalValue[i].originalItem,
        backOrder: widget.getdocumentApprovalValue[i].backOrder,
        freeText: widget.getdocumentApprovalValue[i].freeText,
        shippingMethod: widget.getdocumentApprovalValue[i].shippingMethod,
        poTargetNum: widget.getdocumentApprovalValue[i].poTargetNum,
        poTargetEntry: widget.getdocumentApprovalValue[i].poTargetEntry,
        poTargetRowNum: widget.getdocumentApprovalValue[i].poTargetRowNum,
        correctionInvoiceItem:
            widget.getdocumentApprovalValue[i].correctionInvoiceItem,
        corrInvAmountToStock:
            widget.getdocumentApprovalValue[i].corrInvAmountToStock,
        corrInvAmountToDiffAcct:
            widget.getdocumentApprovalValue[i].corrInvAmountToDiffAcct,
        appliedTax: widget.getdocumentApprovalValue[i].appliedTax,
        appliedTaxFc: widget.getdocumentApprovalValue[i].appliedTaxFc,
        appliedTaxSc: widget.getdocumentApprovalValue[i].appliedTaxSc,
        wtLiable: widget.getdocumentApprovalValue[i].wtLiable,
        deferredTax: widget.getdocumentApprovalValue[i].deferredTax,
        equalizationTaxPercent:
            widget.getdocumentApprovalValue[i].equalizationTaxPercent,
        totalEqualizationTax:
            widget.getdocumentApprovalValue[i].totalEqualizationTax,
        totalEqualizationTaxFc:
            widget.getdocumentApprovalValue[i].totalEqualizationTaxFc,
        totalEqualizationTaxSc:
            widget.getdocumentApprovalValue[i].totalEqualizationTaxSc,
        netTaxAmount: widget.getdocumentApprovalValue[i].netTaxAmount,
        netTaxAmountFc: widget.getdocumentApprovalValue[i].netTaxAmountFc,
        netTaxAmountSc: widget.getdocumentApprovalValue[i].netTaxAmountSc,
        measureUnit: widget.getdocumentApprovalValue[i].measureUnit,
        unitsOfMeasurment: widget.getdocumentApprovalValue[i].unitsOfMeasurment,
        lineTotal: widget.getdocumentApprovalValue[i].lineTotal,
        taxPercentagePerRow:
            widget.getdocumentApprovalValue[i].taxPercentagePerRow,
        taxTotal: widget.getdocumentApprovalValue[i].taxTotal,
        consumerSalesForecast:
            widget.getdocumentApprovalValue[i].consumerSalesForecast,
        exciseAmount: widget.getdocumentApprovalValue[i].exciseAmount,
        taxPerUnit: widget.getdocumentApprovalValue[i].taxPerUnit,
        totalInclTax: widget.getdocumentApprovalValue[i].totalInclTax,
        countryOrg: widget.getdocumentApprovalValue[i].countryOrg,
        sww: widget.getdocumentApprovalValue[i].sww,
        transactionType: widget.getdocumentApprovalValue[i].transactionType,
        distributeExpense: widget.getdocumentApprovalValue[i].distributeExpense,
        rowTotalFc: widget.getdocumentApprovalValue[i].rowTotalFc,
        rowTotalSc: widget.getdocumentApprovalValue[i].rowTotalSc,
        lastBuyInmPrice: widget.getdocumentApprovalValue[i].lastBuyInmPrice,
        lastBuyDistributeSumFc:
            widget.getdocumentApprovalValue[i].lastBuyDistributeSumFc,
        lastBuyDistributeSumSc:
            widget.getdocumentApprovalValue[i].lastBuyDistributeSumSc,
        lastBuyDistributeSum:
            widget.getdocumentApprovalValue[i].lastBuyDistributeSum,
        stockDistributesumForeign:
            widget.getdocumentApprovalValue[i].stockDistributesumForeign,
        stockDistributesumSystem:
            widget.getdocumentApprovalValue[i].stockDistributesumSystem,
        stockDistributesum:
            widget.getdocumentApprovalValue[i].stockDistributesum,
        stockInmPrice: widget.getdocumentApprovalValue[i].stockInmPrice,
        pickStatusEx: widget.getdocumentApprovalValue[i].pickStatusEx,
        taxBeforeDpm: widget.getdocumentApprovalValue[i].taxBeforeDpm,
        taxBeforeDpmfc: widget.getdocumentApprovalValue[i].taxBeforeDpmfc,
        taxBeforeDpmsc: widget.getdocumentApprovalValue[i].taxBeforeDpmsc,
        cfopCode: widget.getdocumentApprovalValue[i].cfopCode,
        cstCode: widget.getdocumentApprovalValue[i].cstCode,
        usage: widget.getdocumentApprovalValue[i].usage,
        taxOnly: widget.getdocumentApprovalValue[i].taxOnly,
        visualOrder: widget.getdocumentApprovalValue[i].visualOrder,
        baseOpenQuantity: widget.getdocumentApprovalValue[i].baseOpenQuantity,
        unitPrice: widget.getdocumentApprovalValue[i].unitPrice,
        lineStatus: widget.getdocumentApprovalValue[i].lineStatus,
        packageQuantity: widget.getdocumentApprovalValue[i].packageQuantity,
        text: widget.getdocumentApprovalValue[i].text,
        lineType: widget.getdocumentApprovalValue[i].lineType,
        cogsCostingCode: widget.getdocumentApprovalValue[i].cogsCostingCode,
        cogsAccountCode: widget.getdocumentApprovalValue[i].cogsAccountCode,
        changeAssemlyBoMWarehouse:
            widget.getdocumentApprovalValue[i].changeAssemlyBoMWarehouse,
        grossBuyPrice: widget.getdocumentApprovalValue[i].grossBuyPrice,
        grossBase: widget.getdocumentApprovalValue[i].grossBase,
        grossProfitTotalBasePrice:
            widget.getdocumentApprovalValue[i].grossProfitTotalBasePrice,
        costingCode2: widget.getdocumentApprovalValue[i].costingCode2,
        costingCode3: widget.getdocumentApprovalValue[i].costingCode3,
        costingCode4: widget.getdocumentApprovalValue[i].costingCode4,
        costingCode5: widget.getdocumentApprovalValue[i].costingCode5,
        itemDetails: widget.getdocumentApprovalValue[i].itemDetails,
        locationCode: widget.getdocumentApprovalValue[i].locationCode,
        actualDeliveryDate:
            widget.getdocumentApprovalValue[i].actualDeliveryDate,
        remainingOpenQuantity:
            widget.getdocumentApprovalValue[i].remainingOpenQuantity,
        openAmount: widget.getdocumentApprovalValue[i].openAmount,
        openAmountFc: widget.getdocumentApprovalValue[i].openAmountFc,
        openAmountSc: widget.getdocumentApprovalValue[i].openAmountSc,
        exLineNo: widget.getdocumentApprovalValue[i].exLineNo,
        Date: widget.getdocumentApprovalValue[i].Date,
        Quantity: widget.getdocumentApprovalValue[i].quantity,
        cogsCostingCode2: widget.getdocumentApprovalValue[i].cogsCostingCode2,
        cogsCostingCode3: widget.getdocumentApprovalValue[i].cogsCostingCode3,
        cogsCostingCode4: widget.getdocumentApprovalValue[i].cogsCostingCode4,
        cogsCostingCode5: widget.getdocumentApprovalValue[i].cogsCostingCode5,
        csTforIpi: widget.getdocumentApprovalValue[i].csTforIpi,
        csTforPis: widget.getdocumentApprovalValue[i].csTforPis,
        csTforCofins: widget.getdocumentApprovalValue[i].csTforCofins,
        creditOriginCode: widget.getdocumentApprovalValue[i].creditOriginCode,
        withoutInventoryMovement:
            widget.getdocumentApprovalValue[i].withoutInventoryMovement,
        agreementNo: widget.getdocumentApprovalValue[i].agreementNo,
        agreementRowNumber:
            widget.getdocumentApprovalValue[i].agreementRowNumber,
        actualBaseEntry: widget.getdocumentApprovalValue[i].actualBaseEntry,
        actualBaseLine: widget.getdocumentApprovalValue[i].actualBaseLine,
        docEntry: widget.getdocumentApprovalValue[i].docEntry,
        surpluses: widget.getdocumentApprovalValue[i].surpluses,
        defectAndBreakup: widget.getdocumentApprovalValue[i].defectAndBreakup,
        shortages: widget.getdocumentApprovalValue[i].shortages,
        considerQuantity: widget.getdocumentApprovalValue[i].considerQuantity,
        partialRetirement: widget.getdocumentApprovalValue[i].partialRetirement,
        retirementQuantity:
            widget.getdocumentApprovalValue[i].retirementQuantity,
        retirementApc: widget.getdocumentApprovalValue[i].retirementApc,
        thirdParty: widget.getdocumentApprovalValue[i].thirdParty,
        poNum: widget.getdocumentApprovalValue[i].poNum,
        poItmNum: widget.getdocumentApprovalValue[i].poItmNum,
        expenseType: widget.getdocumentApprovalValue[i].expenseType,
        receiptNumber: widget.getdocumentApprovalValue[i].receiptNumber,
        expenseOperationType:
            widget.getdocumentApprovalValue[i].expenseOperationType,
        federalTaxId: widget.getdocumentApprovalValue[i].federalTaxId,
        grossProfit: widget.getdocumentApprovalValue[i].grossProfit,
        grossProfitFc: widget.getdocumentApprovalValue[i].grossProfitFc,
        grossProfitSc: widget.getdocumentApprovalValue[i].grossProfitSc,
        priceSource: widget.getdocumentApprovalValue[i].priceSource,
        stgSeqNum: widget.getdocumentApprovalValue[i].stgSeqNum,
        stgEntry: widget.getdocumentApprovalValue[i].stgEntry,
        stgDesc: widget.getdocumentApprovalValue[i].stgDesc,
        uoMEntry: widget.getdocumentApprovalValue[i].uoMEntry,
        uoMCode: widget.getdocumentApprovalValue[i].uoMCode,
        inventoryQuantity: widget.getdocumentApprovalValue[i].inventoryQuantity,
        remainingOpenInventoryQuantity:
            widget.getdocumentApprovalValue[i].remainingOpenInventoryQuantity,
        parentLineNum: widget.getdocumentApprovalValue[i].parentLineNum,
        incoterms: widget.getdocumentApprovalValue[i].incoterms,
        transportMode: widget.getdocumentApprovalValue[i].transportMode,
        natureOfTransaction:
            widget.getdocumentApprovalValue[i].natureOfTransaction,
        destinationCountryForImport:
            widget.getdocumentApprovalValue[i].destinationCountryForImport,
        destinationRegionForImport:
            widget.getdocumentApprovalValue[i].destinationRegionForImport,
        originCountryForExport:
            widget.getdocumentApprovalValue[i].originCountryForExport,
        originRegionForExport:
            widget.getdocumentApprovalValue[i].originRegionForExport,
        itemType: widget.getdocumentApprovalValue[i].itemType,
        changeInventoryQuantityIndependently: widget
            .getdocumentApprovalValue[i].changeInventoryQuantityIndependently,
        freeOfChargeBp: widget.getdocumentApprovalValue[i].freeOfChargeBp,
        sacEntry: widget.getdocumentApprovalValue[i].sacEntry,
        hsnEntry: widget.getdocumentApprovalValue[i].hsnEntry,
        grossPrice: widget.getdocumentApprovalValue[i].grossPrice,
        grossTotal: widget.getdocumentApprovalValue[i].grossTotal,
        grossTotalFc: widget.getdocumentApprovalValue[i].grossTotalFc!,
        grossTotalSc: widget.getdocumentApprovalValue[i].grossTotalSc,
        ncmCode: widget.getdocumentApprovalValue[i].ncmCode,
        nveCode: widget.getdocumentApprovalValue[i].nveCode,
        indEscala: widget.getdocumentApprovalValue[i].indEscala,
        ctrSealQty: widget.getdocumentApprovalValue[i].ctrSealQty,
        cnjpMan: widget.getdocumentApprovalValue[i].cnjpMan,
        cestCode: widget.getdocumentApprovalValue[i].cestCode,
        ufFiscalBenefitCode:
            widget.getdocumentApprovalValue[i].ufFiscalBenefitCode,
        shipToCode: widget.getdocumentApprovalValue[i].shipToCode,
        shipToDescription: widget.getdocumentApprovalValue[i].shipToDescription,
        externalCalcTaxRate:
            widget.getdocumentApprovalValue[i].externalCalcTaxRate,
        externalCalcTaxAmount:
            widget.getdocumentApprovalValue[i].externalCalcTaxAmount,
        externalCalcTaxAmountFc:
            widget.getdocumentApprovalValue[i].externalCalcTaxAmountFc,
        externalCalcTaxAmountSc:
            widget.getdocumentApprovalValue[i].externalCalcTaxAmountSc,
        standardItemIdentification:
            widget.getdocumentApprovalValue[i].standardItemIdentification,
        commodityClassification:
            widget.getdocumentApprovalValue[i].commodityClassification,
        unencumberedReason:
            widget.getdocumentApprovalValue[i].unencumberedReason,
        cuSplit: widget.getdocumentApprovalValue[i].cuSplit,
        uQtyOrdered: widget.getdocumentApprovalValue[i].uQtyOrdered,
        uOpenQty: widget.getdocumentApprovalValue[i].uOpenQty,
        uTonnage: widget.getdocumentApprovalValue[i].uTonnage,
        uPackSize: widget.getdocumentApprovalValue[i].uPackSize,
        uProfitCentre: widget.getdocumentApprovalValue[i].uProfitCentre,
        uNumberDrums: widget.getdocumentApprovalValue[i].uNumberDrums,
        uDrumSize: widget.getdocumentApprovalValue[i].uDrumSize,
        uPails: widget.getdocumentApprovalValue[i].uPails,
        uCartons: widget.getdocumentApprovalValue[i].uCartons,
        uLooseTins: widget.getdocumentApprovalValue[i].uLooseTins,
        uNettWt: widget.getdocumentApprovalValue[i].uNettWt,
        uGrossWt: widget.getdocumentApprovalValue[i].uGrossWt,
        uAppLinId: widget.getdocumentApprovalValue[i].uAppLinId,
        uMuQty: widget.getdocumentApprovalValue[i].uMuQty,
        uRvc: widget.getdocumentApprovalValue[i].uRvc,
        uVrn: widget.getdocumentApprovalValue[i].uVrn,
        uIdentifier: widget.getdocumentApprovalValue[i].uIdentifier,
        U_Pack_Size: widget.getdocumentApprovalValue[i].U_Pack_Size,
      ));
    }
    // //

    for (int ij = 0; ij < contentitemsDetails.length; ij++) {
      mycontroller[1].text = contentitemsDetails[ij].price!.toString();
      mycontroller[3].text = contentitemsDetails[ij].discount!.toString();
      mycontroller[2].text = contentitemsDetails[ij].qty!.toString();

      if (contentitemsDetails[ij].taxCode == 'O0') {
        // print("" + contentitemsDetails[i].taxCode.toString());
        valueChossed = 'O0 - 0 % Output VAT';
        valueChosedReason = '0';
        taxCode = 'O0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason.toString());
      } else if (contentitemsDetails[ij].taxCode == 'O1') {
        valueChossed = 'O1 - 18 % Output VAT';
        valueChosedReason = '18';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason.toString());
      } else if (contentitemsDetails[ij].taxCode == '01') {
        //01
        valueChossed = 'O1 - 18 % Output VAT';
        valueChosedReason = '18';
        taxCode = 'O1';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason.toString());
      } else if (contentitemsDetails[ij].taxCode == 'O3') {
        valueChossed = 'O3 - Exempted Output VAT';
        taxCode = 'O3';
        valueChosedReason = '0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason.toString());
      } else if (contentitemsDetails[ij].taxCode == 'X0') {
        valueChossed = 'X0 - Exempt Output';
        valueChosedReason = '0';
        taxCode = 'X0';
        taxSelected = 0.00;
        taxSelected = double.parse(valueChosedReason.toString());
      }
      //

      GetPackANDTinsPerBoxApi.getGlobalData(contentitemsDetails[ij].itemCode)
          .then((value) {
        if (value.statusCode! <= 210 && value.statusCode! >= 200) {
          log("PackSize::" + value.activitiesData![0].U_Pack_Size.toString());
          log("TinPErBox::" +
              value.activitiesData![0].U_Tins_Per_Box.toString());
          log("controller 4:::" + mycontroller[4].text);

          contentitemsDetails[ij].U_Pack_Size =
              value.activitiesData![0].U_Pack_Size;
          contentitemsDetails[ij].U_Tins_Per_Box =
              value.activitiesData![0].U_Tins_Per_Box;
          //
          final double price = contentitemsDetails[ij].unitPrice!;
          // double.parse(mycontroller[1].text);
          final double qty = contentitemsDetails[ij].qty!;
          // double.parse(mycontroller[2].text);
          final double discountper = double.parse(
              mycontroller[3].text == '' ? '0' : mycontroller[3].text);
          final double discount = (price * qty) * discountper / 100;
          final double taxper = taxSelected;
          final double tax = ((qty * price) - discount) * taxper / 100;

          double total = (price * qty) - discount;
          log("total1::::" + total.toString());
          total = total + tax;
          log("total2::::" + total.toString());
          int carton2 = 0;
          if (contentitemsDetails[ij].U_Pack_Size! < 10 &&
              contentitemsDetails[ij].U_Tins_Per_Box! > 0) {
            carton2 = qty ~/ contentitemsDetails[ij].U_Tins_Per_Box!;
            print("cartooooooone" + carton2.toString());
            print("cartooooooone" + carton2.toInt().toString());
          }
          contentitemsDetails[ij].carton = carton2;
          contentitemsDetails[ij].valueAF = (price * qty) - discount;
          contentitemsDetails[ij].total = total;
        }
        // contentitemsDetails[i].shipToCode = "";
        // contentitemsDetails[i].lineNo = 0;
      });
    }
    setState(() {
      isCameFromqutation = false;
    });
    // contentitemsDetails
  }

  double caluclateTaxpercent(double total, double tax) {
    double res = 0;

    res = tax / total * 100;

    return res;
  }

  String isTaxApplied(double total, double tax) {
    double res = 0;
    String isaval = '0';
    res = tax / total * 100;
    isaval = (res == 18 ? "O1" : "null");

    return isaval;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool swipeLoad = false;
  void getmoredata() {
    ItemsAPi.callNextLink().then((val) {
      setState(() {
        swipeLoad = true;
        minuslength = -1;
        if (val.itemValueValue!.isNotEmpty) {
          for (int i = 0; i < lenthofList; i++) {
            filteritemValue.add(ItemValue(
                itemCode: val.itemValueValue![i].itemCode,
                itemName: val.itemValueValue![i].itemName,
                odataetag: val.itemValueValue![i].odataetag,
                salesUnit: val.itemValueValue![i].salesUnit,
                itemPrices: val.itemValueValue![i].itemPrices,
                U_Pack_Size: val.itemValueValue![i].U_Pack_Size,
                U_Tins_Per_Box: val.itemValueValue![i].U_Tins_Per_Box));
          }
          swipeLoad = false;
          print('lenthofList: ' + lenthofList.toString());
          print('lennList: ' + filteritemValue.length.toString());
          print(val.nextLink);
          minuslength = 0;
        }
      });
    });
  }

  double? price;
  int? qty;
  static String? carcode;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
          print(pageChanged);
        },
        children: [
          listItems(context, theme),
          //  contentitemsDetails(title: 'Item Details',),
          AddItem2s(context, theme)
        ],
      ),
    );
  }

  bool loadItems = false;
  bool loadItemValues = false;
  Stack listItems(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: visibleBtn,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02,
                ),
                child: SizedBox(
                  width: Screens.width(context),
                  height: Screens.heigth(context) * 0.05,
                  child: ElevatedButton(
                      onPressed: () {
                        if (HeaderEditCreationState.bpName != '') {
                          pageController.animateToPage(++pageChanged,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceIn);
                          CreateDetailsState.contentAddItems = true;
                        } else {
                          const snackBar = SnackBar(
                            duration: Duration(seconds: 5),
                            backgroundColor: Colors.red,
                            content: Text(
                              'Choose Bussiness Partner First!!..',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: theme.primaryColor,
                      ),
                      child: Icon(Icons.add)),
                ),
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02,
                    ),
                    itemCount: contentitemsDetails.length,
                    itemBuilder: (c, i) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.02,
                            right: Screens.width(context) * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                //color: Colors.greenAccent,
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  contentitemsDetails[i]
                                      .itemCode
                                      .toString(), //'${quotDataFilter[i].DocNum}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //color: Colors.greenAccent,
                                width: Screens.width(context) * 0.7,
                                child: Text(
                                  contentitemsDetails[i]
                                      .itemName!, //'${quotDataFilter[i].DocNum}',
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Price', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      // color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        // '${contentitemsDetails[i].price}', //'${quotDataFilter[i].DocNum}',
                                        TextStyles.splitValues(
                                            '${contentitemsDetails[i].price}'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Qty', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        '${contentitemsDetails[i].qty}', //'${quotDataFilter[i].DocNum}',
                                        //  TextStyles.splitValues('$total'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Screens.heigth(context) * 0.005,
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Discount %', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        contentitemsDetails[i]
                                                    .discounpercent! <=
                                                0.0
                                            ? "000.00"
                                            : TextStyles.splitValues(
                                                    '${contentitemsDetails[i].discounpercent!}')
                                                .replaceAll(
                                                    new RegExp('^0+(?=.)'), ''),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Value AF Disc', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        contentitemsDetails[i].valueAF == null
                                            ? "000.00"
                                            : TextStyles.splitValues(
                                                '${contentitemsDetails[i].valueAF}'),
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Total', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        //  '${contentitemsDetails[i].total! - contentitemsDetails[i].discount!}',
                                        TextStyles.splitValues(
                                            '${contentitemsDetails[i].total!}'), //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Tax Code', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        taxSelected.toString(),
                                        // '${contentitemsDetails[i].taxCode}',
                                        // // TextStyles.splitValues(
                                        // //     '${contentitemsDetails[i].total!}'), //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //   color: Colors.blueGrey,
                                width: Screens.width(context) * 0.9,
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.25,
                                      child: Text(
                                        'Tax Name', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.05,
                                      child: Text(
                                        ':', //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                    SizedBox(
                                      //  color: Colors.greenAccent,
                                      width: Screens.width(context) * 0.55,
                                      child: Text(
                                        '${GetTaxName(contentitemsDetails[i])}',
                                        // TextStyles.splitValues(
                                        //     '${contentitemsDetails[i].total!}'), //'${quotDataFilter[i].DocNum}',
                                        style:
                                            TextStyles.bodytextBlack1(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Container(
                                  //   alignment: Alignment.bottomRight,
                                  //   // color: Colors.greenAccent,
                                  //   //  width: Screens.width(context) * 0.18,
                                  //   child: Row(
                                  //     children: [
                                  //       InkWell(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           padding: EdgeInsets.all(
                                  //               Screens.width(context) * 0.01),
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: theme.primaryColor),
                                  //           child: Icon(
                                  //             Icons.add,
                                  //             size: Screens.width(context) * 0.05,
                                  //             color: Colors.white,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: Screens.width(context) * 0.02,
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {},
                                  //         child: Container(
                                  //           padding: EdgeInsets.all(
                                  //               Screens.width(context) * 0.01),
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: theme.primaryColor),
                                  //           child: Icon(
                                  //             Icons.remove,
                                  //             size: Screens.width(context) * 0.05,
                                  //             color: Colors.white,
                                  //           ),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: Screens.width(context) * 0.04,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      // valueChossed = null;
                                      log("AAA" +
                                          contentitemsDetails[i]
                                              .taxCode
                                              .toString());
                                      // valueChossed = "";
                                      mycontroller[4].text =
                                          contentitemsDetails[i]
                                              .price!
                                              .toStringAsFixed(2);
                                      mycontroller[5].text =
                                          contentitemsDetails[i]
                                              .qty!
                                              .toString();

                                      mycontroller[6].text =
                                          contentitemsDetails[i]
                                              .discounpercent!
                                              .toStringAsFixed(2);
                                      taxSelected =
                                          contentitemsDetails[i].taxPer != null
                                              ? contentitemsDetails[i].taxPer!
                                              : 0;
                                      log("contentitemsDetails[i].taxPer: " +
                                          contentitemsDetails[i]
                                              .taxPer
                                              .toString());
                                      if (contentitemsDetails[i].taxCode ==
                                          'O0') {
                                        // print("" + contentitemsDetails[i].taxCode.toString());
                                        valueChossed = 'O0 - 0 % Output VAT';
                                        valueChosedReason = '0';
                                        taxCode = 'O0';
                                        taxSelected = 0.00;
                                        taxSelected = double.parse(
                                            valueChosedReason.toString());
                                      } else if (contentitemsDetails[i]
                                              .taxCode ==
                                          'O1') {
                                        valueChossed = 'O1 - 18 % Output VAT';
                                        valueChosedReason = '18';
                                        taxCode = 'O1';
                                        taxSelected = 0.00;
                                        taxSelected = double.parse(
                                            valueChosedReason.toString());
                                      } else if (contentitemsDetails[i]
                                              .taxCode ==
                                          'O3') {
                                        valueChossed =
                                            'O3 - Exempted Output VAT';
                                        taxCode = 'O3';
                                        valueChosedReason = '0';
                                        taxSelected = 0.00;
                                        taxSelected = double.parse(
                                            valueChosedReason.toString());
                                      } else if (contentitemsDetails[i]
                                              .taxCode ==
                                          'X0') {
                                        valueChossed = 'X0 - Exempt Output';
                                        valueChosedReason = '0';
                                        taxCode = 'X0';
                                        taxSelected = 0.00;
                                        taxSelected = double.parse(
                                            valueChosedReason.toString());
                                      }

//
                                      // valueChossed = contentitemsDetails[i]
                                      //         .valuechoosed
                                      //         .toString()
                                      //         .isEmpty
                                      //     ? "0.0"
                                      //     : contentitemsDetails[i].valuechoosed;

                                      // print("taxxx" +
                                      //     contentitemsDetails[i]
                                      //         .tax!
                                      //         .toDouble()
                                      //         .toString());
                                      log("valuechoss::" +
                                          contentitemsDetails[i]
                                              .valuechoosed
                                              .toString());
                                      showBottomSheetUpdate(i, theme);
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      // color: Colors.greenAccent,
                                      // width: Screens.width(context) * 0.1,
                                      child: Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: theme.primaryColor,
                                        size: Screens.width(context) * 0.065,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.04,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        grandtotal = 0.00;
                                        discount = 0.00;
                                        contentitemsDetails.removeAt(i);

                                        sumofTotal();
                                        itemlen = contentitemsDetails.length;
                                        log("contentitemsDetails.length::${contentitemsDetails.length}");
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      // color: Colors.greenAccent,
                                      // width: Screens.width(context) * 0.1,
                                      child: Icon(
                                        Icons.delete_outline_sharp,
                                        color: theme.primaryColor,
                                        size: Screens.width(context) * 0.065,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: CustomSpinkitdButton(
        //     onTap: () async {
        //       ValidateAndCallApi();
        //       //callServiceLayerApi();
        //     },
        //     isLoading: isLoading,
        //     //  labelLoading: AppLocalizations.of(context)!.signing,
        //     label: 'Save',
        //   ),
        // )
      ],
    );
  }

  // bool isLoading = false;
  // void ValidateAndCallApi() {
  //   if (carcode == null) {
  //     const snackBar = SnackBar(
  //       duration: Duration(seconds: 3),
  //       backgroundColor: Colors.red,
  //       content: Text(
  //         'Please Choose Business Partner!!...',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else if (contentitemsDetails.isEmpty) {
  //     const snackBar = SnackBar(
  //       duration: Duration(seconds: 3),
  //       backgroundColor: Colors.red,
  //       content: Text(
  //         'Please Add Items!!...',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     setState(() => isLoading = true);
  //     SalesQuotPatchAPi.cardCodePost = carcode;
  //     for (int i = 0; i < contentitemsDetails.length; i++) {
  //       SalesQuotPatchAPi.docLineQout!.add(AddItem2(
  //           itemCode: contentitemsDetails[i].itemCode,
  //           itemName: contentitemsDetails[i].itemName,
  //           price: contentitemsDetails[i].price,
  //           discount: contentitemsDetails[i].discount,
  //           qty: contentitemsDetails[i].qty,
  //           total: contentitemsDetails[i].total,
  //           tax: contentitemsDetails[i].tax,
  //           valuechoosed: contentitemsDetails[i].valuechoosed,
  //           taxCode: contentitemsDetails[i].taxCode,
  //           discounpercent: contentitemsDetails[i].discounpercent,
  //           taxPer: contentitemsDetails[i].taxPer));
  //     }
  //     // SalesQuotPatchAPi.docLineQout = contentitemsDetails;
  //     SalesQuotPatchAPi.docDate =
  //         HeaderEditCreationState.currentDateTime.toString();
  //     SalesQuotPatchAPi.dueDate =
  //         HeaderEditCreationState.currentDateTime.toString();
  //     SalesQuotPatchAPi.remarks = HeaderEditCreationState.mycontroller[1].text;
  //     final uuid = Uuid();
  //     String? uuidg = uuid.v1();
  //     SalesQuotPatchAPi.method(uuidg);
  //     // SalesQuotPatchAPi.getGlobalData(uuidg).then((value) {
  //     //   if (value.statusCode! >= 200 && value.statusCode! <= 210) {
  //     //     setState(() => isLoading = false);
  //     //     print(value.statusCode);
  //     //     const snackBar = SnackBar(
  //     //       duration: Duration(seconds: 5),
  //     //       backgroundColor: Colors.green,
  //     //       content: Text(
  //     //         'Quotation Created Successfully!!...',
  //     //         style: TextStyle(color: Colors.white),
  //     //       ),
  //     //     );
  //     //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     //     Get.offAllNamed<dynamic>(FurneyRoutes.newSalesQuot);
  //     //   } else {
  //     //     setState(() => isLoading = false);
  //     //     print(value.statusCode);
  //     //     final snackBar = SnackBar(
  //     //       duration: Duration(seconds: 5),
  //     //       backgroundColor: Colors.red,
  //     //       content: Text(
  //     //         '${value.error!.message!.value}!!..',
  //     //         style: TextStyle(color: Colors.white),
  //     //       ),
  //     //     );
  //     //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     //   }
  //     // });
  //   }
  // }

  Stack AddItem2s(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.heigth(context) * 0.01,
              bottom: Screens.width(context) * 0.01),
          child: loadItemValues == true
              ? Center(
                  child: SpinKitThreeBounce(
                    size: Screens.heigth(context) * 0.06,
                    color: theme.primaryColor,
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            height: Screens.heigth(context) * 0.06,
                            decoration: BoxDecoration(
                              color: theme.hintColor.withOpacity(.05),
                              borderRadius: BorderRadius.circular(Const.radius),
                            ),
                            child: TextField(
                              controller: mycontroller[0],
                              autocorrect: false,
                              style: theme.textTheme.bodyMedium,
                              onChanged: (v) {
                                setState(() {
                                  filteritemValue = itemValue
                                      .where((e) =>
                                          e.itemName!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()) ||
                                          e.itemCode!
                                              .toLowerCase()
                                              .contains(v.toLowerCase()))
                                      .toList();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Filter for Items',
                                hintStyle: TextStyles.bodytextBlack1(context),
                                // AppLocalizations.of(context)!
                                //     .search_sales_quot,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.filter_alt_rounded),
                                  onPressed: () {
                                    valueSelectedMain = null;
                                    valueSelectedSub = null;
                                    error = false;
                                    mycontroller[7].text = '';
                                    mycontroller[8].text = '';

                                    bottomSheetMainSubGroup(theme);
                                    //  ItemsAPi.searchData = mycontroller[0].text;
                                    // setState(() {
                                    //   itemValue.clear();
                                    //   filteritemValue.clear();
                                    // });
                                  }, //
                                  color: theme.primaryColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: Screens.width(context) * 0.8,
                              child: IconButton(
                                  onPressed: () {
                                    pageController.animateToPage(--pageChanged,
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.bounceIn);
                                    CreateDetailsState.contentAddItems = false;

                                    Get.toNamed<dynamic>(
                                        FurneyRoutes.creationDetails);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: theme.primaryColor,
                                    size: Screens.width(context) * 0.08,
                                  )))
                        ]),
                        SizedBox(
                          width: Screens.width(context),
                          height: Screens.heigth(context) * 0.72,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: filteritemValue.length,
                              itemBuilder: (context, i) {
                                if (i == filteritemValue.length - 1) {
                                  if (mycontroller[0].text.isEmpty) {
                                    if (ItemsAPi.nextUrl != 'null') {
                                      print("1111111");
                                      return SpinKitThreeBounce(
                                        size: Screens.width(context) * 0.06,
                                        color: theme.primaryColor,
                                      );
                                    }
                                  }
                                }
                                return Card(
                                    elevation: 8,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          loadingscrn = true;
                                        });
                                        SpecialDiscountAPi.cardCode =
                                            HeaderEditCreationState.bpCode;
                                        SpecialDiscountAPi.itemCode =
                                            filteritemValue[i].itemCode;
                                        // print(SpecialDiscountAPi.cardCode);
                                        //  print(SpecialDiscountAPi.itemCode);
                                        SpecialDiscountAPi.getGlobalData()
                                            .then((value) {
                                          if (value.specialValue!.isNotEmpty) {
                                            setState(() {
                                              loadingscrn = false;
                                            });
                                            // print(value.specialValue![0].Price);
                                            mycontroller[1].text = value
                                                        .specialValue![0]
                                                        .Price! >
                                                    0
                                                ? value.specialValue![0].Price
                                                    .toString()
                                                : filteritemValue[i]
                                                            .itemPrices![0]
                                                            .PriceList ==
                                                        1
                                                    ? filteritemValue[i]
                                                        .itemPrices![0]
                                                        .price
                                                        .toString()
                                                    : "";
                                            mycontroller[2].text = '';
                                            valueChossed = null;
                                            showBottomSheetInsert(i, theme);
                                            mycontroller[3].text = value
                                                        .specialValue![0]
                                                        .discount! >
                                                    0
                                                ? value
                                                    .specialValue![0].discount
                                                    .toString()
                                                : '';
                                            CreateDetailsState.contentAddItems =
                                                false;
                                          } else if (value
                                              .specialValue!.isEmpty) {
                                            setState(() {
                                              loadingscrn = false;
                                            });
                                            mycontroller[1].text =
                                                filteritemValue[i]
                                                            .itemPrices![0]
                                                            .PriceList ==
                                                        1
                                                    ? filteritemValue[i]
                                                        .itemPrices![0]
                                                        .price
                                                        .toString()
                                                    : "";
                                            mycontroller[2].text = '';
                                            mycontroller[3].text = '';
                                            valueChossed = null;
                                            showBottomSheetInsert(i, theme);
                                            CreateDetailsState.contentAddItems =
                                                false;
                                          }
                                        });
                                        // mycontroller[1].text=filteritemValue[i].itemPrices![0].PriceList==1?filteritemValue[i].itemPrices![0].price.toString():"";
                                        //  mycontroller[2].text='';
                                        //   mycontroller[3].text='';
                                        //   valueChossed=null;

                                        // showBottomSheetInsert(i,theme);

                                        // CreateDetailsState.contentAddItem2s = false;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Screens.heigth(context) * 0.01,
                                            horizontal:
                                                Screens.width(context) * 0.02),
                                        // height: Screens.heigth(context)*0.07,
                                        width: Screens.width(context),
                                        decoration: const BoxDecoration(
                                            // color:Colors.green,
                                            // borderRadius: BorderRadius.circular(Const.radius),
                                            // border: Border.all(color: Colors.black)
                                            ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              //row 1
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  //color: Colors.greenAccent,
                                                  width:
                                                      Screens.width(context) *
                                                          0.7,
                                                  child: Text(
                                                    '${filteritemValue[i].itemCode}', //'${quotDataFilter[i].DocNum}',
                                                    style: TextStyles.boldPC1(
                                                        context),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Screens.heigth(context) *
                                                          0.01,
                                                ),
                                                SizedBox(
                                                  //   color: Colors.blue,
                                                  width:
                                                      Screens.width(context) *
                                                          0.7,
                                                  child: Text(
                                                    '${filteritemValue[i].itemName}', //'${quotDataFilter[i].cardName}',
                                                    style: TextStyles
                                                        .headlineBlack1(
                                                            context),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.chevron_right_outlined,
                                                color: theme.primaryColor,
                                                size: Screens.width(context) *
                                                    0.1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: loadingscrn,
                      child: Container(
                        width: Screens.width(context),
                        height: Screens.heigth(context),
                        color: Colors.white60,
                        child: Center(
                          child: SpinKitThreeBounce(
                            size: Screens.heigth(context) * 0.06,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: CustomSpinkitdButton(
        //     onTap: () async {
        //       ValidateAndCallApi();
        //       //callServiceLayerApi();
        //     },
        //     isLoading: isLoading,
        //     //  labelLoading: AppLocalizations.of(context)!.signing,
        //     label: 'Save',
        //   ),
        // )
      ],
    );
  }

  bool loadingscrn = false;
  void bottomSheetMainSubGroup(ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[0],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Main Group!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Main Group: ",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedMain,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedMain = val.toString();
                                    print(valueSelectedMain);
                                  });
                                },
                                items: mainValueValue.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e.code}",
                                      child: Text(
                                        '${e.name}',
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Sub Group!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Sub Group: ",
                                  style: TextStyles.headlineBlack1(context),
                                ),
                                value: valueSelectedSub,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    valueSelectedSub = val.toString();
                                    print(valueSelectedSub.toString());
                                  });
                                },
                                items: subValueValue.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e.code}",
                                      child: Text(
                                        e.name.toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Visibility(
                              visible: error,
                              child: Text(
                                "Please Give Search Value!..",
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: Screens.width(context) * 0.03,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[7],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(05),
                                    ),
                                  ),
                                  // labelText: "Search!!..",
                                  hintText: "Search!!..",
                                  hintStyle: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[8],
                                onChanged: (val) {},
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(05),
                                    ),
                                  ),
                                  hintText: "Enter pack..",
                                  hintStyle: TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.heigth(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "cancel",
                                      style: TextStyles.whiteText(context),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(valuesAdd);
                                    },
                                    child: Text(
                                      "Search",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  void errorMsg() {
    setState(() {
      error = true;
    });
  }

  bool error = false;
  void valuesAdd() {
    setState(() {
      ItemsAPi.mainGroup = valueSelectedMain;
      ItemsAPi.subGroup = valueSelectedSub;
      ItemsAPi.searchData = mycontroller[7].text;
      loadItemValues = true;
      Navigator.pop(context);
      ItemsAPi.getGlobalData(mycontroller[8].text).then((value) {
        setState(() {
          if (value.itemValueValue!.isNotEmpty) {
            print(value.itemValueValue![0].itemName);
            itemValue = value.itemValueValue!;
            filteritemValue = itemValue;
            ItemsAPi.nextUrl = value.nextLink;
            loadItemValues = false;
            //  print( value.nextLink);
            //  print( ItemsAPi.nextUrl);
            lenthofList = filteritemValue.length;
          } else if (value.itemValueValue!.isEmpty) {
            loadItemValues = false;
            const snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text(
                'No Data!!..',
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      });
    });
  }

  String? valueSelectedMain;
  String? valueSelectedSub;
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sureeeeeeeeeeeeeeeee");
      //  Get.offAllNamed<dynamic>(FurneyRoutes.salesQuotes);
      pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
      CreateDetailsState.contentAddItems = false;
      return Future.value(true);
    }
    pageController.animateToPage(--pageChanged,
        duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    CreateDetailsState.contentAddItems = false;
    return Future.value(false);
  }

  bool visibleBtn = true;
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  void showBottomSheetInsert(int i, ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[0],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[1],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER UNIT PRICE";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "unit price",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[2],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "quantity",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            //  ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                readOnly: true,
                                controller: mycontroller[3],
                                onChanged: (val) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "ENTER DISCOUNT";
                                //   }else if(value.isNotEmpty){
                                //       double dis =double.parse(value);
                                //       if(dis>100){
                                //         return "DISCOUNT MORE THAN 100";
                                //       }
                                //   }
                                //   return null;
                                // },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Discount",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Tax: ",
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                                value: valueChossed,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    if (val == 'O0 - 0 % Output VAT') {
                                      valueChosedReason = '0';
                                      taxCode = 'O0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'O1 - 18 % Output VAT') {
                                      valueChosedReason = '18';
                                      taxCode = 'O1';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val ==
                                        'O3 - Exempted Output VAT') {
                                      taxCode = 'O3';
                                      valueChosedReason = '0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'X0 - Exempt Output') {
                                      valueChosedReason = '0';
                                      taxCode = 'X0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    }
                                    valueChossed = val.toString();

                                    print(val.toString());
                                    print("valavalaa: .........." +
                                        valueChosedReason.toString());
                                    print("taxSelected: .........." +
                                        taxSelected.toString());
                                    print("taxCode: .........." +
                                        taxCode.toString());
                                  });
                                },
                                items: taxData2.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e['name']}",
                                      child: Text(
                                        e['name'].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "cancel",
                                      style: TextStyles.whiteText(context),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      validation4Alert(context, i);
                                    },
                                    child: Text(
                                      "ok",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  String? valueChossed;
  void showBottomSheetUpdate(int i, ThemeData theme) {
    //nznznz

    showModalBottomSheet<dynamic>(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Form(
                    key: formkey[1],
                    child: Container(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[4],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER UNIT PRICE";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "unit price",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              child: new TextFormField(
                                controller: mycontroller[5],
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ENTER QUANTITY";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "quantity",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            //  ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              child: new TextFormField(
                                readOnly: true,
                                controller: mycontroller[6],
                                onChanged: (val) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "ENTER DISCOUNT";
                                //   }else if(value.isNotEmpty){
                                //       double dis =double.parse(value);
                                //       if(dis>100){
                                //         return "DISCOUNT MORE THAN 100";
                                //       }
                                //   }
                                //   return null;
                                // },
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: "Discount",
                                  labelStyle:
                                      TextStyles.bodytextBlack1(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton(
                                hint: Text(
                                  "Select Tax: ",
                                  style: TextStyles.bodytextBlack1(context),
                                ),
                                value: valueChossed,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    if (val == 'O0 - 0 % Output VAT') {
                                      valueChosedReason = '0';
                                      taxCode = 'O0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'O1 - 18 % Output VAT') {
                                      valueChosedReason = '18';
                                      taxCode = 'O1';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val ==
                                        'O3 - Exempted Output VAT') {
                                      taxCode = 'O3';
                                      valueChosedReason = '0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    } else if (val == 'X0 - Exempt Output') {
                                      valueChosedReason = '0';
                                      taxCode = 'X0';
                                      taxSelected = double.parse(
                                          valueChosedReason.toString());
                                    }
                                    if ("null" == val) {
                                      valueChossed = null;
                                    } else {
                                      valueChossed = val.toString();
                                    }
                                    log(val.toString());
                                    log("valueChosedReason: .........." +
                                        valueChosedReason.toString());
                                    log("taxSelected: .........." +
                                        taxSelected.toString());
                                    log("taxCode: .........." +
                                        taxCode.toString());
                                  });
                                },
                                items: taxData2.map((e) {
                                  return DropdownMenuItem(
                                      value: "${e['name']}",
                                      child: Text(
                                        e['name'].toString(),
                                        style:
                                            TextStyles.headlineBlack1(context),
                                      ));
                                }).toList(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: theme.primaryColor,
                                  ),
                                  child: Text(
                                    "cancel",
                                    style: TextStyles.whiteText(context),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      validation4AlertUpdate(context, i);
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyles.whiteText(context),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }

  List<Map<String, String>> taxData2 = [
    {"name": 'O0 - 0 % Output VAT'},
    {"name": "O1 - 18 % Output VAT"},
    {"name": "O3 - Exempted Output VAT"},
    {"name": "X0 - Exempt Output"},
  ];
  String? valueChosedReason;
  String? taxCode;
  double taxSelected = 0;
  static double discountper = 0;

  Future validation4Alert(BuildContext context, int i) async {
    if (formkey[0].currentState!.validate()) {
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      discountper = 0;
      final double price = double.parse(mycontroller[1].text);
      final double qty = double.parse(mycontroller[2].text);
      discountper =
          double.parse(mycontroller[3].text == '' ? '0' : mycontroller[3].text);
      final double discount = (price * qty) * discountper / 100;
      final double taxper = taxSelected;
      final double tax = ((qty * price) - discount) * taxper / 100;

      double total = (price * qty) - discount;
      log("total1::::" + total.toString());
      total = total + tax;
      log("total2::::" + total.toString());
      int carton2 = 0;
      if (filteritemValue[i].U_Pack_Size! < 10 &&
          filteritemValue[i].U_Tins_Per_Box! > 0) {
        carton2 = qty ~/ filteritemValue[i].U_Tins_Per_Box!;
        print("cartooooooone" + carton2.toString());
        print("cartooooooone" + carton2.toInt().toString());
      }
      // double valueAF = (qty * price) - discount;
      log("contentitemsDetailsxxx:::${contentitemsDetails.length}");
      contentitemsDetails.add(AddItem2(
          lineNumm: null,
          lineNoo: i,
          warehouse: filteritemValue[i].warehouse.toString(),
          itemCode: filteritemValue[i].itemCode.toString(),
          itemName: filteritemValue[i].itemName.toString(),
          discount: discount,
          price: price,
          qty: qty,
          total: total,
          tax: tax,
          valuechoosed: valueChossed,
          taxCode: taxCode,
          discounpercent: discountper,
          carton: carton2,
          valueAF: (price * qty) - discount,
          U_Pack_Size: filteritemValue[i].U_Pack_Size,
          U_Tins_Per_Box: filteritemValue[i].U_Tins_Per_Box,
          taxPer: taxper));
      itemlen = contentitemsDetails.length;
      print('lenthList: ' + contentitemsDetails.length.toString());

      editcontentitemsDetailss = contentitemsDetails;
      await pageController.animateToPage(--pageChanged,
          duration: Duration(milliseconds: 250), curve: Curves.bounceIn);

      Navigator.pop(context);
      sumofTotal();
    }
  }

  double grandtotal = 0;
  double discount = 0;
  void sumofTotal() {
    double basictotal = 0;
    double discount = 0;
    double tax = 0;
    setState(() {
      if (contentitemsDetails.isNotEmpty) {
        double taxxVal = 0;
        for (int i = 0; i < contentitemsDetails.length; i++) {
          taxxVal = contentitemsDetails[i].tax != null
              ? contentitemsDetails[i].tax!
              : 0;

          basictotal = basictotal + contentitemsDetails[i].total!.toDouble();
          discount = discount + contentitemsDetails[i].discount!.toDouble();
          tax = tax + taxxVal.toDouble();
        }
        print("grandtotal: " + basictotal.toString());

        //total over

        // for (int i = 0; i < contentitemsDetails.length; i++) {

        // }
        HeaderEditCreationState.discount = discount;
        HeaderEditCreationState.tax = tax;
        HeaderEditCreationState.total = basictotal - discount + tax;
        HeaderEditCreationState.totalBeforeDiscount = basictotal;
      } else {
        setState(() {
          discount = 0.00;
          grandtotal = 0.00;
          tax = 0.00;
          HeaderEditCreationState.total = grandtotal;
          HeaderEditCreationState.discount = discount;
          HeaderEditCreationState.tax = tax;
          HeaderEditCreationState.totalBeforeDiscount = grandtotal;
        });
      }
    });
  }

  Future validation4AlertUpdate(BuildContext context, int i) async {
    editcontentitemsDetailss = [];
    if (formkey[1].currentState!.validate()) {
      final double discperc = double.parse(mycontroller[6].text);
      // if(discperc <=100.00){
      final FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      log("Edit taxSelectedtaxSelected:::${taxSelected}");
      final double price = double.parse(mycontroller[4].text);
      final double qty = double.parse(mycontroller[5].text);
      final double discountper = double.parse(mycontroller[6].text);
      final double discount = (price * qty) * discountper / 100;
      final double taxper = taxSelected;
      final double tax = ((qty * price) - discount) * taxper / 100;
      final double total = (price * qty) - discount + tax;
      final double valueAfdisc = (qty * price) - discount;
      int carton2 = 0;
      contentitemsDetails[i].price = price;
      contentitemsDetails[i].qty = qty;
      contentitemsDetails[i].quantity = qty;

      contentitemsDetails[i].discount = discount;
      contentitemsDetails[i].total = total;
      contentitemsDetails[i].tax = tax;
      contentitemsDetails[i].taxCode = taxCode.toString();
      contentitemsDetails[i].valuechoosed = valueChossed.toString();
      contentitemsDetails[i].discounpercent = discountper;
      contentitemsDetails[i].valueAF = valueAfdisc;
      contentitemsDetails[i].taxPer = taxper;
      if (contentitemsDetails[i].U_Pack_Size! < 10 &&
          contentitemsDetails[i].U_Tins_Per_Box! > 0) {
        carton2 = qty ~/ contentitemsDetails[i].U_Tins_Per_Box!;
        print("cartooooooone" + carton2.toString());
        print("cartooooooone" + carton2.toInt().toString());
      }
      contentitemsDetails[i].carton = carton2;
      log("contentitemsDetails[i].qty:::${contentitemsDetails[i].qty}");
      editcontentitemsDetailss = contentitemsDetails;
      log("contentitemsDetails[i].qty:::${contentitemsDetails[i].qty}");
      log("editcontentitemsDetails[i].qty:::${editcontentitemsDetailss[i].qty}");

      Navigator.pop(context);
      sumofTotal();
      //   }
      // else{
      //    const snackBar = SnackBar(
      //                 duration: Duration(seconds: 5),
      //                 backgroundColor: Colors.red,
      //                 content: Text(
      //                   'Discount more than 100% !!..',
      //                   style: TextStyle(color: Colors.white),
      //                 ),
      //               );
      //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }
  }
}

class AddItem2 {
  int? lineNumm;
  String? itemCode;
  String? itemDescription;
  double? quantity;
  dynamic shipDate;
  double? price;
  double? priceAfterVat;
  String? currency;
  double? rate;
  double? discountPercent;
  String? vendorNum;
  dynamic serialNum;
  String? warehouseCode;
  int? salesPersonCode;
  double? commisionPercent;
  String? treeType;
  String? accountCode;
  String? useBaseUnits;
  String? supplierCatNum;
  String? costingCode;
  dynamic projectCode;
  dynamic barCode;
  String? vatGroup;
  double? height1;
  dynamic hight1Unit;
  double? height2;
  dynamic height2Unit;
  double? lengh1;
  dynamic lengh1Unit;
  double? lengh2;
  dynamic lengh2Unit;
  double? weight1;
  dynamic weight1Unit;
  double? weight2;
  dynamic weight2Unit;
  double? factor1;
  double? factor2;
  double? factor3;
  double? factor4;
  int? baseType;
  dynamic baseEntry;
  dynamic baseLine;
  double? volume;
  int? volumeUnit;
  double? width1;
  dynamic width1Unit;
  double? width2;
  dynamic width2Unit;
  String? address;
  dynamic taxCode;
  String? taxType;
  String? taxLiable;
  String? pickStatus;
  double? pickQuantity;
  dynamic pickListIdNumber;
  dynamic originalItem;
  dynamic backOrder;
  String? freeText;
  int? shippingMethod;
  dynamic poTargetNum;
  String? poTargetEntry;
  dynamic poTargetRowNum;
  String? correctionInvoiceItem;
  double? corrInvAmountToStock;
  double? corrInvAmountToDiffAcct;
  double? appliedTax;
  double? appliedTaxFc;
  double? appliedTaxSc;
  String? wtLiable;
  String? deferredTax;
  double? equalizationTaxPercent;
  double? totalEqualizationTax;
  double? totalEqualizationTaxFc;
  double? totalEqualizationTaxSc;
  double? netTaxAmount;
  double? netTaxAmountFc;
  double? netTaxAmountSc;
  String? measureUnit;
  double? unitsOfMeasurment;
  double? lineTotal;
  double? taxPercentagePerRow;
  double? taxTotal;
  String? consumerSalesForecast;
  double? exciseAmount;
  double? taxPerUnit;
  double? totalInclTax;
  dynamic countryOrg;
  String? sww;
  dynamic transactionType;
  String? distributeExpense;
  double? rowTotalFc;
  double? rowTotalSc;
  double? lastBuyInmPrice;
  double? lastBuyDistributeSumFc;
  double? lastBuyDistributeSumSc;
  double? lastBuyDistributeSum;
  double? stockDistributesumForeign;
  double? stockDistributesumSystem;
  double? stockDistributesum;
  double? stockInmPrice;
  String? pickStatusEx;
  double? taxBeforeDpm;
  double? taxBeforeDpmfc;
  double? taxBeforeDpmsc;
  dynamic cfopCode;
  dynamic cstCode;
  dynamic usage;
  String? taxOnly;
  int? visualOrder;
  double? baseOpenQuantity;
  double? unitPrice;
  String? lineStatus;
  double? packageQuantity;
  String? text;
  String? lineType;
  String? cogsCostingCode;
  String? cogsAccountCode;
  String? changeAssemlyBoMWarehouse;
  double? grossBuyPrice;
  int? grossBase;
  double? grossProfitTotalBasePrice;
  dynamic costingCode2;
  dynamic costingCode3;
  dynamic costingCode4;
  dynamic costingCode5;
  dynamic itemDetails;
  dynamic locationCode;
  dynamic actualDeliveryDate;
  double? remainingOpenQuantity;
  double? openAmount;
  double? openAmountFc;
  double? openAmountSc;
  dynamic exLineNo;
  dynamic Date;
  double? Quantity;
  dynamic cogsCostingCode2;
  dynamic cogsCostingCode3;
  dynamic cogsCostingCode4;
  dynamic cogsCostingCode5;
  dynamic csTforIpi;
  dynamic csTforPis;
  dynamic csTforCofins;
  dynamic creditOriginCode;
  String? withoutInventoryMovement;
  dynamic agreementNo;
  dynamic agreementRowNumber;
  dynamic actualBaseEntry;
  dynamic actualBaseLine;
  int? docEntry;
  double? surpluses;
  double? defectAndBreakup;
  double? shortages;
  String? considerQuantity;
  String? partialRetirement;
  double? retirementQuantity;
  double? retirementApc;
  String? thirdParty;
  dynamic poNum;
  dynamic poItmNum;
  dynamic expenseType;
  dynamic receiptNumber;
  dynamic expenseOperationType;
  dynamic federalTaxId;
  double? grossProfit;
  double? grossProfitFc;
  double? grossProfitSc;
  String? priceSource;
  dynamic stgSeqNum;
  dynamic stgEntry;
  dynamic stgDesc;
  int? uoMEntry;
  String? uoMCode;
  double? inventoryQuantity;
  double? remainingOpenInventoryQuantity;
  dynamic parentLineNum;
  int? incoterms;
  int? transportMode;
  dynamic natureOfTransaction;
  dynamic destinationCountryForImport;
  dynamic destinationRegionForImport;
  dynamic originCountryForExport;
  dynamic originRegionForExport;
  String? itemType;
  String? changeInventoryQuantityIndependently;
  String? freeOfChargeBp;
  dynamic sacEntry;
  dynamic hsnEntry;
  double? grossPrice;
  double? grossTotal;
  double? grossTotalFc;
  double? grossTotalSc;
  int? ncmCode;
  dynamic nveCode;
  String? indEscala;
  double? ctrSealQty;
  dynamic cnjpMan;
  int? cestCode;
  dynamic ufFiscalBenefitCode;
  String? shipToCode;
  String? shipToDescription;
  double? externalCalcTaxRate;
  double? externalCalcTaxAmount;
  double? externalCalcTaxAmountFc;
  double? externalCalcTaxAmountSc;
  int? standardItemIdentification;
  int? commodityClassification;
  dynamic unencumberedReason;
  String? cuSplit;
  dynamic uQtyOrdered;
  dynamic uOpenQty;
  dynamic uTonnage;
  dynamic uPackSize;
  dynamic uProfitCentre;
  dynamic uNumberDrums;
  dynamic uDrumSize;
  dynamic uPails;
  dynamic uCartons;
  dynamic uLooseTins;
  dynamic uNettWt;
  dynamic uGrossWt;
  dynamic uAppLinId;
  dynamic uMuQty;
  dynamic uRvc;
  dynamic uVrn;
  dynamic uIdentifier;
  String? itemName;
  double? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  double? discounpercent;
  String? warehouse;
  double? valueAF;
  int? carton;
  int? lineNoo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  // List<dynamic> lineTaxJurisdictions;
  // List<dynamic> documentLineAdditionalExpenses;

  AddItem2(
      {this.lineNumm,
      this.itemCode,
      this.itemDescription,
      this.quantity,
      this.shipDate,
      this.price,
      this.priceAfterVat,
      this.currency,
      this.rate,
      this.discountPercent,
      this.vendorNum,
      this.serialNum,
      this.warehouseCode,
      this.salesPersonCode,
      this.commisionPercent,
      this.treeType,
      this.accountCode,
      this.useBaseUnits,
      this.supplierCatNum,
      this.costingCode,
      this.projectCode,
      this.barCode,
      this.vatGroup,
      this.height1,
      this.hight1Unit,
      this.height2,
      this.height2Unit,
      this.lengh1,
      this.lengh1Unit,
      this.lengh2,
      this.lengh2Unit,
      this.weight1,
      this.weight1Unit,
      this.weight2,
      this.weight2Unit,
      this.factor1,
      this.factor2,
      this.factor3,
      this.factor4,
      this.baseType,
      this.baseEntry,
      this.baseLine,
      this.volume,
      this.volumeUnit,
      this.width1,
      this.width1Unit,
      this.width2,
      this.width2Unit,
      this.address,
      this.taxCode,
      this.taxType,
      this.taxLiable,
      this.pickStatus,
      this.pickQuantity,
      this.pickListIdNumber,
      this.originalItem,
      this.backOrder,
      this.freeText,
      this.shippingMethod,
      this.poTargetNum,
      this.poTargetEntry,
      this.poTargetRowNum,
      this.correctionInvoiceItem,
      this.corrInvAmountToStock,
      this.corrInvAmountToDiffAcct,
      this.appliedTax,
      this.appliedTaxFc,
      this.appliedTaxSc,
      this.wtLiable,
      this.deferredTax,
      this.equalizationTaxPercent,
      this.totalEqualizationTax,
      this.totalEqualizationTaxFc,
      this.totalEqualizationTaxSc,
      this.netTaxAmount,
      this.netTaxAmountFc,
      this.netTaxAmountSc,
      this.measureUnit,
      this.unitsOfMeasurment,
      this.lineTotal,
      this.taxPercentagePerRow,
      this.taxTotal,
      this.consumerSalesForecast,
      this.exciseAmount,
      this.taxPerUnit,
      this.totalInclTax,
      this.countryOrg,
      this.sww,
      this.transactionType,
      this.distributeExpense,
      this.rowTotalFc,
      this.rowTotalSc,
      this.lastBuyInmPrice,
      this.lastBuyDistributeSumFc,
      this.lastBuyDistributeSumSc,
      this.lastBuyDistributeSum,
      this.stockDistributesumForeign,
      this.stockDistributesumSystem,
      this.stockDistributesum,
      this.stockInmPrice,
      this.pickStatusEx,
      this.taxBeforeDpm,
      this.taxBeforeDpmfc,
      this.taxBeforeDpmsc,
      this.cfopCode,
      this.cstCode,
      this.usage,
      this.taxOnly,
      this.visualOrder,
      this.baseOpenQuantity,
      this.unitPrice,
      this.lineStatus,
      this.packageQuantity,
      this.text,
      this.lineType,
      this.cogsCostingCode,
      this.cogsAccountCode,
      this.changeAssemlyBoMWarehouse,
      this.grossBuyPrice,
      this.grossBase,
      this.grossProfitTotalBasePrice,
      this.costingCode2,
      this.costingCode3,
      this.costingCode4,
      this.costingCode5,
      this.itemDetails,
      this.locationCode,
      this.actualDeliveryDate,
      this.remainingOpenQuantity,
      this.openAmount,
      this.openAmountFc,
      this.openAmountSc,
      this.exLineNo,
      this.Date,
      this.Quantity,
      this.cogsCostingCode2,
      this.cogsCostingCode3,
      this.cogsCostingCode4,
      this.cogsCostingCode5,
      this.csTforIpi,
      this.csTforPis,
      this.csTforCofins,
      this.creditOriginCode,
      this.withoutInventoryMovement,
      this.agreementNo,
      this.agreementRowNumber,
      this.actualBaseEntry,
      this.actualBaseLine,
      this.docEntry,
      this.surpluses,
      this.defectAndBreakup,
      this.shortages,
      this.considerQuantity,
      this.partialRetirement,
      this.retirementQuantity,
      this.retirementApc,
      this.thirdParty,
      this.poNum,
      this.poItmNum,
      this.expenseType,
      this.receiptNumber,
      this.expenseOperationType,
      this.federalTaxId,
      this.grossProfit,
      this.grossProfitFc,
      this.grossProfitSc,
      this.priceSource,
      this.stgSeqNum,
      this.stgEntry,
      this.stgDesc,
      this.uoMEntry,
      this.uoMCode,
      this.inventoryQuantity,
      this.remainingOpenInventoryQuantity,
      this.parentLineNum,
      this.incoterms,
      this.transportMode,
      this.natureOfTransaction,
      this.destinationCountryForImport,
      this.destinationRegionForImport,
      this.originCountryForExport,
      this.originRegionForExport,
      this.itemType,
      this.changeInventoryQuantityIndependently,
      this.freeOfChargeBp,
      this.sacEntry,
      this.hsnEntry,
      this.grossPrice,
      this.grossTotal,
      this.grossTotalFc,
      this.grossTotalSc,
      this.ncmCode,
      this.nveCode,
      this.indEscala,
      this.ctrSealQty,
      this.cnjpMan,
      this.cestCode,
      this.ufFiscalBenefitCode,
      this.shipToCode,
      this.shipToDescription,
      this.externalCalcTaxRate,
      this.externalCalcTaxAmount,
      this.externalCalcTaxAmountFc,
      this.externalCalcTaxAmountSc,
      this.standardItemIdentification,
      this.commodityClassification,
      this.unencumberedReason,
      this.cuSplit,
      this.uQtyOrdered,
      this.uOpenQty,
      this.uTonnage,
      this.uPackSize,
      this.uProfitCentre,
      this.uNumberDrums,
      this.uDrumSize,
      this.uPails,
      this.uCartons,
      this.uLooseTins,
      this.uNettWt,
      this.uGrossWt,
      this.uAppLinId,
      this.uMuQty,
      this.uRvc,
      this.uVrn,
      this.uIdentifier,
      this.warehouse,
      this.itemName,
      this.discount,
      this.qty,
      this.total,
      this.tax,
      this.valuechoosed,
      this.discounpercent,
      this.taxPer,
      this.valueAF,
      this.lineNoo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box
      //  this.lineTaxJurisdictions,
      //  this.documentLineAdditionalExpenses,
      });

  // factory AddItem2.fromJson(dynamic json) => AddItem2(
  //       lineNum: int.parse(json['LineNum'].toString()),
  //       itemCode: json['ItemCode'].toString(),
  //       itemDescription: json['ItemDescription'].toString(),
  //       quantity: int.parse(json['Quantity'].toString()),
  //       shipDate: json['ShipDate'],
  //       price: double.parse(json['Price'].toString()),
  //       priceAfterVat: double.parse(json['PriceAfterVAT'].toString()),
  //       currency: json['Currency'].toString(),
  //       rate: double.parse(json['Rate'].toString()),
  //       discountPercent: double.parse(json['DiscountPercent'].toString()),
  //       vendorNum: json['VendorNum'].toString(),
  //       serialNum: json['SerialNum'].toString(),
  //       warehouseCode: json['WarehouseCode'].toString(),
  //       salesPersonCode: int.parse(json['SalesPersonCode'].toString()),
  //       commisionPercent: int.parse(json['CommisionPercent'].toString()),
  //       treeType: json['TreeType'].toString(),
  //       accountCode: json['AccountCode'].toString(),
  //       useBaseUnits: json['UseBaseUnits'].toString(),
  //       supplierCatNum: json['SupplierCatNum'].toString(),
  //       costingCode: json['CostingCode'].toString(),
  //       projectCode: json['ProjectCode'].toString(),
  //       barCode: json['BarCode'].toString(),
  //       vatGroup: json['VatGroup'].toString(),
  //       height1: double.parse(json['Height1'].toString()),
  //       hight1Unit: json['Hight1Unit'].toString(),
  //       height2: double.parse(json['Height2'].toString()),
  //       height2Unit: json['Height2Unit'].toString(),
  //       lengh1: double.parse(json['Lengh1'].toString()),
  //       lengh1Unit: json['Lengh1Unit'].toString(),
  //       lengh2: double.parse(json['Lengh2'].toString()),
  //       lengh2Unit: int.parse(json['Lengh2Unit'].toString()),
  //       weight1: double.parse(json['Weight1'].toString()),
  //       weight1Unit: json['Weight1Unit'],
  //       weight2: double.parse(json['Weight2'].toString()),
  //       weight2Unit: json['Weight2Unit'],
  //       factor1: double.parse(json['Factor1'].toString()),
  //       factor2: double.parse(json['Factor2'].toString()),
  //       factor3: double.parse(json['Factor3'].toString()),
  //       factor4: double.parse(json['Factor4'].toString()),
  //       baseType: int.parse(
  //         json['BaseType'].toString(),
  //       ),
  //       baseEntry: json['BaseEntry'],
  //       baseLine: json['BaseLine'],
  //       volume: double.parse(json['Volume'].toString()),
  //       volumeUnit: double.parse(json['VolumeUnit'].toString()),
  //       width1: double.parse(json['Width1'].toString()),
  //       width1Unit: json['Width1Unit'],
  //       width2: double.parse(json['Width2'].toString()),
  //       width2Unit: json['Width2Unit'],
  //       address: json['Address'].toString(),
  //       taxCode: json['TaxCode'],
  //       taxType: json['TaxType'].toString(),
  //       taxLiable: json['TaxLiable'].toString(),
  //       pickStatus: json['PickStatus'].toString(),
  //       pickQuantity: int.parse(json['PickQuantity'].toString()),
  //       pickListIdNumber: json['PickListIdNumber'],
  //       originalItem: json['OriginalItem'],
  //       backOrder: json['BackOrder'],
  //       freeText: json['FreeText'].toString(),
  //       shippingMethod: int.parse(json['ShippingMethod'].toString()),
  //       poTargetNum: json['POTargetNum'].toString(),
  //       poTargetEntry: json['POTargetEntry'].toString(),
  //       poTargetRowNum: json['POTargetRowNum'],
  //       correctionInvoiceItem: json['CorrectionInvoiceItem'].toString(),
  //       corrInvAmountToStock:
  //           int.parse(json['CorrInvAmountToStock'].toString()),
  //       corrInvAmountToDiffAcct:
  //           int.parse(json['CorrInvAmountToDiffAcct'].toString()),
  //       appliedTax: int.parse(json['AppliedTax'].toString()),
  //       appliedTaxFc: int.parse(json['AppliedTaxFC'].toString()),
  //       appliedTaxSc: int.parse(json['AppliedTaxSC'].toString()),
  //       wtLiable: json['WTLiable'].toString(),
  //       deferredTax: json['DeferredTax'].toString(),
  //       equalizationTaxPercent:
  //           int.parse(json['EqualizationTaxPercent'].toString()),
  //       totalEqualizationTax:
  //           int.parse(json['TotalEqualizationTax'].toString()),
  //       totalEqualizationTaxFc:
  //           int.parse(json['TotalEqualizationTaxFC'].toString()),
  //       totalEqualizationTaxSc:
  //           int.parse(json['TotalEqualizationTaxSC'].toString()),
  //       netTaxAmount: double.parse(json['NetTaxAmount'].toString()),
  //       netTaxAmountFc: int.parse(json['NetTaxAmountFC'].toString()),
  //       netTaxAmountSc: double.parse(json['NetTaxAmountSC'].toString()),
  //       measureUnit: json['MeasureUnit'].toString(),
  //       unitsOfMeasurment: int.parse(json['UnitsOfMeasurment'].toString()),
  //       lineTotal: double.parse(json['LineTotal'].toString()),
  //       taxPercentagePerRow: int.parse(json['TaxPercentagePerRow'].toString()),
  //       taxTotal: double.parse(json['TaxTotal'].toString()),
  //       consumerSalesForecast: json['ConsumerSalesForecast'].toString(),
  //       exciseAmount: int.parse(json['ExciseAmount'].toString()),
  //       totalInclTax: int.parse(json['TotalInclTax'].toString()),
  //       countryOrg: json['CountryOrg'],
  //       sww: json['SWW'].toString(),
  //       transactionType: json['TransactionType'].toString(),
  //       distributeExpense: json['DistributeExpense'].toString(),
  //       rowTotalFc: int.parse(json['RowTotalFC'].toString()),
  //       rowTotalSc: double.parse(json['RowTotalSC'].toString()),
  //       lastBuyInmPrice: int.parse(json['LastBuyInmPrice'].toString()),
  //       lastBuyDistributeSumFc:
  //           int.parse(json['LastBuyDistributeSumFc'].toString()),
  //       lastBuyDistributeSumSc:
  //           int.parse(json['LastBuyDistributeSumSc'].toString()),
  //       lastBuyDistributeSum:
  //           int.parse(json['LastBuyDistributeSum'].toString()),
  //       stockDistributesumForeign:
  //           int.parse(json['StockDistributesumForeign'].toString()),
  //       stockDistributesumSystem:
  //           int.parse(json['StockDistributesumSystem'].toString()),
  //       stockDistributesum: int.parse(json['StockDistributesum'].toString()),
  //       stockInmPrice: int.parse(json['StockInmPrice'].toString()),
  //       pickStatusEx: json['PickStatusEx'].toString(),
  //       taxBeforeDpm: int.parse(json['TaxBeforeDPM'].toString()),
  //       taxBeforeDpmfc: int.parse(json['TaxBeforeDPMFC'].toString()),
  //       taxBeforeDpmsc: int.parse(json['TaxBeforeDPMSC'].toString()),
  //       cfopCode: json['CFOPCode'],
  //       cstCode: json['CSTCode'],
  //       usage: json['Usage'],
  //       taxOnly: json['TaxOnly'].toString(),
  //       visualOrder: int.parse(json['VisualOrder'].toString()),
  //       baseOpenQuantity: int.parse(json['BaseOpenQuantity'].toString()),
  //       unitPrice: double.parse(json['UnitPrice'].toString()),
  //       lineStatus: json['LineStatus'].toString(),
  //       packageQuantity: int.parse(json['PackageQuantity'].toString()),
  //       text: json['Text'].toString(),
  //       lineType: json['LineType'].toString(),
  //       cogsCostingCode: json['COGSCostingCode'].toString(),
  //       cogsAccountCode: json['COGSAccountCode'].toString(),
  //       changeAssemlyBoMWarehouse: json['ChangeAssemlyBoMWarehouse'].toString(),
  //       grossBuyPrice: double.parse(json['GrossBuyPrice'].toString()),
  //       grossBase: int.parse(json['GrossBase'].toString()),
  //       grossProfitTotalBasePrice:
  //           double.parse(json['GrossProfitTotalBasePrice'].toString()),
  //       costingCode2: json['CostingCode2'],
  //       costingCode3: json['CostingCode3'],
  //       costingCode4: json['CostingCode4'],
  //       costingCode5: json['CostingCode5'],
  //       itemDetails: json['ItemDetails'],
  //       locationCode: json['LocationCode'],
  //       actualDeliveryDate: json['ActualDeliveryDate'],
  //       remainingOpenQuantity:
  //           int.parse(json['RemainingOpenQuantity'].toString()),
  //       openAmount: double.parse(json['OpenAmount'].toString()),
  //       openAmountFc: int.parse(json['OpenAmountFC'].toString()),
  //       openAmountSc: double.parse(json['OpenAmountSC'].toString()),
  //       exLineNo: json['ExLineNo'],
  //       Date: json[' Date'],
  //       Quantity: int.parse(json[' Quantity'].toString()),
  //       cogsCostingCode2: json['COGSCostingCode2'],
  //       cogsCostingCode3: json['COGSCostingCode3'],
  //       cogsCostingCode4: json['COGSCostingCode4'],
  //       cogsCostingCode5: json['COGSCostingCode5'],
  //       csTforIpi: json['CSTforIPI'],
  //       csTforPis: json['CSTforPIS'],
  //       csTforCofins: json['CSTforCOFINS'],
  //       creditOriginCode: json['CreditOriginCode'],
  //       withoutInventoryMovement: json['WithoutInventoryMovement'].toString(),
  //       agreementNo: json['AgreementNo'],
  //       agreementRowNumber: json['AgreementRowNumber'],
  //       actualBaseEntry: json['ActualBaseEntry'],
  //       actualBaseLine: json['ActualBaseLine'],
  //       docEntry: int.parse(json['DocEntry'].toString()),
  //       surpluses: int.parse(json['Surpluses'].toString()),
  //       defectAndBreakup: int.parse(json['DefectAndBreakup'].toString()),
  //       shortages: int.parse(json['Shortages'].toString()),
  //       considerQuantity: json['ConsiderQuantity'].toString(),
  //       partialRetirement: json['PartialRetirement'].toString(),
  //       retirementQuantity: int.parse(json['RetirementQuantity'].toString()),
  //       retirementApc: int.parse(json['RetirementAPC'].toString()),
  //       thirdParty: json['ThirdParty'].toString(),
  //       poNum: json['PoNum'],
  //       poItmNum: json['PoItmNum'],
  //       expenseType: json['ExpenseType'],
  //       receiptNumber: json['ReceiptNumber'],
  //       expenseOperationType: json['ExpenseOperationType'],
  //       federalTaxId: json['FederalTaxID'],
  //       grossProfit: double.parse(json['GrossProfit'].toString()),
  //       grossProfitFc: int.parse(json['GrossProfitFC'].toString()),
  //       grossProfitSc: double.parse(json['GrossProfitSC'].toString()),
  //       priceSource: json['PriceSource'].toString(),
  //       stgSeqNum: json['StgSeqNum'],
  //       stgEntry: json['StgEntry'],
  //       stgDesc: json['StgDesc'],
  //       uoMEntry: int.parse(json['UoMEntry'].toString()),
  //       uoMCode: json['UoMCode'].toString(),
  //       inventoryQuantity: int.parse(json['InventoryQuantity'].toString()),
  //       remainingOpenInventoryQuantity:
  //           int.parse(json['RemainingOpenInventoryQuantity'].toString()),
  //       parentLineNum: int.parse(json['ParentLineNum'].toString()),
  //       incoterms: int.parse(json['Incoterms'].toString()),
  //       transportMode: int.parse(json['TransportMode'].toString()),
  //       natureOfTransaction: json['NatureOfTransaction'],
  //       destinationCountryForImport: json['DestinationCountryForImport'],
  //       destinationRegionForImport: json['DestinationRegionForImport'],
  //       originCountryForExport: json['OriginCountryForExport'],
  //       originRegionForExport: json['OriginRegionForExport'],
  //       itemType: json['ItemType'].toString(),
  //       changeInventoryQuantityIndependently:
  //           json['ChangeInventoryQuantityIndependently'].toString(),
  //       freeOfChargeBp: json['FreeOfChargeBP'].toString(),
  //       sacEntry: json['SACEntry'],
  //       hsnEntry: json['HSNEntry'],
  //       grossPrice: int.parse(json['GrossPrice'].toString()),
  //       grossTotal: double.parse(json['GrossTotal'].toString()),
  //       grossTotalFc: int.parse(json['GrossTotalFC'].toString()),
  //       grossTotalSc: double.parse(json['GrossTotalSC'].toString()),
  //       ncmCode: int.parse(json['NCMCode'].toString()),
  //       nveCode: json['NVECode'],
  //       indEscala: json['IndEscala'].toString(),
  //       ctrSealQty: int.parse(json['CtrSealQty'].toString()),
  //       cnjpMan: json['CNJPMan'],
  //       cestCode: int.parse(json['CESTCode'].toString()),
  //       ufFiscalBenefitCode: json['UFFiscalBenefitCode'],
  //       shipToCode:
  //           json['ShipToCode'] != null ? json['ShipToCode'].toString() : null,
  //       shipToDescription: json['ShipToDescription'].toString(),
  //       externalCalcTaxRate: int.parse(json['ExternalCalcTaxRate'].toString()),
  //       externalCalcTaxAmount:
  //           int.parse(json['ExternalCalcTaxAmount'].toString()),
  //       externalCalcTaxAmountFc:
  //           int.parse(json['ExternalCalcTaxAmountFC'].toString()),
  //       externalCalcTaxAmountSc:
  //           int.parse(json['ExternalCalcTaxAmountSC'].toString()),
  //       standardItemIdentification:
  //           int.parse(json['StandardItemIdentification'].toString()),
  //       commodityClassification:
  //           int.parse(json['CommodityClassification'].toString()),
  //       unencumberedReason: json['UnencumberedReason'],
  //       cuSplit: json['CUSplit'].toString(),
  //       uQtyOrdered: json['U_Qty_Ordered'],
  //       uOpenQty: json['U_Open_Qty'],
  //       uTonnage: json['U_Tonnage'],
  //       uPackSize: json['U_PackSize'],
  //       uProfitCentre: json['U_Profit_Centre'],
  //       uNumberDrums: json['U_Number_Drums'],
  //       uDrumSize: json['U_Drum_Size'],
  //       uPails: json['U_Pails'],
  //       uCartons: json['U_Cartons'],
  //       uLooseTins: json['U_Loose_Tins'],
  //       uNettWt: json['U_Nett_Wt'],
  //       uGrossWt: json['U_Gross_Wt'],
  //       uAppLinId: json['U_AppLinId'],
  //       uMuQty: json['U_MUQty'],
  //       uRvc: json['U_RVC'],
  //       uVrn: json['U_VRN'],
  //       uIdentifier: json['U_Identifier'],
  //       taxPerUnit: double.parse(json['TaxPerUnit'].toString()),
  //       // lineTaxJurisdictions: List<dynamic>.from(json['LineTaxJurisdictions'].map((x) => x)),
  //       // documentLineAdditionalExpenses: List<dynamic>.from(json['DocumentLineAdditionalExpenses'].map((x) => x)),
  //     );

  Map<String, dynamic> toJson() => {
        'LineNum': lineNumm,
        'ItemCode': itemCode,
        'ItemDescription': itemDescription,
        'Quantity': quantity,
        'ShipDate': shipDate,
        'Price': price,
        'PriceAfterVAT': priceAfterVat,
        'Currency': currency,
        'Rate': rate,
        'DiscountPercent': discountPercent,
        'VendorNum': vendorNum,
        'SerialNum': serialNum,
        'WarehouseCode': warehouseCode,
        'SalesPersonCode': salesPersonCode,
        'CommisionPercent': commisionPercent,
        'TreeType': treeType,
        'AccountCode': accountCode,
        'UseBaseUnits': useBaseUnits,
        'SupplierCatNum': supplierCatNum,
        'CostingCode': costingCode,
        'ProjectCode': projectCode,
        'BarCode': barCode,
        'VatGroup': vatGroup,
        'Height1': height1,
        'Hight1Unit': hight1Unit,
        'Height2': height2,
        'Height2Unit': height2Unit,
        'Lengh1': lengh1,
        'Lengh1Unit': lengh1Unit,
        'Lengh2': lengh2,
        'Lengh2Unit': lengh2Unit,
        'Weight1': weight1,
        'Weight1Unit': weight1Unit,
        'Weight2': weight2,
        'Weight2Unit': weight2Unit,
        'Factor1': factor1,
        'Factor2': factor2,
        'Factor3': factor3,
        'Factor4': factor4,
        'BaseType': baseType,
        'BaseEntry': baseEntry,
        'BaseLine': baseLine,
        'Volume': volume,
        'VolumeUnit': volumeUnit,
        'Width1': width1,
        'Width1Unit': width1Unit,
        'Width2': width2,
        'Width2Unit': width2Unit,
        'Address': address,
        'TaxCode': taxCode,
        'TaxType': taxType,
        'TaxLiable': taxLiable,
        'PickStatus': pickStatus,
        'PickQuantity': pickQuantity,
        'PickListIdNumber': pickListIdNumber,
        'OriginalItem': originalItem,
        'BackOrder': backOrder,
        'FreeText': freeText,
        'ShippingMethod': shippingMethod,
        'POTargetNum': poTargetNum,
        'POTargetEntry': poTargetEntry,
        'POTargetRowNum': poTargetRowNum,
        'CorrectionInvoiceItem': correctionInvoiceItem,
        'CorrInvAmountToStock': corrInvAmountToStock,
        'CorrInvAmountToDiffAcct': corrInvAmountToDiffAcct,
        'AppliedTax': appliedTax,
        'AppliedTaxFC': appliedTaxFc,
        'AppliedTaxSC': appliedTaxSc,
        'WTLiable': wtLiable,
        'DeferredTax': deferredTax,
        'EqualizationTaxPercent': equalizationTaxPercent,
        'TotalEqualizationTax': totalEqualizationTax,
        'TotalEqualizationTaxFC': totalEqualizationTaxFc,
        'TotalEqualizationTaxSC': totalEqualizationTaxSc,
        'NetTaxAmount': netTaxAmount,
        'NetTaxAmountFC': netTaxAmountFc,
        'NetTaxAmountSC': netTaxAmountSc,
        'MeasureUnit': measureUnit,
        'UnitsOfMeasurment': unitsOfMeasurment,
        'LineTotal': lineTotal,
        'TaxPercentagePerRow': taxPercentagePerRow,
        'TaxTotal': taxTotal,
        'ConsumerSalesForecast': consumerSalesForecast,
        'ExciseAmount': exciseAmount,
        'TaxPerUnit': taxPerUnit,
        'TotalInclTax': totalInclTax,
        'CountryOrg': countryOrg,
        'SWW': sww,
        'TransactionType': transactionType,
        'DistributeExpense': distributeExpense,
        'RowTotalFC': rowTotalFc,
        'RowTotalSC': rowTotalSc,
        'LastBuyInmPrice': lastBuyInmPrice,
        'LastBuyDistributeSumFc': lastBuyDistributeSumFc,
        'LastBuyDistributeSumSc': lastBuyDistributeSumSc,
        'LastBuyDistributeSum': lastBuyDistributeSum,
        'StockDistributesumForeign': stockDistributesumForeign,
        'StockDistributesumSystem': stockDistributesumSystem,
        'StockDistributesum': stockDistributesum,
        'StockInmPrice': stockInmPrice,
        'PickStatusEx': pickStatusEx,
        'TaxBeforeDPM': taxBeforeDpm,
        'TaxBeforeDPMFC': taxBeforeDpmfc,
        'TaxBeforeDPMSC': taxBeforeDpmsc,
        'CFOPCode': cfopCode,
        'CSTCode': cstCode,
        'Usage': usage,
        'TaxOnly': taxOnly,
        'VisualOrder': visualOrder,
        'BaseOpenQuantity': baseOpenQuantity,
        'UnitPrice': unitPrice,
        'LineStatus': lineStatus,
        'PackageQuantity': packageQuantity,
        'Text': text,
        'LineType': lineType,
        'COGSCostingCode': cogsCostingCode,
        'COGSAccountCode': cogsAccountCode,
        'ChangeAssemlyBoMWarehouse': changeAssemlyBoMWarehouse,
        'GrossBuyPrice': grossBuyPrice,
        'GrossBase': grossBase,
        'GrossProfitTotalBasePrice': grossProfitTotalBasePrice,
        'CostingCode2': costingCode2,
        'CostingCode3': costingCode3,
        'CostingCode4': costingCode4,
        'CostingCode5': costingCode5,
        'ItemDetails': itemDetails,
        'LocationCode': locationCode,
        'ActualDeliveryDate': actualDeliveryDate,
        'RemainingOpenQuantity': remainingOpenQuantity,
        'OpenAmount': openAmount,
        'OpenAmountFC': openAmountFc,
        'OpenAmountSC': openAmountSc,
        'ExLineNo': exLineNo,
        ' Date': Date,
        ' Quantity': Quantity,
        'COGSCostingCode2': cogsCostingCode2,
        'COGSCostingCode3': cogsCostingCode3,
        'COGSCostingCode4': cogsCostingCode4,
        'COGSCostingCode5': cogsCostingCode5,
        'CSTforIPI': csTforIpi,
        'CSTforPIS': csTforPis,
        'CSTforCOFINS': csTforCofins,
        'CreditOriginCode': creditOriginCode,
        'WithoutInventoryMovement': withoutInventoryMovement,
        'AgreementNo': agreementNo,
        'AgreementRowNumber': agreementRowNumber,
        'ActualBaseEntry': actualBaseEntry,
        'ActualBaseLine': actualBaseLine,
        'DocEntry': docEntry,
        'Surpluses': surpluses,
        'DefectAndBreakup': defectAndBreakup,
        'Shortages': shortages,
        'ConsiderQuantity': considerQuantity,
        'PartialRetirement': partialRetirement,
        'RetirementQuantity': retirementQuantity,
        'RetirementAPC': retirementApc,
        'ThirdParty': thirdParty,
        'PoNum': poNum,
        'PoItmNum': poItmNum,
        'ExpenseType': expenseType,
        'ReceiptNumber': receiptNumber,
        'ExpenseOperationType': expenseOperationType,
        'FederalTaxID': federalTaxId,
        'GrossProfit': grossProfit,
        'GrossProfitFC': grossProfitFc,
        'GrossProfitSC': grossProfitSc,
        'PriceSource': priceSource,
        'StgSeqNum': stgSeqNum,
        'StgEntry': stgEntry,
        'StgDesc': stgDesc,
        'UoMEntry': uoMEntry,
        'UoMCode': uoMCode,
        'InventoryQuantity': inventoryQuantity,
        'RemainingOpenInventoryQuantity': remainingOpenInventoryQuantity,
        'ParentLineNum': parentLineNum,
        'Incoterms': incoterms,
        'TransportMode': transportMode,
        'NatureOfTransaction': natureOfTransaction,
        'DestinationCountryForImport': destinationCountryForImport,
        'DestinationRegionForImport': destinationRegionForImport,
        'OriginCountryForExport': originCountryForExport,
        'OriginRegionForExport': originRegionForExport,
        'ItemType': itemType,
        'ChangeInventoryQuantityIndependently':
            changeInventoryQuantityIndependently,
        'FreeOfChargeBP': freeOfChargeBp,
        'SACEntry': sacEntry,
        'HSNEntry': hsnEntry,
        'GrossPrice': grossPrice,
        'GrossTotal': grossTotal,
        'GrossTotalFC': grossTotalFc,
        'GrossTotalSC': grossTotalSc,
        'NCMCode': ncmCode,
        'NVECode': nveCode,
        'IndEscala': indEscala,
        'CtrSealQty': ctrSealQty,
        'CNJPMan': cnjpMan,
        'CESTCode': cestCode,
        'UFFiscalBenefitCode': ufFiscalBenefitCode,
        'ShipToCode': shipToCode,
        'ShipToDescription': shipToDescription,
        'ExternalCalcTaxRate': externalCalcTaxRate,
        'ExternalCalcTaxAmount': externalCalcTaxAmount,
        'ExternalCalcTaxAmountFC': externalCalcTaxAmountFc,
        'ExternalCalcTaxAmountSC': externalCalcTaxAmountSc,
        'StandardItemIdentification': standardItemIdentification,
        'CommodityClassification': commodityClassification,
        'UnencumberedReason': unencumberedReason,
        'CUSplit': cuSplit,
        'U_Qty_Ordered': uQtyOrdered,
        'U_Open_Qty': uOpenQty,
        'U_Tonnage': uTonnage,
        'U_PackSize': uPackSize,
        'U_Profit_Centre': uProfitCentre,
        'U_Number_Drums': uNumberDrums,
        'U_Drum_Size': uDrumSize,
        'U_Pails': uPails,
        'U_Cartons': uCartons,
        'U_Loose_Tins': uLooseTins,
        'U_Nett_Wt': uNettWt,
        'U_Gross_Wt': uGrossWt,
        'U_AppLinId': uAppLinId,
        'U_MUQty': uMuQty,
        'U_RVC': uRvc,
        'U_VRN': uVrn,
        'U_Identifier': uIdentifier,
        // 'LineTaxJurisdictions': List<dynamic>.from(lineTaxJurisdictions.map((x) => x)),
        // 'DocumentLineAdditionalExpenses': List<dynamic>.from(documentLineAdditionalExpenses.map((x) => x)),
      };
}

class AddItem3 {
  String? itemName;
  String itemCode;
  double? price;
  double? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  String? taxCode;
  double? discounpercent;
  String? warehouse;
  String? shipToCode;
  double? valueAF;
  int? carton;
  int? lineNo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  AddItem3(
      {required this.itemCode,
      this.warehouse,
      this.itemName,
      this.price,
      this.discount,
      this.qty,
      this.total,
      this.tax,
      this.valuechoosed,
      this.taxCode,
      this.discounpercent,
      this.taxPer,
      this.shipToCode,
      this.valueAF,
      this.lineNo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "LineNum": lineNo,
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": "TZS",
      "ShipToCode": LogisticEditPageState.shipto.toString(),
      "valueAF": valueAF.toString(),
      "WarehouseCode": warehouse
    };
    return map;
  }
}
