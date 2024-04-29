// // ignore_for_file: omit_local_variable_types
// import 'dart:developer';

// class ApprovalDetailsValue {
//   int? docEntry;
//   String? cardCode; //
//   String? cardName; //
//   int? DocNum; //
//   String? DocDate; //
//   List<DocumentApprovalValue>? documentLines; //
//   String? DocumentStatus;
//   String? CancelStatus;
//   String? DocCurrency;
//   double? totalDiscount;
//   double? vatSum; //
//   double? docTotal; //
//   String? DocDueDate;
//   int? salesPersonCode;
// //  dynamic numAtCard;
// //  String? taxDate;
// //  String? docDueDate;
// //  AddressExtension? addressExtension;
// //  int? transportationCode;
//   String? error;
//   String? U_OrderDate;
//   String? U_Order_Type;
//   String? U_GP_Approval;
//   String? U_Received_Time;
//   String? numAt;

//   String? PostOrder_Type;
//   String? PostGP_Approval;
//   ApprovalDetailsValue(
//       {this.docEntry,
//       this.cardCode,
//       this.cardName,
//       this.DocNum,
//       this.DocDate,
//       this.documentLines,
//       this.DocumentStatus,
//       this.CancelStatus,
//       this.DocCurrency,
//       this.docTotal,
//       this.totalDiscount,
//       this.vatSum,
//       this.error,
//       this.DocDueDate,
//       this.U_Received_Time,
//       this.U_Order_Type,
//       this.U_OrderDate,
//       this.U_GP_Approval,
//       this.numAt,
//       this.PostGP_Approval,
//       this.PostOrder_Type,
//       this.salesPersonCode});

//   factory ApprovalDetailsValue.fromJson(dynamic jsons) {
//     if (jsons['DocumentLines'] != null && jsons['AddressExtension'] != null) {
//       final list = jsons['DocumentLines'] as List; //jsonDecode
//       // print(list);
//       List<DocumentApprovalValue> dataList = list
//           .map((dynamic enquiries) => DocumentApprovalValue.fromJson(enquiries))
//           .toList();
//           log("TaxCodeTaxCode::"+dataList[0].TaxCode.toString());
//       return ApprovalDetailsValue(
//         //  groupCode: jsons['GroupCode'] as int,
//         docEntry: jsons['DocEntry'] as int,
//         cardCode: jsons['CardCode'].toString(),
//         cardName: jsons['CardName'].toString(),
//         DocDate: jsons['DocDate'].toString(),
//         DocNum: jsons['DocNum'] as int,
//         DocumentStatus: jsons['DocumentStatus'].toString(),
//         CancelStatus: jsons['CancelStatus'].toString(),
//         DocCurrency: jsons['DocCurrency'].toString(),
//         documentLines: dataList,
//         salesPersonCode: jsons['SalesPersonCode'] as int,
//         // numAtCard:jsons['NumAtCard'],
//         // taxDate:  jsons['TaxDate'] .toString(),
//         // docDueDate:  jsons['DocDueDate'] .toString(),
//         // comments: jsons['Comments'].toString(),
//         docTotal: jsons['DocTotal'] as double,
//         totalDiscount: jsons['TotalDiscount'] as double,
//         vatSum: jsons['VatSum'] as double,
//         DocDueDate: jsons['DocDueDate'].toString(),
//         U_OrderDate:
//             jsons['U_OrderDate'] == null ? '' : jsons['U_OrderDate'] as String,

// U_GP_Approval: jsons['U_Order_Type'] == null
//     ? ''
//     : jsons['U_Order_Type'] == '0'
//         ? 'No'
//         : jsons['U_Order_Type'] == '1'
//             ? 'Yes'
//             : jsons['U_Order_Type'] as String,

// U_Order_Type: jsons['U_GP_Approval'] == null
//     ? ''
//     : jsons['U_GP_Approval'] == '0'
//         ? 'Select'
//         : jsons['U_GP_Approval'] == '1'
//             ? 'Normal'
//             : jsons['U_GP_Approval'] == '2'
//                 ? 'Depot Transfer'
//                 : jsons['U_GP_Approval'] == '3'
//                     ? 'Root Sale'
//                     : jsons['U_GP_Approval'] == '4'
//                         ? 'Project Sale'
//                         : jsons['U_GP_Approval'] == '5'
//                             ? 'Special Order'
//                             : jsons['U_GP_Approval'] as String,

//         U_Received_Time: jsons['U_Received_Time'] == null
//             ? ''
//             : jsons['U_Received_Time'] as String,
//         numAt: jsons['NumAtCard'] == null ? '' : jsons['NumAtCard'] as String,
//         PostOrder_Type: jsons['U_Order_Type'] == null
//             ? ''
//             : jsons['U_Order_Type'] as String,
//         PostGP_Approval: jsons['U_GP_Approval'] == null
//             ? ''
//             : jsons['U_GP_Approval'] as String,
//       );
//     } else {
//       return ApprovalDetailsValue(
//         DocDate: jsons['DocDate'].toString(),
//       );
//     }
//   }

//   factory ApprovalDetailsValue.issue(String e) {
//     return ApprovalDetailsValue(
//       error: e,
//     );
//   }
// }

// class DocumentApprovalValue {
//   int? LineNum;
//   String? ItemCode;
//   String? ItemDescription;
//   double? Quantity;
//   double? Price;
//   String? TaxCode;
//   double? LineTotal;
//   double? UnitPrice;
//   double? TaxTotal;
//   double? discountPercent;
//   double? total;
//   String? warehouseCode;
//   int? BaseEntry;
//   int? BaseLine;
//   int? BaseType;
// //  "BaseEntry": 48514,
// //             "BaseLine": 0,
//   DocumentApprovalValue(
//       {this.LineNum,
//       this.ItemCode,
//       this.ItemDescription,
//       this.LineTotal,
//       this.Price,
//       this.Quantity,
//       this.TaxCode,
//       this.UnitPrice,
//       this.TaxTotal,
//       this.discountPercent,
//       this.total,
//       this.warehouseCode,
//       this.BaseEntry,
//       this.BaseLine,
//       this.BaseType});

//   factory DocumentApprovalValue.fromJson(dynamic jsons) {
//     return DocumentApprovalValue(
//       LineNum: jsons['LineNum'] as int,
//       //  groupCode: jsons['GroupCode'] as int,
//       ItemCode: jsons['ItemCode'].toString(), //
//       ItemDescription: jsons['ItemDescription'].toString(), //
//       LineTotal: jsons['LineTotal'] == null
//           ? 0
//           : jsons['LineTotal'] as double, //value before tax
//       Price: jsons['UnitPrice'] == null ? 0 : jsons['UnitPrice'] as double, //
//       Quantity: jsons['Quantity'] == null ? 0 : jsons['Quantity'] as double, //
//       TaxCode: jsons['TaxCode'] .toString(),
//       //UnitPrice:  jsons['UnitPrice'] as double,
//       TaxTotal: jsons['TaxTotal'] == null ? 0 : jsons['TaxTotal'] as double,
//       discountPercent: jsons['DiscountPercent'] == null
//           ? 0
//           : jsons['DiscountPercent'] as double,
//       total: jsons['PriceAfterVAT'] == null
//           ? 0
//           : jsons['PriceAfterVAT'] as double, //PriceAfterVAT
//       warehouseCode: jsons['WarehouseCode'].toString(),
//       BaseEntry: jsons['BaseEntry'] == null ? 0 : jsons['BaseEntry'] as int,
//       BaseLine: jsons['BaseLine'] == null ? 0 : jsons['BaseLine'] as int,
//       BaseType: jsons['BaseType'] == null ? 0 : jsons['BaseType'] as int,
//     );
//   }
// }

// class AddressExtension {
//   String? billToStreet;
//   dynamic billToStreetNo;
//   String? billToBlock;
//   dynamic billToBuilding;
//   String? billToCity;
//   String? billToZipCode;
//   String? billToCounty;
//   String? billToState;
//   String? shipToStreet;
//   String? shipToStreetNo;
//   String? shipToBlock;
//   String? shipToBuilding;
//   String? shipToCity;
//   String? shipToZipCode;
//   String? shipToCounty;
//   String? shipToState;
//   String? shipToCountry;
//   AddressExtension({
//     this.billToStreet,
//     this.billToStreetNo,
//     this.billToBlock,
//     this.billToBuilding,
//     this.billToCity,
//     this.billToZipCode,
//     this.billToCounty,
//     this.billToState,
//     this.shipToStreet,
//     this.shipToStreetNo,
//     this.shipToBlock,
//     this.shipToBuilding,
//     this.shipToCity,
//     this.shipToZipCode,
//     this.shipToCounty,
//     this.shipToState,
//     this.shipToCountry,
//     //  this.grossTotal
//   });

//   factory AddressExtension.fromJson(dynamic jsons) {
//     return AddressExtension(
//       billToStreet:
//           jsons['BillToStreet'] == null ? '' : jsons['BillToStreet'].toString(),
//       billToStreetNo: jsons['BillToStreetNo'],
//       billToBlock: jsons['BillToBlock'].toString(),
//       billToBuilding: jsons['BillToBuilding'].toString(),
//       billToCity:
//           jsons['BillToCity'] == null ? '' : jsons['BillToCity'].toString(),
//       billToZipCode: jsons['BillToZipCode'].toString(),
//       billToCounty:
//           jsons['billToCounty'] == null ? '' : jsons['billToCounty'].toString(),
//       billToState:
//           jsons['BillToState'] == null ? '' : jsons['BillToState'].toString(),
//       shipToStreet:
//           jsons['ShipToStreet'] == null ? '' : jsons['ShipToStreet'].toString(),
//       shipToStreetNo: jsons['ShipToStreetNo'].toString(),
//       shipToBlock: jsons['ShipToBlock'].toString(),
//       shipToBuilding: jsons['ShipToBuilding'].toString(),
//       shipToCity:
//           jsons['ShipToCity'] == null ? '' : jsons['ShipToCity'].toString(),
//       shipToZipCode: jsons['ShipToZipCode'].toString(),
//       shipToCounty: jsons['ShipToCounty'].toString(),
//       shipToState:
//           jsons['ShipToState'] == null ? '' : jsons['ShipToState'].toString(),
//       shipToCountry: jsons['ShipToCountry'] == null
//           ? ''
//           : jsons['ShipToCountry'].toString(),
//     );
//   }
// }
// To parse this JSON data, do
//
//     final ApprovalDetailsValue = ApprovalDetailsValueFromJson(jsonString);

import 'dart:convert';

import '../sales_quot/QuotPutModel.dart';

class ApprovalDetailsValue {
  String? error;
  String? odataMetadata;
  String? odataEtag;
  int? docEntry;
  int? docNum;
  String? docType;
  String? handWritten;
  String? printed;
  String? docDate;
  String? docDueDate;
  String? cardCode;
  String? cardName;
  String? address;
  String? numAtCard;
  double? docTotal;
  dynamic attachmentEntry;
  String? docCurrency;
  double? docRate;
  String? reference1;
  dynamic reference2;
  dynamic comments;
  String? journalMemo;
  int? paymentGroupCode;
  String? docTime;
  int? salesPersonCode;
  int? transportationCode;
  String? confirmed;
  int? importFileNum;
  String? summeryType;
  int? contactPersonCode;
  String? showScn;
  int? series;
  String? taxDate;
  String? partialSupply;
  String? docObjectCode;
  String? shipToCode;
  dynamic indicator;
  String? federalTaxId;
  double? discountPercent;
  dynamic paymentReference;
  String? creationDate;
  String? updateDate;
  int? financialPeriod;
  int? userSign;
  dynamic transNum;
  double? vatSum;
  double? vatSumSys;
  double? vatSumFc;
  String? netProcedure;
  double? docTotalFc;
  double? docTotalSys;
  dynamic form1099;
  dynamic box1099;
  String? revisionPo;
  dynamic requriedDate;
  dynamic cancelDate;
  String? blockDunning;
  String? submitted;
  int? segment;
  String? pickStatus;
  String? pick;
  String? paymentMethod;
  String? paymentBlock;
  dynamic paymentBlockEntry;
  dynamic centralBankIndicator;
  String? maximumCashDiscount;
  String? reserve;
  dynamic project;
  dynamic exemptionValidityDateFrom;
  dynamic exemptionValidityDateTo;
  String? wareHouseUpdateType;
  String? rounding;
  dynamic externalCorrectedDocNum;
  dynamic internalCorrectedDocNum;
  dynamic nextCorrectingDocument;
  String? deferredTax;
  dynamic taxExemptionLetterNum;
  double? wtApplied;
  double? wtAppliedFc;
  String? billOfExchangeReserved;
  dynamic agentCode;
  double? wtAppliedSc;
  double? totalEqualizationTax;
  double? totalEqualizationTaxFc;
  double? totalEqualizationTaxSc;
  int? numberOfInstallments;
  String? applyTaxOnFirstInstallment;
  double? wtNonSubjectAmount;
  double? wtNonSubjectAmountSc;
  double? wtNonSubjectAmountFc;
  double? wtExemptedAmount;
  double? wtExemptedAmountSc;
  double? wtExemptedAmountFc;
  double? baseAmount;
  double? baseAmountSc;
  double? baseAmountFc;
  double? wtAmount;
  double? wtAmountSc;
  double? wtAmountFc;

  dynamic vatDate;
  dynamic documentsOwner;
  dynamic folioPrefixString;
  dynamic folioNumber;
  String? documentSubType;
  dynamic bpChannelCode;
  dynamic bpChannelContact;
  String? address2;
  String? documentStatus;
  String? periodIndicator;
  String? payToCode;
  dynamic manualNumber;
  String? useShpdGoodsAct;
  String? isPayToBank;
  dynamic payToBankCountry;
  dynamic payToBankCode;
  dynamic payToBankAccountNo;
  dynamic payToBankBranch;
  dynamic bplIdAssignedToInvoice;

  double? downPayment;
  String? reserveInvoice;
  int? languageCode;
  dynamic trackingNumber;
  dynamic pickRemark;
  dynamic closingDate;
  dynamic sequenceCode;
  dynamic sequenceSerial;
  dynamic seriesString;
  dynamic subSeriesString;
  String? sequenceModel;
  String? useCorrectionVatGroup;
  double? totalDiscount;
  double? downPaymentAmount;
  double? downPaymentPercentage;

  String? downPaymentType;
  double? downPaymentAmountSc;
  double? downPaymentAmountFc;
  double? vatPercent;
  dynamic serviceGrossProfitPercent;
  dynamic openingRemarks;
  dynamic closingRemarks;
  double? roundingDiffAmount;
  double? roundingDiffAmountFc;
  double? roundingDiffAmountSc;

  String? cancelled;
  dynamic signatureInputMessage;
  dynamic signatureDigest;
  dynamic certificationNumber;
  dynamic privateKeyVersion;
  String? controlAccount;
  String? insuranceOperation347;
  String? archiveNonremovableSalesQuotation;
  dynamic gtsChecker;
  dynamic gtsPayee;
  int? extraMonth;
  int? extraDays;
  int? cashDiscountDateOffset;
  String? startFrom;
  String? ntsApproved;
  dynamic eTaxWebSite;
  dynamic eTaxNumber;
  dynamic ntsApprovedNumber;
  String? eDocGenerationType;
  dynamic eDocSeries;
  dynamic eDocNum;
  dynamic eDocExportFormat;
  String? eDocStatus;
  dynamic eDocErrorCode;
  dynamic eDocErrorMessage;
  String? downPaymentStatus;
  dynamic groupSeries;
  dynamic groupNumber;
  String? groupHandWritten;
  dynamic reopenOriginalDocument;
  dynamic reopenManuallyClosedOrCanceledDocument;
  String? createOnlineQuotation;
  dynamic posEquipmentNumber;
  dynamic posManufacturerSerialNumber;
  dynamic posCashierNumber;
  String? applyCurrentVatRatesForDownPaymentsToDraw;
  String? closingOption;
  dynamic specifiedClosingDate;
  String? openForLandedCosts;
  String? authorizationStatus;
  double? totalDiscountFc;
  double? totalDiscountSc;
  String? relevantToGts;
  dynamic bplName;
  dynamic vatRegNum;
  dynamic annualInvoiceDeclarationReference;
  dynamic supplier;
  dynamic releaser;
  dynamic receiver;
  dynamic blanketAgreementNumber;
  String? isAlteration;
  String? cancelStatus;
  dynamic assetValueDate;
  String? documentDelivery;
  dynamic authorizationCode;
  dynamic startDeliveryDate;
  dynamic startDeliveryTime;
  dynamic endDeliveryDate;
  dynamic endDeliveryTime;
  dynamic vehiclePlate;
  dynamic atDocumentType;
  dynamic elecCommStatus;
  dynamic elecCommMessage;
  String? reuseDocumentNum;
  String? reuseNotaFiscalNum;
  String? printSepaDirect;
  dynamic fiscalDocNum;
  dynamic posDailySummaryNo;
  dynamic posReceiptNo;
  dynamic pointOfIssueCode;
  dynamic letter;
  dynamic folioNumberFrom;
  dynamic folioNumberTo;
  String? interimType;
  int? relatedType;
  dynamic relatedEntry;
  dynamic sapPassport;
  dynamic documentTaxId;
  dynamic dateOfReportingControlStatementVat;
  dynamic reportingSectionControlStatementVat;
  String? excludeFromTaxReportControlStatementVat;
  dynamic posCashRegister;
  String? updateTime;
  dynamic createQrCodeFrom;
  dynamic priceMode;
  String? shipFrom;
  String? commissionTrade;
  String? commissionTradeReturn;
  String? useBillToAddrToDetermineTax;
  dynamic cig;
  dynamic cup;
  dynamic fatherCard;
  String? fatherType;
  dynamic shipState;
  dynamic shipPlace;
  dynamic custOffice;
  dynamic fci;
  dynamic addLegIn;
  dynamic legTextF;
  dynamic danfeLgTxt;
  String? indFinal;
  int? dataVersion;
  String? uPurchaseType;
  String? uApApprove;
  String? uFinalDel;
  dynamic uIncoTerms;
  dynamic uSourceDest;
  dynamic uTransNo;
  dynamic uVehicleNo;
  dynamic uSupplierDt;
  dynamic uQuotNo;
  dynamic uQuotDate;
  String? uGovPermit;
  dynamic uGovPermitdt;
  dynamic uCheckNo;
  dynamic uCheckDate;
  String? uApprovalDate;
  String? uOrderNoRecd;
  String? uOrderDate;
  dynamic uClearingAgent;
  dynamic uDateSubAgent;
  dynamic uIdfno;
  dynamic uIdfDate;
  dynamic uInspectionNo;
  dynamic uEta;
  dynamic uAirwayBillNo;
  dynamic uBol;
  dynamic uCotecna;
  dynamic uArrivalDate;
  double? uDahacoAgentFees;
  double? uPortCharges;
  double? uOtherExp;
  double? uClearCharges;
  double? uHiddenChrges;
  dynamic uGoodsInspBy;
  dynamic uGoodsReport;
  dynamic uPymtStatus;
  dynamic uPymtType;
  dynamic uTtCopyImage;
  dynamic uPfiImage;
  dynamic uSupplierImage;
  dynamic uBolImage;
  String? uOrderType;
  String? uTruckInternal;
  String? uGpApproval;
  dynamic uSupplierName;
  dynamic uVatNumber;
  String? uTransferType;
  dynamic uSalesOrder;
  String? uReceived;
  dynamic uDriverName;
  dynamic uReserveInvoice;
  dynamic uRefSeries;
  String? uReceivedTime;
  dynamic uSkuBatchNo;
  dynamic uInwardNo;
  dynamic uDispatchTime;
  dynamic uReceivedDate;
  dynamic uExpiryDate;
  String? uCnType;
  dynamic uTinNo;
  dynamic uLpoNo;
  double? uOrderQty;
  dynamic uDispatchDate;
  dynamic uBranch;
  dynamic uSalAppEntry;
  int? uDocType;
  dynamic uIntKey;
  dynamic uQrFileLoc;
  dynamic uRctCde;
  dynamic uZno;
  dynamic uVfdIn;
  dynamic uQrPath;
  dynamic uQrValue;
  dynamic uIdate;
  dynamic uItime;
  dynamic uDeviceCode;
  dynamic uDeviceTransId;
  dynamic uRvc;
  dynamic uVrn;
  dynamic uLongitude;
  dynamic uLatitude;
  dynamic uAuditJobGroup;
  dynamic uAuditName;
  dynamic uRequest;
  dynamic uPosDocNo;
  // List<dynamic> documentApprovalRequests;
  List<DocumentApprovalValue>? documentLines;
  // List<dynamic> electronicProtocols;
  // List<dynamic> documentAdditionalExpenses;
  // List<dynamic> documentSpecialLines;
  TaxExtension? taxExtension;
  AddressExtension? addressExtension;
  List<DocumentReference>? documentReferences;

  ApprovalDetailsValue({
    this.documentReferences,
    this.odataMetadata,
    this.odataEtag,
    this.docEntry,
    this.docNum,
    this.docType,
    this.handWritten,
    this.printed,
    this.docDate,
    this.docDueDate,
    this.cardCode,
    this.cardName,
    this.address,
    this.numAtCard,
    this.docTotal,
    this.attachmentEntry,
    this.docCurrency,
    this.docRate,
    this.reference1,
    this.reference2,
    this.comments,
    this.journalMemo,
    this.paymentGroupCode,
    this.docTime,
    this.salesPersonCode,
    this.transportationCode,
    this.confirmed,
    this.importFileNum,
    this.summeryType,
    this.contactPersonCode,
    this.showScn,
    this.series,
    this.taxDate,
    this.partialSupply,
    this.docObjectCode,
    this.shipToCode,
    this.indicator,
    this.federalTaxId,
    this.discountPercent,
    this.paymentReference,
    this.creationDate,
    this.updateDate,
    this.financialPeriod,
    this.userSign,
    this.transNum,
    this.vatSum,
    this.vatSumSys,
    this.vatSumFc,
    this.netProcedure,
    this.docTotalFc,
    this.docTotalSys,
    this.form1099,
    this.box1099,
    this.revisionPo,
    this.requriedDate,
    this.cancelDate,
    this.blockDunning,
    this.submitted,
    this.segment,
    this.pickStatus,
    this.pick,
    this.paymentMethod,
    this.paymentBlock,
    this.paymentBlockEntry,
    this.centralBankIndicator,
    this.maximumCashDiscount,
    this.reserve,
    this.project,
    this.exemptionValidityDateFrom,
    this.exemptionValidityDateTo,
    this.wareHouseUpdateType,
    this.rounding,
    this.externalCorrectedDocNum,
    this.internalCorrectedDocNum,
    this.nextCorrectingDocument,
    this.deferredTax,
    this.taxExemptionLetterNum,
    this.wtApplied,
    this.wtAppliedFc,
    this.billOfExchangeReserved,
    this.agentCode,
    this.wtAppliedSc,
    this.totalEqualizationTax,
    this.totalEqualizationTaxFc,
    this.totalEqualizationTaxSc,
    this.numberOfInstallments,
    this.applyTaxOnFirstInstallment,
    this.wtNonSubjectAmount,
    this.wtNonSubjectAmountSc,
    this.wtNonSubjectAmountFc,
    this.wtExemptedAmount,
    this.wtExemptedAmountSc,
    this.wtExemptedAmountFc,
    this.baseAmount,
    this.baseAmountSc,
    this.baseAmountFc,
    this.wtAmount,
    this.wtAmountSc,
    this.wtAmountFc,
    this.vatDate,
    this.documentsOwner,
    this.folioPrefixString,
    this.folioNumber,
    this.documentSubType,
    this.bpChannelCode,
    this.bpChannelContact,
    this.address2,
    this.documentStatus,
    this.periodIndicator,
    this.payToCode,
    this.manualNumber,
    this.useShpdGoodsAct,
    this.isPayToBank,
    this.payToBankCountry,
    this.payToBankCode,
    this.payToBankAccountNo,
    this.payToBankBranch,
    this.bplIdAssignedToInvoice,
    this.downPayment,
    this.reserveInvoice,
    this.languageCode,
    this.trackingNumber,
    this.pickRemark,
    this.closingDate,
    this.sequenceCode,
    this.sequenceSerial,
    this.seriesString,
    this.subSeriesString,
    this.sequenceModel,
    this.useCorrectionVatGroup,
    this.totalDiscount,
    this.downPaymentAmount,
    this.downPaymentPercentage,
    this.downPaymentType,
    this.downPaymentAmountSc,
    this.downPaymentAmountFc,
    this.vatPercent,
    this.serviceGrossProfitPercent,
    this.openingRemarks,
    this.closingRemarks,
    this.roundingDiffAmount,
    this.roundingDiffAmountFc,
    this.roundingDiffAmountSc,
    this.cancelled,
    this.signatureInputMessage,
    this.signatureDigest,
    this.certificationNumber,
    this.privateKeyVersion,
    this.controlAccount,
    this.insuranceOperation347,
    this.archiveNonremovableSalesQuotation,
    this.gtsChecker,
    this.gtsPayee,
    this.extraMonth,
    this.extraDays,
    this.cashDiscountDateOffset,
    this.startFrom,
    this.ntsApproved,
    this.eTaxWebSite,
    this.eTaxNumber,
    this.ntsApprovedNumber,
    this.eDocGenerationType,
    this.eDocSeries,
    this.eDocNum,
    this.eDocExportFormat,
    this.eDocStatus,
    this.eDocErrorCode,
    this.eDocErrorMessage,
    this.downPaymentStatus,
    this.groupSeries,
    this.groupNumber,
    this.groupHandWritten,
    this.reopenOriginalDocument,
    this.reopenManuallyClosedOrCanceledDocument,
    this.createOnlineQuotation,
    this.posEquipmentNumber,
    this.posManufacturerSerialNumber,
    this.posCashierNumber,
    this.applyCurrentVatRatesForDownPaymentsToDraw,
    this.closingOption,
    this.specifiedClosingDate,
    this.openForLandedCosts,
    this.authorizationStatus,
    this.totalDiscountFc,
    this.totalDiscountSc,
    this.relevantToGts,
    this.bplName,
    this.vatRegNum,
    this.annualInvoiceDeclarationReference,
    this.supplier,
    this.releaser,
    this.receiver,
    this.blanketAgreementNumber,
    this.isAlteration,
    this.cancelStatus,
    this.assetValueDate,
    this.documentDelivery,
    this.authorizationCode,
    this.startDeliveryDate,
    this.startDeliveryTime,
    this.endDeliveryDate,
    this.endDeliveryTime,
    this.vehiclePlate,
    this.atDocumentType,
    this.elecCommStatus,
    this.elecCommMessage,
    this.reuseDocumentNum,
    this.reuseNotaFiscalNum,
    this.printSepaDirect,
    this.fiscalDocNum,
    this.posDailySummaryNo,
    this.posReceiptNo,
    this.pointOfIssueCode,
    this.letter,
    this.folioNumberFrom,
    this.folioNumberTo,
    this.interimType,
    this.relatedType,
    this.relatedEntry,
    this.sapPassport,
    this.documentTaxId,
    this.dateOfReportingControlStatementVat,
    this.reportingSectionControlStatementVat,
    this.excludeFromTaxReportControlStatementVat,
    this.posCashRegister,
    this.updateTime,
    this.createQrCodeFrom,
    this.priceMode,
    this.shipFrom,
    this.commissionTrade,
    this.commissionTradeReturn,
    this.useBillToAddrToDetermineTax,
    this.cig,
    this.cup,
    this.fatherCard,
    this.fatherType,
    this.shipState,
    this.shipPlace,
    this.custOffice,
    this.fci,
    this.addLegIn,
    this.legTextF,
    this.danfeLgTxt,
    this.indFinal,
    this.dataVersion,
    this.uPurchaseType,
    this.uApApprove,
    this.uFinalDel,
    this.uIncoTerms,
    this.uSourceDest,
    this.uTransNo,
    this.uVehicleNo,
    this.uSupplierDt,
    this.uQuotNo,
    this.uQuotDate,
    this.uGovPermit,
    this.uGovPermitdt,
    this.uCheckNo,
    this.uCheckDate,
    this.uApprovalDate,
    this.uOrderNoRecd,
    this.uOrderDate,
    this.uClearingAgent,
    this.uDateSubAgent,
    this.uIdfno,
    this.uIdfDate,
    this.uInspectionNo,
    this.uEta,
    this.uAirwayBillNo,
    this.uBol,
    this.uCotecna,
    this.uArrivalDate,
    this.uDahacoAgentFees,
    this.uPortCharges,
    this.uOtherExp,
    this.uClearCharges,
    this.uHiddenChrges,
    this.uGoodsInspBy,
    this.uGoodsReport,
    this.uPymtStatus,
    this.uPymtType,
    this.uTtCopyImage,
    this.uPfiImage,
    this.uSupplierImage,
    this.uBolImage,
    this.uOrderType,
    this.uTruckInternal,
    this.uGpApproval,
    this.uSupplierName,
    this.uVatNumber,
    this.uTransferType,
    this.uSalesOrder,
    this.uReceived,
    this.uDriverName,
    this.uReserveInvoice,
    this.uRefSeries,
    this.uReceivedTime,
    this.uSkuBatchNo,
    this.uInwardNo,
    this.uDispatchTime,
    this.uReceivedDate,
    this.uExpiryDate,
    this.uCnType,
    this.uTinNo,
    this.uLpoNo,
    this.uOrderQty,
    this.uDispatchDate,
    this.uBranch,
    this.uSalAppEntry,
    this.uDocType,
    this.uIntKey,
    this.uQrFileLoc,
    this.uRctCde,
    this.uZno,
    this.uVfdIn,
    this.uQrPath,
    this.uQrValue,
    this.uIdate,
    this.uItime,
    this.uDeviceCode,
    this.uDeviceTransId,
    this.uRvc,
    this.uVrn,
    this.uLongitude,
    this.uLatitude,
    this.uAuditJobGroup,
    this.uAuditName,
    this.uRequest,
    this.uPosDocNo,
    //   this.documentApprovalRequests,
    this.documentLines,
    //   this.electronicProtocols,
    //   this.documentAdditionalExpenses,
    //   this.documentSpecialLines,
    this.taxExtension,
    this.addressExtension,
    this.error,
    //   this.documentReferences,
  });

  factory ApprovalDetailsValue.fromJson(dynamic json) {
    final list = json['DocumentLines'] as List;
    List<DocumentApprovalValue> dataList = list
        .map((dynamic enquiries) => DocumentApprovalValue.fromJson(enquiries))
        .toList();
    List<DocumentReference> dataList2 = [];

    if (json['DocumentReferences'] != null) {
      final list2 = json['DocumentReferences'] as List;
      dataList2 = list2
          .map((dynamic enquiries) => DocumentReference.fromJson(enquiries))
          .toList();
    }
    return ApprovalDetailsValue(
      documentLines: dataList,
      //  List<DocumentLine>.from(json['DocumentLines'].map((x) => DocumentLine.fromJson(x))),
      documentReferences: dataList2,
      odataMetadata: json['odata.metadata'] == null
          ? null
          : json['odata.metadata'].toString(),
      odataEtag:
          json['odata.etag'] == null ? null : json['odata.etag'].toString(),
      docEntry: json['DocEntry'] == null
          ? null
          : int.parse(json['DocEntry'].toString()),
      docNum:
          json['DocNum'] == null ? null : int.parse(json['DocNum'].toString()),
      docType: json['DocType'] == null ? null : json['DocType'].toString(),
      handWritten:
          json['HandWritten'] == null ? null : json['HandWritten'].toString(),
      printed: json['Printed'] == null ? null : json['Printed'].toString(),
      docDate: json['DocDate'] == null ? null : json['DocDate'].toString(),
      docDueDate:
          json['DocDueDate'] == null ? null : json['DocDueDate'].toString(),
      cardCode: json['CardCode'] == null ? null : json['CardCode'].toString(),
      cardName: json['CardName'] == null ? null : json['CardName'].toString(),
      address: json['Address'] == null ? null : json['Address'].toString(),
      numAtCard:
          json['NumAtCard'] == null ? null : json['NumAtCard'].toString(),
      docTotal: json['DocTotal'] == null
          ? null
          : double.parse(json['DocTotal'].toString()),
      attachmentEntry:
          json['AttachmentEntry'] == null ? null : json['AttachmentEntry'],
      docCurrency:
          json['DocCurrency'] == null ? null : json['DocCurrency'].toString(),
      docRate: json['DocRate'] == null
          ? null
          : double.parse(json['DocRate'].toString()),
      reference1:
          json['Reference1'] == null ? null : json['Reference1'].toString(),
      reference2: json['Reference2'] == null ? null : json['Reference2'],
      comments: json['Comments'] == null ? null : json['Comments'],
      journalMemo:
          json['JournalMemo'] == null ? null : json['JournalMemo'].toString(),
      paymentGroupCode: json['PaymentGroupCode'] == null
          ? null
          : int.parse(json['PaymentGroupCode'].toString()),
      docTime: json['DocTime'] == null ? null : json['DocTime'].toString(),
      salesPersonCode: json['SalesPersonCode'] == null
          ? null
          : int.parse(json['SalesPersonCode'].toString()),
      transportationCode: json['TransportationCode'] == null
          ? null
          : int.parse(json['TransportationCode'].toString()),
      confirmed:
          json['Confirmed'] == null ? null : json['Confirmed'].toString(),
      importFileNum: json['ImportFileNum'] == null
          ? null
          : int.parse(json['ImportFileNum'].toString()),
      summeryType:
          json['SummeryType'] == null ? null : json['SummeryType'].toString(),
      contactPersonCode: json['ContactPersonCode'] == null
          ? null
          : int.parse(json['ContactPersonCode'].toString()),
      showScn: json['ShowSCN'] == null ? null : json['ShowSCN'].toString(),
      series:
          json['Series'] == null ? null : int.parse(json['Series'].toString()),
      taxDate: json['TaxDate'] == null ? null : json['TaxDate'].toString(),
      partialSupply: json['PartialSupply'] == null
          ? null
          : json['PartialSupply'].toString(),
      docObjectCode: json['DocObjectCode'] == null
          ? null
          : json['DocObjectCode'].toString(),
      shipToCode: json['ShipToCode'] != null || json['ShipToCode'] != 'null'
          ? null
          : json['ShipToCode'].toString(),
      indicator: json['Indicator'] == null ? null : json['Indicator'],
      federalTaxId:
          json['FederalTaxID'] != null || json['FederalTaxID'] != 'null'
              ? null
              : json['FederalTaxID'].toString(),
      discountPercent: json['DiscountPercent'] == null
          ? null
          : double.parse(json['DiscountPercent'].toString()),
      paymentReference:
          json['PaymentReference'] == null ? null : json['PaymentReference'],
      creationDate:
          json['CreationDate'] == null ? null : json['CreationDate'].toString(),
      updateDate:
          json['UpdateDate'] == null ? null : json['UpdateDate'].toString(),
      financialPeriod: json['FinancialPeriod'] == null
          ? null
          : int.parse(json['FinancialPeriod'].toString()),
      userSign: json['UserSign'] == null
          ? null
          : int.parse(json['UserSign'].toString()),
      transNum: json['TransNum'] == null ? null : json['TransNum'],
      vatSum: json['VatSum'] == null
          ? null
          : double.parse(json['VatSum'].toString()),
      vatSumSys: json['VatSumSys'] == null
          ? null
          : double.parse(json['VatSumSys'].toString()),
      vatSumFc: json['VatSumFc'] == null
          ? null
          : double.parse(json['VatSumFc'].toString()),
      netProcedure:
          json['NetProcedure'] == null ? null : json['NetProcedure'].toString(),
      docTotalFc: json['DocTotalFc'] == null
          ? null
          : double.parse(json['DocTotalFc'].toString()),
      docTotalSys: json['DocTotalSys'] == null
          ? null
          : double.parse(json['DocTotalSys'].toString()),
      form1099: json['Form1099'] == null ? null : json['Form1099'],
      box1099: json['Box1099'] == null ? null : json['Box1099'],
      revisionPo:
          json['RevisionPo'] == null ? null : json['RevisionPo'].toString(),
      requriedDate: json['RequriedDate'] == null ? null : json['RequriedDate'],
      cancelDate: json['CancelDate'] == null ? null : json['CancelDate'],
      blockDunning:
          json['BlockDunning'] == null ? null : json['BlockDunning'].toString(),
      submitted:
          json['Submitted'] == null ? null : json['Submitted'].toString(),
      segment: json['Segment'] == null
          ? null
          : int.parse(json['Segment'].toString()),
      pickStatus:
          json['PickStatus'] == null ? null : json['PickStatus'].toString(),
      pick: json['Pick'] == null ? null : json['Pick'].toString(),
      paymentMethod: json['PaymentMethod'] == null
          ? null
          : json['PaymentMethod'].toString(),
      paymentBlock:
          json['PaymentBlock'] == null ? null : json['PaymentBlock'].toString(),
      paymentBlockEntry:
          json['PaymentBlockEntry'] == null ? null : json['PaymentBlockEntry'],
      centralBankIndicator: json['CentralBankIndicator'] == null
          ? null
          : json['CentralBankIndicator'],
      maximumCashDiscount: json['MaximumCashDiscount'] == null
          ? null
          : json['MaximumCashDiscount'].toString(),
      reserve: json['Reserve'] == null ? null : json['Reserve'].toString(),
      project: json['Project'] == null ? null : json['Project'],
      exemptionValidityDateFrom: json['ExemptionValidityDateFrom'] == null
          ? null
          : json['ExemptionValidityDateFrom'],
      exemptionValidityDateTo: json['ExemptionValidityDateTo'] == null
          ? null
          : json['ExemptionValidityDateTo'],
      wareHouseUpdateType: json['WareHouseUpdateType'] == null
          ? null
          : json['WareHouseUpdateType'].toString(),
      rounding: json['Rounding'] == null ? null : json['Rounding'].toString(),
      externalCorrectedDocNum: json['ExternalCorrectedDocNum'] == null
          ? null
          : json['ExternalCorrectedDocNum'],
      internalCorrectedDocNum: json['InternalCorrectedDocNum'] == null
          ? null
          : json['InternalCorrectedDocNum'],
      nextCorrectingDocument: json['NextCorrectingDocument'] == null
          ? null
          : json['NextCorrectingDocument'],
      deferredTax:
          json['DeferredTax'] == null ? null : json['DeferredTax'].toString(),
      taxExemptionLetterNum: json['TaxExemptionLetterNum'] == null
          ? null
          : json['TaxExemptionLetterNum'],
      wtApplied: json['WTApplied'] == null
          ? null
          : double.parse(json['WTApplied'].toString()),
      wtAppliedFc: json['WTAppliedFC'] == null
          ? null
          : double.parse(json['WTAppliedFC'].toString()),
      billOfExchangeReserved: json['BillOfExchangeReserved'] == null
          ? null
          : json['BillOfExchangeReserved'].toString(),
      agentCode: json['AgentCode'] == null ? null : json['AgentCode'],
      wtAppliedSc: json['WTAppliedSC'] == null
          ? null
          : double.parse(json['WTAppliedSC'].toString()),
      totalEqualizationTax: json['TotalEqualizationTax'] == null
          ? null
          : double.parse(json['TotalEqualizationTax'].toString()),
      totalEqualizationTaxFc: json['TotalEqualizationTaxFC'] == null
          ? null
          : double.parse(json['TotalEqualizationTaxFC'].toString()),
      totalEqualizationTaxSc: json['TotalEqualizationTaxSC'] == null
          ? null
          : double.parse(json['TotalEqualizationTaxSC'].toString()),
      numberOfInstallments: json['NumberOfInstallments'] == null
          ? null
          : int.parse(json['NumberOfInstallments'].toString()),
      applyTaxOnFirstInstallment: json['ApplyTaxOnFirstInstallment'] == null
          ? null
          : json['ApplyTaxOnFirstInstallment'].toString(),
      wtNonSubjectAmount: json['WTNonSubjectAmount'] == null
          ? null
          : double.parse(json['WTNonSubjectAmount'].toString()),
      wtNonSubjectAmountSc: json['WTNonSubjectAmountSC'] == null
          ? null
          : double.parse(json['WTNonSubjectAmountSC'].toString()),
      wtNonSubjectAmountFc: json['WTNonSubjectAmountFC'] == null
          ? null
          : double.parse(json['WTNonSubjectAmountFC'].toString()),
      wtExemptedAmount: json['WTExemptedAmount'] == null
          ? null
          : double.parse(json['WTExemptedAmount'].toString()),
      wtExemptedAmountSc: json['WTExemptedAmountSC'] == null
          ? null
          : double.parse(json['WTExemptedAmountSC'].toString()),
      wtExemptedAmountFc: json['WTExemptedAmountFC'] == null
          ? null
          : double.parse(
              json['WTExemptedAmountFC'].toString(),
            ),
      baseAmount: json['BaseAmount'] == null
          ? null
          : double.parse(json['BaseAmount'].toString()),
      baseAmountSc: json['BaseAmountSC'] == null
          ? null
          : double.parse(json['BaseAmountSC'].toString()),
      baseAmountFc: json['BaseAmountFC'] == null
          ? null
          : double.parse(json['BaseAmountFC'].toString()),
      wtAmount: json['WTAmount'] == null
          ? null
          : double.parse(json['WTAmount'].toString()),
      wtAmountSc: json['WTAmountSC'] == null
          ? null
          : double.parse(json['WTAmountSC'].toString()),
      wtAmountFc: json['WTAmountFC'] == null
          ? null
          : double.parse(json['WTAmountFC'].toString()),
      vatDate: json['VatDate'] == null ? null : json['VatDate'],
      documentsOwner:
          json['DocumentsOwner'] == null ? null : json['DocumentsOwner'],
      folioPrefixString:
          json['FolioPrefixString'] == null ? null : json['FolioPrefixString'],
      folioNumber: json['FolioNumber'] == null ? null : json['FolioNumber'],
      documentSubType: json['DocumentSubType'] == null
          ? null
          : json['DocumentSubType'].toString(),
      bpChannelCode:
          json['BPChannelCode'] == null ? null : json['BPChannelCode'],
      bpChannelContact:
          json['BPChannelContact'] == null ? null : json['BPChannelContact'],
      address2: json['Address2'] == null ? null : json['Address2'].toString(),
      documentStatus: json['DocumentStatus'] == null
          ? null
          : json['DocumentStatus'].toString(),
      periodIndicator: json['PeriodIndicator'] == null
          ? null
          : json['PeriodIndicator'].toString(),
      payToCode:
          json['PayToCode'] == null ? null : json['PayToCode'].toString(),
      manualNumber: json['ManualNumber'] == null ? null : json['ManualNumber'],
      useShpdGoodsAct: json['UseShpdGoodsAct'] == null
          ? null
          : json['UseShpdGoodsAct'].toString(),
      isPayToBank:
          json['IsPayToBank'] == null ? null : json['IsPayToBank'].toString(),
      payToBankCountry:
          json['PayToBankCountry'] == null ? null : json['PayToBankCountry'],
      payToBankCode:
          json['PayToBankCode'] == null ? null : json['PayToBankCode'],
      payToBankAccountNo: json['PayToBankAccountNo'] == null
          ? null
          : json['PayToBankAccountNo'],
      payToBankBranch:
          json['PayToBankBranch'] == null ? null : json['PayToBankBranch'],
      bplIdAssignedToInvoice: json['BPL_IDAssignedToInvoice'] == null
          ? null
          : json['BPL_IDAssignedToInvoice'],
      downPayment: json['DownPayment'] == null
          ? null
          : double.parse(json['DownPayment'].toString()),
      reserveInvoice: json['ReserveInvoice'] == null
          ? null
          : json['ReserveInvoice'].toString(),
      languageCode: json['LanguageCode'] == null
          ? null
          : int.parse(json['LanguageCode'].toString()),
      trackingNumber:
          json['TrackingNumber'] == null ? null : json['TrackingNumber'],
      pickRemark: json['PickRemark'] == null ? null : json['PickRemark'],
      closingDate: json['ClosingDate'] == null ? null : json['ClosingDate'],
      sequenceCode: json['SequenceCode'] == null ? null : json['SequenceCode'],
      sequenceSerial:
          json['SequenceSerial'] == null ? null : json['SequenceSerial'],
      seriesString: json['SeriesString'] == null ? null : json['SeriesString'],
      subSeriesString:
          json['SubSeriesString'] == null ? null : json['SubSeriesString'],
      sequenceModel: json['SequenceModel'] == null
          ? null
          : json['SequenceModel'].toString(),
      useCorrectionVatGroup: json['UseCorrectionVATGroup'] == null
          ? null
          : json['UseCorrectionVATGroup'].toString(),
      totalDiscount: json['TotalDiscount'] == null
          ? null
          : double.parse(json['TotalDiscount'].toString()),
      downPaymentAmount: json['DownPaymentAmount'] == null
          ? null
          : double.parse(json['DownPaymentAmount'].toString()),
      downPaymentPercentage: json['DownPaymentPercentage'] == null
          ? null
          : double.parse(json['DownPaymentPercentage'].toString()),
      downPaymentType: json['DownPaymentType'] == null
          ? null
          : json['DownPaymentType'].toString(),
      downPaymentAmountSc: json['DownPaymentAmountSC'] == null
          ? null
          : double.parse(json['DownPaymentAmountSC'].toString()),
      downPaymentAmountFc: json['DownPaymentAmountFC'] == null
          ? null
          : double.parse(json['DownPaymentAmountFC'].toString()),
      vatPercent: json['VatPercent'] == null
          ? null
          : double.parse(json['VatPercent'].toString()),
      serviceGrossProfitPercent: json['ServiceGrossProfitPercent'] == null
          ? null
          : json['ServiceGrossProfitPercent'],
      openingRemarks:
          json['OpeningRemarks'] == null ? null : json['OpeningRemarks'],
      closingRemarks:
          json['ClosingRemarks'] == null ? null : json['ClosingRemarks'],
      roundingDiffAmount: json['RoundingDiffAmount'] == null
          ? null
          : double.parse(json['RoundingDiffAmount'].toString()),
      roundingDiffAmountFc: json['RoundingDiffAmountFC'] == null
          ? null
          : double.parse(json['RoundingDiffAmountFC'].toString()),
      roundingDiffAmountSc: json['RoundingDiffAmountSC'] == null
          ? null
          : double.parse(json['RoundingDiffAmountSC'].toString()),
      cancelled:
          json['Cancelled'] == null ? null : json['Cancelled'].toString(),
      signatureInputMessage: json['SignatureInputMessage'] == null
          ? null
          : json['SignatureInputMessage'],
      signatureDigest:
          json['SignatureDigest'] == null ? null : json['SignatureDigest'],
      certificationNumber: json['CertificationNumber'] == null
          ? null
          : json['CertificationNumber'],
      privateKeyVersion:
          json['PrivateKeyVersion'] == null ? null : json['PrivateKeyVersion'],
      controlAccount: json['ControlAccount'] == null
          ? null
          : json['ControlAccount'].toString(),
      insuranceOperation347: json['InsuranceOperation347'] == null
          ? null
          : json['InsuranceOperation347'].toString(),
      archiveNonremovableSalesQuotation:
          json['ArchiveNonremovableSalesQuotation'] == null
              ? null
              : json['ArchiveNonremovableSalesQuotation'].toString(),
      gtsChecker: json['GTSChecker'] == null ? null : json['GTSChecker'],
      gtsPayee: json['GTSPayee'] == null ? null : json['GTSPayee'],
      extraMonth: json['ExtraMonth'] == null
          ? null
          : int.parse(json['ExtraMonth'].toString()),
      extraDays: json['ExtraDays'] == null
          ? null
          : int.parse(json['ExtraDays'].toString()),
      cashDiscountDateOffset: json['CashDiscountDateOffset'] == null
          ? null
          : int.parse(json['CashDiscountDateOffset'].toString()),
      startFrom:
          json['StartFrom'] == null ? null : json['StartFrom'].toString(),
      ntsApproved:
          json['NTSApproved'] == null ? null : json['NTSApproved'].toString(),
      eTaxWebSite: json['ETaxWebSite'] == null ? null : json['ETaxWebSite'],
      eTaxNumber: json['ETaxNumber'] == null ? null : json['ETaxNumber'],
      ntsApprovedNumber:
          json['NTSApprovedNumber'] == null ? null : json['NTSApprovedNumber'],
      eDocGenerationType: json['EDocGenerationType'] == null
          ? null
          : json['EDocGenerationType'].toString(),
      eDocSeries: json['EDocSeries'] == null ? null : json['EDocSeries'],
      eDocNum: json['EDocNum'] == null ? null : json['EDocNum'],
      eDocExportFormat:
          json['EDocExportFormat'] == null ? null : json['EDocExportFormat'],
      eDocStatus:
          json['EDocStatus'] == null ? null : json['EDocStatus'].toString(),
      eDocErrorCode:
          json['EDocErrorCode'] == null ? null : json['EDocErrorCode'],
      eDocErrorMessage:
          json['EDocErrorMessage'] == null ? null : json['EDocErrorMessage'],
      downPaymentStatus: json['DownPaymentStatus'] == null
          ? null
          : json['DownPaymentStatus'].toString(),
      groupSeries: json['GroupSeries'] == null ? null : json['GroupSeries'],
      groupNumber: json['GroupNumber'] == null ? null : json['GroupNumber'],
      groupHandWritten: json['GroupHandWritten'] == null
          ? null
          : json['GroupHandWritten'].toString(),
      reopenOriginalDocument: json['ReopenOriginalDocument'] == null
          ? null
          : json['ReopenOriginalDocument'],
      reopenManuallyClosedOrCanceledDocument:
          json['ReopenManuallyClosedOrCanceledDocument'] == null
              ? null
              : json['ReopenManuallyClosedOrCanceledDocument'],
      createOnlineQuotation: json['CreateOnlineQuotation'] == null
          ? null
          : json['CreateOnlineQuotation'].toString(),
      posEquipmentNumber: json['POSEquipmentNumber'] == null
          ? null
          : json['POSEquipmentNumber'],
      posManufacturerSerialNumber: json['POSManufacturerSerialNumber'] == null
          ? null
          : json['POSManufacturerSerialNumber'],
      posCashierNumber:
          json['POSCashierNumber'] == null ? null : json['POSCashierNumber'],
      applyCurrentVatRatesForDownPaymentsToDraw:
          json['ApplyCurrentVATRatesForDownPaymentsToDraw'] == null
              ? null
              : json['ApplyCurrentVATRatesForDownPaymentsToDraw'].toString(),
      closingOption: json['ClosingOption'] == null
          ? null
          : json['ClosingOption'].toString(),
      specifiedClosingDate: json['SpecifiedClosingDate'] == null
          ? null
          : json['SpecifiedClosingDate'],
      openForLandedCosts: json['OpenForLandedCosts'] == null
          ? null
          : json['OpenForLandedCosts'].toString(),
      authorizationStatus: json['AuthorizationStatus'] == null
          ? null
          : json['AuthorizationStatus'].toString(),
      totalDiscountFc: json['TotalDiscountFC'] == null
          ? null
          : double.parse(json['TotalDiscountFC'].toString()),
      totalDiscountSc: json['TotalDiscountSC'] == null
          ? null
          : double.parse(json['TotalDiscountSC'].toString()),
      relevantToGts: json['RelevantToGTS'] == null
          ? null
          : json['RelevantToGTS'].toString(),
      bplName: json['BPLName'] == null ? null : json['BPLName'],
      vatRegNum: json['VATRegNum'] == null ? null : json['VATRegNum'],
      annualInvoiceDeclarationReference:
          json['AnnualInvoiceDeclarationReference'] == null
              ? null
              : json['AnnualInvoiceDeclarationReference'],
      supplier: json['Supplier'] == null ? null : json['Supplier'],
      releaser: json['Releaser'] == null ? null : json['Releaser'],
      receiver: json['Receiver'] == null ? null : json['Receiver'],
      blanketAgreementNumber: json['BlanketAgreementNumber'] == null
          ? null
          : json['BlanketAgreementNumber'],
      isAlteration:
          json['IsAlteration'] == null ? null : json['IsAlteration'].toString(),
      cancelStatus:
          json['CancelStatus'] == null ? null : json['CancelStatus'].toString(),
      assetValueDate: json['AssetValueDate'] == null
          ? null
          : json['AssetValueDate'].toString(),
      documentDelivery: json['DocumentDelivery'] == null
          ? null
          : json['DocumentDelivery'].toString(),
      authorizationCode:
          json['AuthorizationCode'] == null ? null : json['AuthorizationCode'],
      startDeliveryDate:
          json['StartDeliveryDate'] == null ? null : json['StartDeliveryDate'],
      startDeliveryTime:
          json['StartDeliveryTime'] == null ? null : json['StartDeliveryTime'],
      endDeliveryDate:
          json['EndDeliveryDate'] == null ? null : json['EndDeliveryDate'],
      endDeliveryTime:
          json['EndDeliveryTime'] == null ? null : json['EndDeliveryTime'],
      vehiclePlate: json['VehiclePlate'] == null ? null : json['VehiclePlate'],
      atDocumentType:
          json['ATDocumentType'] == null ? null : json['ATDocumentType'],
      elecCommStatus:
          json['ElecCommStatus'] == null ? null : json['ElecCommStatus'],
      elecCommMessage:
          json['ElecCommMessage'] == null ? null : json['ElecCommMessage'],
      reuseDocumentNum: json['ReuseDocumentNum'] == null
          ? null
          : json['ReuseDocumentNum'].toString(),
      reuseNotaFiscalNum: json['ReuseNotaFiscalNum'] == null
          ? null
          : json['ReuseNotaFiscalNum'].toString(),
      printSepaDirect: json['PrintSEPADirect'] == null
          ? null
          : json['PrintSEPADirect'].toString(),
      fiscalDocNum: json['FiscalDocNum'] == null ? null : json['FiscalDocNum'],
      posDailySummaryNo:
          json['POSDailySummaryNo'] == null ? null : json['POSDailySummaryNo'],
      posReceiptNo: json['POSReceiptNo'] == null ? null : json['POSReceiptNo'],
      pointOfIssueCode:
          json['PointOfIssueCode'] == null ? null : json['PointOfIssueCode'],
      letter: json['Letter'] == null ? null : json['Letter'],
      folioNumberFrom:
          json['FolioNumberFrom'] == null ? null : json['FolioNumberFrom'],
      folioNumberTo:
          json['FolioNumberTo'] == null ? null : json['FolioNumberTo'],
      interimType:
          json['InterimType'] == null ? null : json['InterimType'].toString(),
      relatedType: json['RelatedType'] == null
          ? null
          : int.parse(json['RelatedType'].toString()),
      relatedEntry: json['RelatedEntry'] == null ? null : json['RelatedEntry'],
      sapPassport: json['SAPPassport'] == null ? null : json['SAPPassport'],
      documentTaxId:
          json['DocumentTaxID'] == null ? null : json['DocumentTaxID'],
      dateOfReportingControlStatementVat:
          json['DateOfReportingControlStatementVAT'] == null
              ? null
              : json['DateOfReportingControlStatementVAT'],
      reportingSectionControlStatementVat:
          json['ReportingSectionControlStatementVAT'] == null
              ? null
              : json['ReportingSectionControlStatementVAT'],
      excludeFromTaxReportControlStatementVat:
          json['ExcludeFromTaxReportControlStatementVAT'] == null
              ? null
              : json['ExcludeFromTaxReportControlStatementVAT'].toString(),
      posCashRegister:
          json['POS_CashRegister'] == null ? null : json['POS_CashRegister'],
      updateTime:
          json['UpdateTime'] == null ? null : json['UpdateTime'].toString(),
      createQrCodeFrom:
          json['CreateQRCodeFrom'] == null ? null : json['CreateQRCodeFrom'],
      priceMode: json['PriceMode'] == null ? null : json['PriceMode'],
      shipFrom: json['ShipFrom'] == null ? null : json['ShipFrom'].toString(),
      commissionTrade: json['CommissionTrade'] == null
          ? null
          : json['CommissionTrade'].toString(),
      commissionTradeReturn: json['CommissionTradeReturn'] == null
          ? null
          : json['CommissionTradeReturn'].toString(),
      useBillToAddrToDetermineTax: json['UseBillToAddrToDetermineTax'] == null
          ? null
          : json['UseBillToAddrToDetermineTax'].toString(),
      cig: json['Cig'] == null ? null : json['Cig'],
      cup: json['Cup'] == null ? null : json['Cup'],
      fatherCard: json['FatherCard'] == null ? null : json['FatherCard'],
      fatherType:
          json['FatherType'] == null ? null : json['FatherType'].toString(),
      shipState: json['ShipState'] == null ? null : json['ShipState'],
      shipPlace: json['ShipPlace'] == null ? null : json['ShipPlace'],
      custOffice: json['CustOffice'] == null ? null : json['CustOffice'],
      fci: json['FCI'] == null ? null : json['FCI'],
      addLegIn: json['AddLegIn'] == null ? null : json['AddLegIn'],
      legTextF: json['LegTextF'] == null ? null : json['LegTextF'],
      danfeLgTxt: json['DANFELgTxt'] == null ? null : json['DANFELgTxt'],
      indFinal: json['IndFinal'] == null ? null : json['IndFinal'].toString(),
      dataVersion: json['DataVersion'] == null
          ? null
          : int.parse(json['DataVersion'].toString()),
      uPurchaseType: json['U_Purchase_Type'] == null
          ? null
          : json['U_Purchase_Type'].toString(),
      uApApprove:
          json['U_AP_Approve'] == null ? null : json['U_AP_Approve'].toString(),
      uFinalDel:
          json['U_Final_Del'] == null ? null : json['U_Final_Del'].toString(),
      uIncoTerms: json['U_Inco_Terms'] == null ? null : json['U_Inco_Terms'],
      uSourceDest: json['U_Source_Dest'] == null ? null : json['U_Source_Dest'],
      uTransNo: json['U_Trans_NO'] == null ? null : json['U_Trans_NO'],
      uVehicleNo: json['U_Vehicle_NO'] == null ? null : json['U_Vehicle_NO'],
      uSupplierDt: json['U_Supplier_DT'] == null ? null : json['U_Supplier_DT'],
      uQuotNo: json['U_QuotNo'] == null ? null : json['U_QuotNo'],
      uQuotDate: json['U_QuotDate'] == null ? null : json['U_QuotDate'],
      uGovPermit:
          json['U_GovPermit'] == null ? null : json['U_GovPermit'].toString(),
      uGovPermitdt:
          json['U_GovPermitdt'] == null ? null : json['U_GovPermitdt'],
      uCheckNo: json['U_CheckNo'] == null ? null : json['U_CheckNo'],
      uCheckDate: json['U_CheckDate'] == null ? null : json['U_CheckDate'],
      uApprovalDate: json['U_ApprovalDate'] == null
          ? null
          : json['U_ApprovalDate'].toString(),
      uOrderNoRecd: json['U_OrderNoRecd'] == null
          ? null
          : json['U_OrderNoRecd'].toString(),
      uOrderDate:
          json['U_OrderDate'] == null ? null : json['U_OrderDate'].toString(),
      uClearingAgent:
          json['U_ClearingAgent'] == null ? null : json['U_ClearingAgent'],
      uDateSubAgent:
          json['U_DateSubAgent'] == null ? null : json['U_DateSubAgent'],
      uIdfno: json['U_IDFNO'] == null ? null : json['U_IDFNO'],
      uIdfDate: json['U_IDFDate'] == null ? null : json['U_IDFDate'],
      uInspectionNo:
          json['U_InspectionNo'] == null ? null : json['U_InspectionNo'],
      uEta: json['U_ETA'] == null ? null : json['U_ETA'],
      uAirwayBillNo:
          json['U_AirwayBillNo'] == null ? null : json['U_AirwayBillNo'],
      uBol: json['U_BOL'] == null ? null : json['U_BOL'],
      uCotecna: json['U_Cotecna'] == null ? null : json['U_Cotecna'],
      uArrivalDate:
          json['U_ArrivalDate'] == null ? null : json['U_ArrivalDate'],
      uDahacoAgentFees: json['U_DahacoAgentFees'] == null
          ? null
          : double.parse(json['U_DahacoAgentFees'].toString()),
      uPortCharges: json['U_PortCharges'] == null
          ? null
          : double.parse(json['U_PortCharges'].toString()),
      uOtherExp: json['U_OtherExp'] == null
          ? null
          : double.parse(json['U_OtherExp'].toString()),
      uClearCharges: json['U_ClearCharges'] == null
          ? null
          : double.parse(json['U_ClearCharges'].toString()),
      uHiddenChrges: json['U_HiddenChrges'] == null
          ? null
          : double.parse(json['U_HiddenChrges'].toString()),
      uGoodsInspBy:
          json['U_GoodsInspBy'] == null ? null : json['U_GoodsInspBy'],
      uGoodsReport:
          json['U_GoodsReport'] == null ? null : json['U_GoodsReport'],
      uPymtStatus: json['U_PymtStatus'] == null ? null : json['U_PymtStatus'],
      uPymtType: json['U_PymtType'] == null ? null : json['U_PymtType'],
      uTtCopyImage:
          json['U_TTCopyImage'] == null ? null : json['U_TTCopyImage'],
      uPfiImage: json['U_PFI_Image'] == null ? null : json['U_PFI_Image'],
      uSupplierImage:
          json['U_Supplier_Image'] == null ? null : json['U_Supplier_Image'],
      uBolImage: json['U_BOL_Image'] == null ? null : json['U_BOL_Image'],
        uGpApproval: json['U_GP_Approval'] == null
          ? null
          : json['U_GP_Approval'].toString(),
      uTruckInternal: json['U_Truck_Internal'] == null
          ? null
          : json['U_Truck_Internal'].toString(),
    
      uOrderType:
          json['U_Order_Type'] == null ? null : json['U_Order_Type'].toString(),
      uSupplierName:
          json['U_SUPPLIER_NAME'] == null ? null : json['U_SUPPLIER_NAME'],
      uVatNumber: json['U_VAT_NUMBER'] == null ? null : json['U_VAT_NUMBER'],
      uTransferType: json['U_Transfer_Type'] == null
          ? null
          : json['U_Transfer_Type'].toString(),
      uSalesOrder: json['U_Sales_Order'] == null ? null : json['U_Sales_Order'],
      uReceived:
          json['U_Received'] == null ? null : json['U_Received'].toString(),
      uDriverName: json['U_Driver_Name'] == null ? null : json['U_Driver_Name'],
      uReserveInvoice:
          json['U_Reserve_Invoice'] == null ? null : json['U_Reserve_Invoice'],
      uRefSeries: json['U_Ref_Series'] == null ? null : json['U_Ref_Series'],
      uReceivedTime: json['U_Received_Time'] == null
          ? null
          : json['U_Received_Time'].toString(),
      uSkuBatchNo:
          json['U_SKU_Batch_No'] == null ? null : json['U_SKU_Batch_No'],
      uInwardNo: json['U_Inward_No'] == null ? null : json['U_Inward_No'],
      uDispatchTime:
          json['U_Dispatch_Time'] == null ? null : json['U_Dispatch_Time'],
      uReceivedDate:
          json['U_Received_Date'] == null ? null : json['U_Received_Date'],
      uExpiryDate: json['U_Expiry_Date'] == null ? null : json['U_Expiry_Date'],
      uCnType: json['U_CN_Type'] == null ? null : json['U_CN_Type'].toString(),
      uTinNo: json['U_TinNO'] == null ? null : json['U_TinNO'],
      uLpoNo: json['U_LPONo'] == null ? null : json['U_LPONo'],
      uOrderQty: json['U_OrderQty'] == null
          ? null
          : double.parse(json['U_OrderQty'].toString()),
      uDispatchDate:
          json['U_Dispatch_Date'] == null ? null : json['U_Dispatch_Date'],
      uBranch: json['U_Branch'] == null ? null : json['U_Branch'],
      uSalAppEntry:
          json['U_SalAppEntry'] == null ? null : json['U_SalAppEntry'],
      uDocType: json['U_DocType'] == null
          ? null
          : int.parse(json['U_DocType'].toString()),
      uIntKey: json['U_IntKey'] == null ? null : json['U_IntKey'],
      uQrFileLoc: json['U_QRFileLoc'] == null ? null : json['U_QRFileLoc'],
      uRctCde: json['U_rctCde'] == null ? null : json['U_rctCde'],
      uZno: json['U_Zno'] == null ? null : json['U_Zno'],
      uVfdIn: json['U_VfdIn'] == null ? null : json['U_VfdIn'],
      uQrPath: json['U_QRPath'] == null ? null : json['U_QRPath'],
      uQrValue: json['U_QRValue'] == null ? null : json['U_QRValue'],
      uIdate: json['U_idate'] == null ? null : json['U_idate'],
      uItime: json['U_itime'] == null ? null : json['U_itime'],
      uDeviceCode: json['U_DeviceCode'] == null ? null : json['U_DeviceCode'],
      uDeviceTransId:
          json['U_DeviceTransID'] == null ? null : json['U_DeviceTransID'],
      uRvc: json['U_RVC'] == null ? null : json['U_RVC'],
      uVrn: json['U_VRN'] == null ? null : json['U_VRN'],
      uLongitude: json['U_longitude'] == null ? null : json['U_longitude'],
      uLatitude: json['U_latitude'] == null ? null : json['U_latitude'],
      uAuditJobGroup:
          json['U_AUDIT_JOB_GROUP'] == null ? null : json['U_AUDIT_JOB_GROUP'],
      uAuditName: json['U_AUDIT_NAME'] == null ? null : json['U_AUDIT_NAME'],
      uRequest: json['U_Request'] == null ? null : json['U_Request'],
      uPosDocNo: json['U_PosDocNo'] == null ? null : json['U_PosDocNo'],
      taxExtension: json['TaxExtension'] != null
          ? TaxExtension.fromJson(json['TaxExtension'])
          : null,
      addressExtension: json['AddressExtension'] != null
          ? AddressExtension.fromJson(json['AddressExtension'])
          : null,
    );
  }

  factory ApprovalDetailsValue.issue(String e) {
    return ApprovalDetailsValue(
      error: e,
    );
  }
  Map<String, dynamic> toJson() => {
        'odata.metadata': odataMetadata.toString(),
        'odata.etag': odataEtag,
        'DocEntry': docEntry,
        'DocNum': docNum,
        'DocType': docType,
        'HandWritten': handWritten,
        'Printed': printed,
        'DocDate': docDate,
        'DocDueDate': docDueDate,
        'CardCode': cardCode,
        'CardName': cardName,
        'Address': address,
        'NumAtCard': numAtCard,
        'DocTotal': docTotal,
        'AttachmentEntry': attachmentEntry,
        'DocCurrency': docCurrency,
        'DocRate': docRate,
        'Reference1': reference1,
        'Reference2': reference2,
        'Comments': comments,
        'JournalMemo': journalMemo,
        'PaymentGroupCode': paymentGroupCode,
        'DocTime': docTime,
        'SalesPersonCode': salesPersonCode,
        'TransportationCode': transportationCode,
        'Confirmed': confirmed,
        'ImportFileNum': importFileNum,
        'SummeryType': summeryType,
        'ContactPersonCode': contactPersonCode,
        'ShowSCN': showScn,
        'Series': series,
        'TaxDate': taxDate,
        'PartialSupply': partialSupply,
        'DocObjectCode': docObjectCode,
        'ShipToCode': shipToCode,
        'Indicator': indicator,
        'FederalTaxID': federalTaxId,
        'DiscountPercent': discountPercent,
        'PaymentReference': paymentReference,
        'CreationDate': "${creationDate}",
        'UpdateDate': "${updateDate}",
        'FinancialPeriod': financialPeriod,
        'UserSign': userSign,
        'TransNum': transNum,
        'VatSum': vatSum,
        'VatSumSys': vatSumSys,
        'VatSumFc': vatSumFc,
        'NetProcedure': netProcedure,
        'DocTotalFc': docTotalFc,
        'DocTotalSys': docTotalSys,
        'Form1099': form1099,
        'Box1099': box1099,
        'RevisionPo': revisionPo,
        'RequriedDate': requriedDate,
        'CancelDate': cancelDate,
        'BlockDunning': blockDunning,
        'Submitted': submitted,
        'Segment': segment,
        'PickStatus': pickStatus,
        'Pick': pick,
        'PaymentMethod': paymentMethod,
        'PaymentBlock': paymentBlock,
        'PaymentBlockEntry': paymentBlockEntry,
        'CentralBankIndicator': centralBankIndicator,
        'MaximumCashDiscount': maximumCashDiscount,
        'Reserve': reserve,
        'Project': project,
        'ExemptionValidityDateFrom': exemptionValidityDateFrom,
        'ExemptionValidityDateTo': exemptionValidityDateTo,
        'WareHouseUpdateType': wareHouseUpdateType,
        'Rounding': rounding,
        'ExternalCorrectedDocNum': externalCorrectedDocNum,
        'InternalCorrectedDocNum': internalCorrectedDocNum,
        'NextCorrectingDocument': nextCorrectingDocument,
        'DeferredTax': deferredTax,
        'TaxExemptionLetterNum': taxExemptionLetterNum,
        'WTApplied': wtApplied,
        'WTAppliedFC': wtAppliedFc,
        'BillOfExchangeReserved': billOfExchangeReserved,
        'AgentCode': agentCode,
        'WTAppliedSC': wtAppliedSc,
        'TotalEqualizationTax': totalEqualizationTax,
        'TotalEqualizationTaxFC': totalEqualizationTaxFc,
        'TotalEqualizationTaxSC': totalEqualizationTaxSc,
        'NumberOfInstallments': numberOfInstallments,
        'ApplyTaxOnFirstInstallment': applyTaxOnFirstInstallment,
        'WTNonSubjectAmount': wtNonSubjectAmount,
        'WTNonSubjectAmountSC': wtNonSubjectAmountSc,
        'WTNonSubjectAmountFC': wtNonSubjectAmountFc,
        'WTExemptedAmount': wtExemptedAmount,
        'WTExemptedAmountSC': wtExemptedAmountSc,
        'WTExemptedAmountFC': wtExemptedAmountFc,
        'BaseAmount': baseAmount,
        'BaseAmountSC': baseAmountSc,
        'BaseAmountFC': baseAmountFc,
        'WTAmount': wtAmount,
        'WTAmountSC': wtAmountSc,
        'WTAmountFC': wtAmountFc,
        'VatDate': vatDate,
        'DocumentsOwner': documentsOwner,
        'FolioPrefixString': folioPrefixString,
        'FolioNumber': folioNumber,
        'DocumentSubType': documentSubType,
        'BPChannelCode': bpChannelCode,
        'BPChannelContact': bpChannelContact,
        'Address2': address2,
        'DocumentStatus': documentStatus,
        'PeriodIndicator': periodIndicator,
        'PayToCode': payToCode,
        'ManualNumber': manualNumber,
        'UseShpdGoodsAct': useShpdGoodsAct,
        'IsPayToBank': isPayToBank,
        'PayToBankCountry': payToBankCountry,
        'PayToBankCode': payToBankCode,
        'PayToBankAccountNo': payToBankAccountNo,
        'PayToBankBranch': payToBankBranch,
        'BPL_IDAssignedToInvoice': bplIdAssignedToInvoice,
        'DownPayment': downPayment,
        'ReserveInvoice': reserveInvoice,
        'LanguageCode': languageCode,
        'TrackingNumber': trackingNumber,
        'PickRemark': pickRemark,
        'ClosingDate': closingDate,
        'SequenceCode': sequenceCode,
        'SequenceSerial': sequenceSerial,
        'SeriesString': seriesString,
        'SubSeriesString': subSeriesString,
        'SequenceModel': sequenceModel,
        'UseCorrectionVATGroup': useCorrectionVatGroup,
        'TotalDiscount': totalDiscount,
        'DownPaymentAmount': downPaymentAmount,
        'DownPaymentPercentage': downPaymentPercentage,
        'DownPaymentType': downPaymentType,
        'DownPaymentAmountSC': downPaymentAmountSc,
        'DownPaymentAmountFC': downPaymentAmountFc,
        'VatPercent': vatPercent,
        'ServiceGrossProfitPercent': serviceGrossProfitPercent,
        'OpeningRemarks': openingRemarks,
        'ClosingRemarks': closingRemarks,
        'RoundingDiffAmount': roundingDiffAmount,
        'RoundingDiffAmountFC': roundingDiffAmountFc,
        'RoundingDiffAmountSC': roundingDiffAmountSc,
        'Cancelled': cancelled,
        'SignatureInputMessage': signatureInputMessage,
        'SignatureDigest': signatureDigest,
        'CertificationNumber': certificationNumber,
        'PrivateKeyVersion': privateKeyVersion,
        'ControlAccount': controlAccount,
        'InsuranceOperation347': insuranceOperation347,
        'ArchiveNonremovableSalesQuotation': archiveNonremovableSalesQuotation,
        'GTSChecker': gtsChecker,
        'GTSPayee': gtsPayee,
        'ExtraMonth': extraMonth,
        'ExtraDays': extraDays,
        'CashDiscountDateOffset': cashDiscountDateOffset,
        'StartFrom': startFrom,
        'NTSApproved': ntsApproved,
        'ETaxWebSite': eTaxWebSite,
        'ETaxNumber': eTaxNumber,
        'NTSApprovedNumber': ntsApprovedNumber,
        'EDocGenerationType': eDocGenerationType,
        'EDocSeries': eDocSeries,
        'EDocNum': eDocNum,
        'EDocExportFormat': eDocExportFormat,
        'EDocStatus': eDocStatus,
        'EDocErrorCode': eDocErrorCode,
        'EDocErrorMessage': eDocErrorMessage,
        'DownPaymentStatus': downPaymentStatus,
        'GroupSeries': groupSeries,
        'GroupNumber': groupNumber,
        'GroupHandWritten': groupHandWritten,
        'ReopenOriginalDocument': reopenOriginalDocument,
        'ReopenManuallyClosedOrCanceledDocument':
            reopenManuallyClosedOrCanceledDocument,
        'CreateOnlineQuotation': createOnlineQuotation,
        'POSEquipmentNumber': posEquipmentNumber,
        'POSManufacturerSerialNumber': posManufacturerSerialNumber,
        'POSCashierNumber': posCashierNumber,
        'ApplyCurrentVATRatesForDownPaymentsToDraw':
            applyCurrentVatRatesForDownPaymentsToDraw,
        'ClosingOption': closingOption,
        'SpecifiedClosingDate': specifiedClosingDate,
        'OpenForLandedCosts': openForLandedCosts,
        'AuthorizationStatus': authorizationStatus,
        'TotalDiscountFC': totalDiscountFc,
        'TotalDiscountSC': totalDiscountSc,
        'RelevantToGTS': relevantToGts,
        'BPLName': bplName,
        'VATRegNum': vatRegNum,
        'AnnualInvoiceDeclarationReference': annualInvoiceDeclarationReference,
        'Supplier': supplier,
        'Releaser': releaser,
        'Receiver': receiver,
        'BlanketAgreementNumber': blanketAgreementNumber,
        'IsAlteration': isAlteration,
        'CancelStatus': cancelStatus,
        'AssetValueDate': assetValueDate,
        'DocumentDelivery': documentDelivery,
        'AuthorizationCode': authorizationCode,
        'StartDeliveryDate': startDeliveryDate,
        'StartDeliveryTime': startDeliveryTime,
        'EndDeliveryDate': endDeliveryDate,
        'EndDeliveryTime': endDeliveryTime,
        'VehiclePlate': vehiclePlate,
        'ATDocumentType': atDocumentType,
        'ElecCommStatus': elecCommStatus,
        'ElecCommMessage': elecCommMessage,
        'ReuseDocumentNum': reuseDocumentNum,
        'ReuseNotaFiscalNum': reuseNotaFiscalNum,
        'PrintSEPADirect': printSepaDirect,
        'FiscalDocNum': fiscalDocNum,
        'POSDailySummaryNo': posDailySummaryNo,
        'POSReceiptNo': posReceiptNo,
        'PointOfIssueCode': pointOfIssueCode,
        'Letter': letter,
        'FolioNumberFrom': folioNumberFrom,
        'FolioNumberTo': folioNumberTo,
        'InterimType': interimType,
        'RelatedType': relatedType,
        'RelatedEntry': relatedEntry,
        'SAPPassport': sapPassport,
        'DocumentTaxID': documentTaxId,
        'DateOfReportingControlStatementVAT':
            dateOfReportingControlStatementVat,
        'ReportingSectionControlStatementVAT':
            reportingSectionControlStatementVat,
        'ExcludeFromTaxReportControlStatementVAT':
            excludeFromTaxReportControlStatementVat,
        'POS_CashRegister': posCashRegister,
        'UpdateTime': updateTime,
        'CreateQRCodeFrom': createQrCodeFrom,
        'PriceMode': priceMode,
        'ShipFrom': shipFrom,
        'CommissionTrade': commissionTrade,
        'CommissionTradeReturn': commissionTradeReturn,
        'UseBillToAddrToDetermineTax': useBillToAddrToDetermineTax,
        'Cig': cig,
        'Cup': cup,
        'FatherCard': fatherCard,
        'FatherType': fatherType,
        'ShipState': shipState,
        'ShipPlace': shipPlace,
        'CustOffice': custOffice,
        'FCI': fci,
        'AddLegIn': addLegIn,
        'LegTextF': legTextF,
        'DANFELgTxt': danfeLgTxt,
        'IndFinal': indFinal,
        'DataVersion': dataVersion,
        'U_Purchase_Type': uPurchaseType,
        'U_AP_Approve': uApApprove,
        'U_Final_Del': uFinalDel,
        'U_Inco_Terms': uIncoTerms,
        'U_Source_Dest': uSourceDest,
        'U_Trans_NO': uTransNo,
        'U_Vehicle_NO': uVehicleNo,
        'U_Supplier_DT': uSupplierDt,
        'U_QuotNo': uQuotNo,
        'U_QuotDate': uQuotDate,
        'U_GovPermit': uGovPermit,
        'U_GovPermitdt': uGovPermitdt,
        'U_CheckNo': uCheckNo,
        'U_CheckDate': uCheckDate,
        'U_ApprovalDate': uApprovalDate,
        'U_OrderNoRecd': uOrderNoRecd,
        'U_OrderDate': uOrderDate,
        'U_ClearingAgent': uClearingAgent,
        'U_DateSubAgent': uDateSubAgent,
        'U_IDFNO': uIdfno,
        'U_IDFDate': uIdfDate,
        'U_InspectionNo': uInspectionNo,
        'U_ETA': uEta,
        'U_AirwayBillNo': uAirwayBillNo,
        'U_BOL': uBol,
        'U_Cotecna': uCotecna,
        'U_ArrivalDate': uArrivalDate,
        'U_DahacoAgentFees': uDahacoAgentFees,
        'U_PortCharges': uPortCharges,
        'U_OtherExp': uOtherExp,
        'U_ClearCharges': uClearCharges,
        'U_HiddenChrges': uHiddenChrges,
        'U_GoodsInspBy': uGoodsInspBy,
        'U_GoodsReport': uGoodsReport,
        'U_PymtStatus': uPymtStatus,
        'U_PymtType': uPymtType,
        'U_TTCopyImage': uTtCopyImage,
        'U_PFI_Image': uPfiImage,
        'U_Supplier_Image': uSupplierImage,
        'U_BOL_Image': uBolImage,
        'U_Order_Type': uOrderType,
        'U_Truck_Internal': uTruckInternal,
        'U_GP_Approval': uGpApproval,
        'U_SUPPLIER_NAME': uSupplierName,
        'U_VAT_NUMBER': uVatNumber,
        'U_Transfer_Type': uTransferType,
        'U_Sales_Order': uSalesOrder,
        'U_Received': uReceived,
        'U_Driver_Name': uDriverName,
        'U_Reserve_Invoice': uReserveInvoice,
        'U_Ref_Series': uRefSeries,
        'U_Received_Time': uReceivedTime,
        'U_SKU_Batch_No': uSkuBatchNo,
        'U_Inward_No': uInwardNo,
        'U_Dispatch_Time': uDispatchTime,
        'U_Received_Date': uReceivedDate,
        'U_Expiry_Date': uExpiryDate,
        'U_CN_Type': uCnType,
        'U_TinNO': uTinNo,
        'U_LPONo': uLpoNo,
        'U_OrderQty': uOrderQty,
        'U_Dispatch_Date': uDispatchDate,
        'U_Branch': uBranch,
        'U_SalAppEntry': uSalAppEntry,
        'U_DocType': uDocType,
        'U_IntKey': uIntKey,
        'U_QRFileLoc': uQrFileLoc,
        'U_rctCde': uRctCde,
        'U_Zno': uZno,
        'U_VfdIn': uVfdIn,
        'U_QRPath': uQrPath,
        'U_QRValue': uQrValue,
        'U_idate': uIdate,
        'U_itime': uItime,
        'U_DeviceCode': uDeviceCode,
        'U_DeviceTransID': uDeviceTransId,
        'U_RVC': uRvc,
        'U_VRN': uVrn,
        'U_longitude': uLongitude,
        'U_latitude': uLatitude,
        'U_AUDIT_JOB_GROUP': uAuditJobGroup,
        'U_AUDIT_NAME': uAuditName,
        'U_Request': uRequest,
        'U_PosDocNo': uPosDocNo,
        // 'Document_ApprovalRequests': List<dynamic>.from(documentApprovalRequests.map((x) => x)),
        'DocumentLines':
            List<dynamic>.from(documentLines!.map((x) => x.toJson())),

        // 'ElectronicProtocols': List<dynamic>.from(electronicProtocols.map((x) => x)),
        // 'DocumentAdditionalExpenses': List<dynamic>.from(documentAdditionalExpenses.map((x) => x)),
        // 'DocumentSpecialLines': List<dynamic>.from(documentSpecialLines.map((x) => x)),
        'TaxExtension': taxExtension!,
        'AddressExtension': addressExtension!,
        'DocumentReferences':
            List<dynamic>.from(documentReferences!.map((x) => x)),
      };
}

class DocumentApprovalValue {
  int? lineNum;
  String? itemCode;
  String? itemDescription;
  double? quantity;
  dynamic shipDate;
  double? price;
  double? total;
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
  String? taxCode;
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
  double? requiredQuantity;
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

  double? U_Pack_Size;
  // double U_Tins_Per_Box;
  // List<dynamic> lineTaxJurisdictions;
  // List<dynamic> documentLineAdditionalExpenses;

  DocumentApprovalValue({
    required this.U_Pack_Size,
    // required this.U_Tins_Per_Box,

    this.lineNum,
    this.itemCode,
    this.itemDescription,
    this.quantity,
    this.shipDate,
    this.price,
    this.total,
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
    this.requiredQuantity,
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
    //   this.lineTaxJurisdictions,
    //   this.documentLineAdditionalExpenses,
  });

  factory DocumentApprovalValue.fromJson(dynamic json) => DocumentApprovalValue(
     
      lineNum: json['LineNum'] == null
          ? null
          : int.parse(json['LineNum'].toString()),
      itemCode: json['ItemCode'] == null ? null : json['ItemCode'].toString(),
      itemDescription: json['ItemDescription'] == null
          ? null
          : json['ItemDescription'].toString(),
      quantity: json['Quantity'] == null
          ? null
          : double.parse(json['Quantity'].toString()),
      shipDate: json['ShipDate'] == null ? null : json['ShipDate'],
      price:
          json['Price'] == null ? null : double.parse(json['Price'].toString()),
      total: json['PriceAfterVAT'] == null
          ? null
          : double.parse(json['PriceAfterVAT'].toString()),
      currency: json['Currency'] == null ? null : json['Currency'].toString(),
      rate: json['Rate'] == null ? null : double.parse(json['Rate'].toString()),
      discountPercent: json['DiscountPercent'] == null
          ? null
          : double.parse(json['DiscountPercent'].toString()),
      vendorNum:
          json['VendorNum'] == null ? null : json['VendorNum'].toString(),
      serialNum:
          json['SerialNum'] == null ? null : json['SerialNum'].toString(),
      warehouseCode: json['WarehouseCode'] == null
          ? null
          : json['WarehouseCode'].toString(),
      salesPersonCode: json['SalesPersonCode'] == null
          ? null
          : int.parse(json['SalesPersonCode'].toString()),
      commisionPercent: json['CommisionPercent'] == null
          ? null
          : double.parse(json['CommisionPercent'].toString()),
      treeType: json['TreeType'] == null ? null : json['TreeType'].toString(),
      accountCode:
          json['AccountCode'] == null ? null : json['AccountCode'].toString(),
      useBaseUnits:
          json['UseBaseUnits'] == null ? null : json['UseBaseUnits'].toString(),
      supplierCatNum: json['SupplierCatNum'] == null
          ? null
          : json['SupplierCatNum'].toString(),
      costingCode:
          json['CostingCode'] == null ? null : json['CostingCode'].toString(),
      projectCode:
          json['ProjectCode'] == null ? null : json['ProjectCode'].toString(),
      barCode: json['BarCode'] == null ? null : json['BarCode'].toString(),
      vatGroup: json['VatGroup'] == null ? null : json['VatGroup'].toString(),
      height1: json['Height1'] == null
          ? null
          : double.parse(json['Height1'].toString()),
      hight1Unit:
          json['Hight1Unit'] == null ? null : json['Hight1Unit'].toString(),
      height2: json['Height2'] == null
          ? null
          : double.parse(json['Height2'].toString()),
      height2Unit:
          json['Height2Unit'] == null ? null : json['Height2Unit'].toString(),
      lengh1: json['Lengh1'] == null
          ? null
          : double.parse(json['Lengh1'].toString()),
      lengh1Unit:
          json['Lengh1Unit'] == null ? null : json['Lengh1Unit'].toString(),
      lengh2: json['Lengh2'] == null
          ? null
          : double.parse(json['Lengh2'].toString()),
      lengh2Unit:
          json['Lengh2Unit'] == null ? null : json['Lengh2Unit'].toString(),
      weight1: json['Weight1'] == null
          ? null
          : double.parse(json['Weight1'].toString()),
      weight1Unit: json['Weight1Unit'] == null ? null : json['Weight1Unit'],
      weight2: json['Weight2'] == null
          ? null
          : double.parse(json['Weight2'].toString()),
      weight2Unit: json['Weight2Unit'] == null ? null : json['Weight2Unit'],
      factor1: json['Factor1'] == null
          ? null
          : double.parse(json['Factor1'].toString()),
      factor2: json['Factor2'] == null
          ? null
          : double.parse(json['Factor2'].toString()),
      factor3: json['Factor3'] == null
          ? null
          : double.parse(json['Factor3'].toString()),
      factor4: json['Factor4'] == null
          ? null
          : double.parse(json['Factor4'].toString()),
      baseType: json['BaseType'] == null
          ? null
          : int.parse(json['BaseType'].toString()),
      baseEntry: json['BaseEntry'] == null ? null : json['BaseEntry'],
      baseLine: json['BaseLine'] == null ? null : json['BaseLine'],
      volume: json['Volume'] == null
          ? null
          : double.parse(json['Volume'].toString()),
      volumeUnit: json['VolumeUnit'] == null
          ? null
          : int.parse(json['VolumeUnit'].toString()),
      width1: json['Width1'] == null
          ? null
          : double.parse(json['Width1'].toString()),
      width1Unit: json['Width1Unit'] == null ? null : json['Width1Unit'],
      width2: json['Width2'] == null
          ? null
          : double.parse(json['Width2'].toString()),
      width2Unit: json['Width2Unit'] == null ? null : json['Width2Unit'],
      address: json['Address'] == null ? null : json['Address'].toString(),
      taxCode: json['TaxCode'] == null ? null : json['TaxCode'].toString(),
      taxType: json['TaxType'] == null ? null : json['TaxType'].toString(),
      taxLiable:
          json['TaxLiable'] == null ? null : json['TaxLiable'].toString(),
      pickStatus:
          json['PickStatus'] == null ? null : json['PickStatus'].toString(),
      pickQuantity: json['PickQuantity'] == null
          ? null
          : double.parse(json['PickQuantity'].toString()),
      pickListIdNumber:
          json['PickListIdNumber'] == null ? null : json['PickListIdNumber'],
      originalItem: json['OriginalItem'] == null ? null : json['OriginalItem'],
      backOrder: json['BackOrder'] == null ? null : json['BackOrder'],
      freeText: json['FreeText'] == null ? null : json['FreeText'].toString(),
      shippingMethod: json['ShippingMethod'] == null
          ? null
          : int.parse(json['ShippingMethod'].toString()),
      poTargetNum:
          json['POTargetNum'] == null ? null : json['POTargetNum'].toString(),
      poTargetEntry: json['POTargetEntry'] == null
          ? null
          : json['POTargetEntry'].toString(),
      poTargetRowNum:
          json['POTargetRowNum'] == null ? null : json['POTargetRowNum'],
      correctionInvoiceItem: json['CorrectionInvoiceItem'] == null
          ? null
          : json['CorrectionInvoiceItem'].toString(),
      corrInvAmountToStock: json['CorrInvAmountToStock'] == null
          ? null
          : double.parse(json['CorrInvAmountToStock'].toString()),
      corrInvAmountToDiffAcct: json['CorrInvAmountToDiffAcct'] == null
          ? null
          : double.parse(json['CorrInvAmountToDiffAcct'].toString()),
      appliedTax: json['AppliedTax'] == null
          ? null
          : double.parse(json['AppliedTax'].toString()),
      appliedTaxFc: json['AppliedTaxFC'] == null
          ? null
          : double.parse(json['AppliedTaxFC'].toString()),
      appliedTaxSc: json['AppliedTaxSC'] == null
          ? null
          : double.parse(json['AppliedTaxSC'].toString()),
      wtLiable: json['WTLiable'] == null ? null : json['WTLiable'].toString(),
      deferredTax:
          json['DeferredTax'] == null ? null : json['DeferredTax'].toString(),
      equalizationTaxPercent: json['EqualizationTaxPercent'] == null ? null : double.parse(json['EqualizationTaxPercent'].toString()),
      totalEqualizationTax: json['TotalEqualizationTax'] == null ? null : double.parse(json['TotalEqualizationTax'].toString()),
      totalEqualizationTaxFc: json['TotalEqualizationTaxFC'] == null ? null : double.parse(json['TotalEqualizationTaxFC'].toString()),
      totalEqualizationTaxSc: json['TotalEqualizationTaxSC'] == null ? null : double.parse(json['TotalEqualizationTaxSC'].toString()),
      netTaxAmount: json['NetTaxAmount'] == null ? null : double.parse(json['NetTaxAmount'].toString()),
      netTaxAmountFc: json['NetTaxAmountFC'] == null ? null : double.parse(json['NetTaxAmountFC'].toString()),
      netTaxAmountSc: json['NetTaxAmountSC'] == null ? null : double.parse(json['NetTaxAmountSC'].toString()),
      measureUnit: json['MeasureUnit'] == null ? null : json['MeasureUnit'].toString(),
      unitsOfMeasurment: json['UnitsOfMeasurment'] == null ? null : double.parse(json['UnitsOfMeasurment'].toString()),
      lineTotal: json['LineTotal'] == null ? null : double.parse(json['LineTotal'].toString()),
      taxPercentagePerRow: json['TaxPercentagePerRow'] == null ? null : double.parse(json['TaxPercentagePerRow'].toString()),
      taxTotal: json['TaxTotal'] == null ? null : double.parse(json['TaxTotal'].toString()),
      consumerSalesForecast: json['ConsumerSalesForecast'] == null ? null : json['ConsumerSalesForecast'].toString(),
      exciseAmount: json['ExciseAmount'] == null ? null : double.parse(json['ExciseAmount'].toString()),
      totalInclTax: json['TotalInclTax'] == null ? null : double.parse(json['TotalInclTax'].toString()),
      countryOrg: json['CountryOrg'] == null ? null : json['CountryOrg'],
      sww: json['SWW'] == null ? null : json['SWW'].toString(),
      transactionType: json['TransactionType'] == null ? null : json['TransactionType'].toString(),
      distributeExpense: json['DistributeExpense'] == null ? null : json['DistributeExpense'].toString(),
      rowTotalFc: json['RowTotalFC'] == null ? null : double.parse(json['RowTotalFC'].toString()),
      rowTotalSc: json['RowTotalSC'] == null ? null : double.parse(json['RowTotalSC'].toString()),
      lastBuyInmPrice: json['LastBuyInmPrice'] == null ? null : double.parse(json['LastBuyInmPrice'].toString()),
      lastBuyDistributeSumFc: json['LastBuyDistributeSumFc'] == null ? null : double.parse(json['LastBuyDistributeSumFc'].toString()),
      lastBuyDistributeSumSc: json['LastBuyDistributeSumSc'] == null ? null : double.parse(json['LastBuyDistributeSumSc'].toString()),
      lastBuyDistributeSum: json['LastBuyDistributeSum'] == null ? null : double.parse(json['LastBuyDistributeSum'].toString()),
      stockDistributesumForeign: json['StockDistributesumForeign'] == null ? null : double.parse(json['StockDistributesumForeign'].toString()),
      stockDistributesumSystem: json['StockDistributesumSystem'] == null ? null : double.parse(json['StockDistributesumSystem'].toString()),
      stockDistributesum: json['StockDistributesum'] == null ? null : double.parse(json['StockDistributesum'].toString()),
      stockInmPrice: json['StockInmPrice'] == null ? null : double.parse(json['StockInmPrice'].toString()),
      pickStatusEx: json['PickStatusEx'] == null ? null : json['PickStatusEx'].toString(),
      taxBeforeDpm: json['TaxBeforeDPM'] == null ? null : double.parse(json['TaxBeforeDPM'].toString()),
      taxBeforeDpmfc: json['TaxBeforeDPMFC'] == null ? null : double.parse(json['TaxBeforeDPMFC'].toString()),
      taxBeforeDpmsc: json['TaxBeforeDPMSC'] == null ? null : double.parse(json['TaxBeforeDPMSC'].toString()),
      cfopCode: json['CFOPCode'] == null ? null : json['CFOPCode'],
      cstCode: json['CSTCode'] == null ? null : json['CSTCode'],
      usage: json['Usage'] == null ? null : json['Usage'],
      taxOnly: json['TaxOnly'] == null ? null : json['TaxOnly'].toString(),
      visualOrder: json['VisualOrder'] == null ? null : int.parse(json['VisualOrder'].toString()),
      baseOpenQuantity: json['BaseOpenQuantity'] == null ? null : double.parse(json['BaseOpenQuantity'].toString()),
      unitPrice: json['UnitPrice'] == null ? null : double.parse(json['UnitPrice'].toString()),
      lineStatus: json['LineStatus'] == null ? null : json['LineStatus'].toString(),
      packageQuantity: json['PackageQuantity'] == null ? null : double.parse(json['PackageQuantity'].toString()),
      text: json['Text'] == null ? null : json['Text'].toString(),
      lineType: json['LineType'] == null ? null : json['LineType'].toString(),
      cogsCostingCode: json['COGSCostingCode'] == null ? null : json['COGSCostingCode'].toString(),
      cogsAccountCode: json['COGSAccountCode'] == null ? null : json['COGSAccountCode'].toString(),
      changeAssemlyBoMWarehouse: json['ChangeAssemlyBoMWarehouse'] == null ? null : json['ChangeAssemlyBoMWarehouse'].toString(),
      grossBuyPrice: json['GrossBuyPrice'] == null ? null : double.parse(json['GrossBuyPrice'].toString()),
      grossBase: json['GrossBase'] == null ? null : int.parse(json['GrossBase'].toString()),
      grossProfitTotalBasePrice: json['GrossProfitTotalBasePrice'] == null ? null : double.parse(json['GrossProfitTotalBasePrice'].toString()),
      costingCode2: json['CostingCode2'] == null ? null : json['CostingCode2'],
      costingCode3: json['CostingCode3'] == null ? null : json['CostingCode3'],
      costingCode4: json['CostingCode4'] == null ? null : json['CostingCode4'],
      costingCode5: json['CostingCode5'] == null ? null : json['CostingCode5'],
      itemDetails: json['ItemDetails'] == null ? null : json['ItemDetails'],
      locationCode: json['LocationCode'] == null ? null : json['LocationCode'],
      actualDeliveryDate: json['ActualDeliveryDate'] == null ? null : json['ActualDeliveryDate'],
      remainingOpenQuantity: json['RemainingOpenQuantity'] == null ? null : double.parse(json['RemainingOpenQuantity'].toString()),
      openAmount: json['OpenAmount'] == null ? null : double.parse(json['OpenAmount'].toString()),
      openAmountFc: json['OpenAmountFC'] == null ? null : double.parse(json['OpenAmountFC'].toString()),
      openAmountSc: json['OpenAmountSC'] == null ? null : double.parse(json['OpenAmountSC'].toString()),
      exLineNo: json['ExLineNo'] == null ? null : json['ExLineNo'],
      Date: json[' RequiredDate'] == null ? null : json[' RequiredDate'],
      requiredQuantity: json['RequiredQuantity'] == null ? null : double.parse(json['RequiredQuantity'].toString()),
      cogsCostingCode2: json['COGSCostingCode2'] == null ? null : json['COGSCostingCode2'],
      cogsCostingCode3: json['COGSCostingCode3'] == null ? null : json['COGSCostingCode3'],
      cogsCostingCode4: json['COGSCostingCode4'] == null ? null : json['COGSCostingCode4'],
      cogsCostingCode5: json['COGSCostingCode5'] == null ? null : json['COGSCostingCode5'],
      csTforIpi: json['CSTforIPI'] == null ? null : json['CSTforIPI'],
      csTforPis: json['CSTforPIS'] == null ? null : json['CSTforPIS'],
      csTforCofins: json['CSTforCOFINS'] == null ? null : json['CSTforCOFINS'],
      creditOriginCode: json['CreditOriginCode'] == null ? null : json['CreditOriginCode'],
      withoutInventoryMovement: json['WithoutInventoryMovement'] == null ? null : json['WithoutInventoryMovement'].toString(),
      agreementNo: json['AgreementNo'] == null ? null : json['AgreementNo'],
      agreementRowNumber: json['AgreementRowNumber'] == null ? null : json['AgreementRowNumber'],
      actualBaseEntry: json['ActualBaseEntry'] == null ? null : json['ActualBaseEntry'],
      actualBaseLine: json['ActualBaseLine'] == null ? null : json['ActualBaseLine'],
      docEntry: json['DocEntry'] == null ? null : int.parse(json['DocEntry'].toString()),
      surpluses: json['Surpluses'] == null ? null : double.parse(json['Surpluses'].toString()),
      defectAndBreakup: json['DefectAndBreakup'] == null ? null : double.parse(json['DefectAndBreakup'].toString()),
      shortages: json['Shortages'] == null ? null : double.parse(json['Shortages'].toString()),
      considerQuantity: json['ConsiderQuantity'] == null ? null : json['ConsiderQuantity'].toString(),
      partialRetirement: json['PartialRetirement'] == null ? null : json['PartialRetirement'].toString(),
      retirementQuantity: json['RetirementQuantity'] == null ? null : double.parse(json['RetirementQuantity'].toString()),
      retirementApc: json['RetirementAPC'] == null ? null : double.parse(json['RetirementAPC'].toString()),
      thirdParty: json['ThirdParty'] == null ? null : json['ThirdParty'].toString(),
      poNum: json['PoNum'] == null ? null : json['PoNum'],
      poItmNum: json['PoItmNum'] == null ? null : json['PoItmNum'],
      expenseType: json['ExpenseType'] == null ? null : json['ExpenseType'],
      receiptNumber: json['ReceiptNumber'] == null ? null : json['ReceiptNumber'],
      expenseOperationType: json['ExpenseOperationType'] == null ? null : json['ExpenseOperationType'],
      federalTaxId: json['FederalTaxID'] != null || json['FederalTaxID'] != 'null' ? json['FederalTaxID'] : null,
      grossProfit: json['GrossProfit'] == null ? null : double.parse(json['GrossProfit'].toString()),
      grossProfitFc: json['GrossProfitFC'] == null ? null : double.parse(json['GrossProfitFC'].toString()),
      grossProfitSc: json['GrossProfitSC'] == null ? null : double.parse(json['GrossProfitSC'].toString()),
      priceSource: json['PriceSource'] == null ? null : json['PriceSource'].toString(),
      stgSeqNum: json['StgSeqNum'] == null ? null : json['StgSeqNum'],
      stgEntry: json['StgEntry'] == null ? null : json['StgEntry'],
      stgDesc: json['StgDesc'] == null ? null : json['StgDesc'],
      uoMEntry: json['UoMEntry'] == null ? null : int.parse(json['UoMEntry'].toString()),
      uoMCode: json['UoMCode'] == null ? null : json['UoMCode'].toString(),
      inventoryQuantity: json['InventoryQuantity'] == null ? null : double.parse(json['InventoryQuantity'].toString()),
      remainingOpenInventoryQuantity: json['RemainingOpenInventoryQuantity'] == null ? null : double.parse(json['RemainingOpenInventoryQuantity'].toString()),
      parentLineNum: json['ParentLineNum'] == null ? null : json['ParentLineNum'].toString(),
      incoterms: json['Incoterms'] == null ? null : int.parse(json['Incoterms'].toString()),
      transportMode: json['TransportMode'] == null ? null : int.parse(json['TransportMode'].toString()),
      natureOfTransaction: json['NatureOfTransaction'] == null ? null : json['NatureOfTransaction'],
      destinationCountryForImport: json['DestinationCountryForImport'] == null ? null : json['DestinationCountryForImport'],
      destinationRegionForImport: json['DestinationRegionForImport'] == null ? null : json['DestinationRegionForImport'],
      originCountryForExport: json['OriginCountryForExport'] == null ? null : json['OriginCountryForExport'],
      originRegionForExport: json['OriginRegionForExport'] == null ? null : json['OriginRegionForExport'],
      itemType: json['ItemType'] == null ? null : json['ItemType'].toString(),
      changeInventoryQuantityIndependently: json['ChangeInventoryQuantityIndependently'] == null ? null : json['ChangeInventoryQuantityIndependently'].toString(),
      freeOfChargeBp: json['FreeOfChargeBP'] == null ? null : json['FreeOfChargeBP'].toString(),
      sacEntry: json['SACEntry'] == null ? null : json['SACEntry'],
      hsnEntry: json['HSNEntry'] == null ? null : json['HSNEntry'],
      grossPrice: json['GrossPrice'] == null ? null : double.parse(json['GrossPrice'].toString()),
      grossTotal: json['GrossTotal'] == null ? null : double.parse(json['GrossTotal'].toString()),
      grossTotalFc: json['GrossTotalFC'] == null ? null : double.parse(json['GrossTotalFC'].toString()),
      grossTotalSc: json['GrossTotalSC'] == null ? null : double.parse(json['GrossTotalSC'].toString()),
      ncmCode: json['NCMCode'] == null ? null : int.parse(json['NCMCode'].toString()),
      nveCode: json['NVECode'] == null ? null : json['NVECode'],
      indEscala: json['IndEscala'] == null ? null : json['IndEscala'].toString(),
      ctrSealQty: json['CtrSealQty'] == null ? null : double.parse(json['CtrSealQty'].toString()),
      cnjpMan: json['CNJPMan'] == null ? null : json['CNJPMan'],
      cestCode: json['CESTCode'] == null ? null : int.parse(json['CESTCode'].toString()),
      ufFiscalBenefitCode: json['UFFiscalBenefitCode'] == null ? null : json['UFFiscalBenefitCode'],
      shipToCode: json['ShipToCode'] != null || json['ShipToCode'] != 'null' ? null : json['ShipToCode'].toString(),
      shipToDescription: json['ShipToDescription'] == null ? null : json['ShipToDescription'].toString(),
      externalCalcTaxRate: json['ExternalCalcTaxRate'] == null ? null : double.parse(json['ExternalCalcTaxRate'].toString()),
      externalCalcTaxAmount: json['ExternalCalcTaxAmount'] == null ? null : double.parse(json['ExternalCalcTaxAmount'].toString()),
      externalCalcTaxAmountFc: json['ExternalCalcTaxAmountFC'] == null ? null : double.parse(json['ExternalCalcTaxAmountFC'].toString()),
      externalCalcTaxAmountSc: json['ExternalCalcTaxAmountSC'] == null ? null : double.parse(json['ExternalCalcTaxAmountSC'].toString()),
      standardItemIdentification: json['StandardItemIdentification'] == null ? null : int.parse(json['StandardItemIdentification'].toString()),
      commodityClassification: json['CommodityClassification'] == null
          ? null
          : int.parse(
              json['CommodityClassification'].toString(),
            ),
      unencumberedReason: json['UnencumberedReason'] == null ? null : json['UnencumberedReason'],
      cuSplit: json['CUSplit'] == null ? null : json['CUSplit'].toString(),
      uQtyOrdered: json['U_Qty_Ordered'] == null ? null : json['U_Qty_Ordered'],
      uOpenQty: json['U_Open_Qty'] == null ? null : json['U_Open_Qty'],
      uTonnage: json['U_Tonnage'] == null ? null : json['U_Tonnage'],
      uPackSize: json['U_PackSize'] == null ? null : json['U_PackSize'],
      uProfitCentre: json['U_Profit_Centre'] == null ? null : json['U_Profit_Centre'],
      uNumberDrums: json['U_Number_Drums'] == null ? null : json['U_Number_Drums'],
      uDrumSize: json['U_Drum_Size'] == null ? null : json['U_Drum_Size'],
      uPails: json['U_Pails'] == null ? null : json['U_Pails'],
      uCartons: json['U_Cartons'] == null ? null : json['U_Cartons'],
      uLooseTins: json['U_Loose_Tins'] == null ? null : json['U_Loose_Tins'],
      uNettWt: json['U_Nett_Wt'] == null ? null : json['U_Nett_Wt'],
      uGrossWt: json['U_Gross_Wt'] == null ? null : json['U_Gross_Wt'],
      uAppLinId: json['U_AppLinId'] == null ? null : json['U_AppLinId'],
      uMuQty: json['U_MUQty'] == null ? null : json['U_MUQty'],
      uRvc: json['U_RVC'] == null ? null : json['U_RVC'],
      uVrn: json['U_VRN'] == null ? null : json['U_VRN'],
      uIdentifier: json['U_Identifier'] == null ? null : json['U_Identifier'],
      taxPerUnit: json['TaxPerUnit'] == null ? null : double.parse(json['TaxPerUnit'].toString()),
      U_Pack_Size: json['U_Pack_Size'] == null ? null : double.parse(json['U_Pack_Size'].toString())
// U_Tins_Per_Box:double.parse(json['U_Tins_Per_Box'].toString()),

      // lineTaxJurisdictions: List<dynamic>.from(json['LineTaxJurisdictions'].map((x) => x)),
      // documentLineAdditionalExpenses: List<dynamic>.from(json['DocumentLineAdditionalExpenses'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'LineNum': lineNum,
        'ItemCode': itemCode,
        'ItemDescription': itemDescription,
        'Quantity': quantity,
        'ShipDate': shipDate,
        'Price': price,
        'PriceAfterVAT': total,
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
        'RequiredDate': Date,
        'RequiredQuantity': requiredQuantity,
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
