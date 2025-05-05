// import 'dart:html';
// ignore_for_file: cascade_invocations, prefer_single_quotes, unnecessary_parenthesis, unused_local_variable

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:ultimate_bundle/src/furney/src/pages/PDF/invoicemodel.dart';
import 'package:ultimate_bundle/src/furney/src/pages/PDF/pdfApi.dart';
//import 'dart:js';
// import 'package:generate_pdf_invoice_example/api/pdf_api.dart';
// import 'package:generate_pdf_invoice_example/model/customer.dart';
// import 'package:generate_pdf_invoice_example/model/invoice.dart';
// import 'package:generate_pdf_invoice_example/model/supplier.dart';
// import 'package:generate_pdf_invoice_example/utils.dart';


class PdfInvoiceApi{
  static int? height;
  static String? remark;
  static Future<File> generate(Invoice invoice)async{
   
    final pdf=Document();
    pdf.addPage(
      MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat(15*PdfPageFormat.cm, height!*PdfPageFormat.cm,marginAll: 0.5* PdfPageFormat.cm),
      build: (context)=>[
   //   inVoiceHead(invoice),
      inVoiceMiddle(invoice),
    //  inVoiceTable(invoice),
     // inVoiceCash(invoice)
    ],),);
    
    return PdfApi.saveDocument(name: "${invoice.invoiceMiddle.customerName}.pdf", pdf: pdf);
  }
  
  static Widget inVoiceMiddle(Invoice invoice){
      final headers =[
      "S.No",
      "Description",
      "Price",
      "Qty",
      "Total",
    ];
    final data = invoice.items.map((e) {
      final total = (e.quantity);
      return [
        e.slNo,
        (e.descripton),
        (e.price),
        (e.quantity),
        (e.total),
      ];
    }).toList();
    return Wrap(children: [
    Column(
    
   crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Center( child:Text(invoice.headerinfo.companyName,
     style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
     ),),),
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //   Center( child:Text(invoice.headerinfo.address,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  )))]),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text(invoice.headerinfo.area,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text("- "+invoice.headerinfo.pincode,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]), 
    //   Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text("Mobile:",
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text(" "+invoice.headerinfo.mobile,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]),
    //       Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text("GstNo: ",
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text("- "+invoice.headerinfo.gstNo,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
      // Text("Sales Order: "+invoice.headerinfo.salesOrder,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
     SizedBox(height: 0.2 * PdfPageFormat.cm),
      
       Text("Mr./Mrs./Ms: ${invoice.invoiceMiddle.customerName}",style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
      ),),
      Text("warehouseCode: ${invoice.invoiceMiddle.warehouseCode}",style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
      ),),
      //  Text("Address: "+invoice.invoiceMiddle.address,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //  Text("City: "+invoice.invoiceMiddle.city,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //   Text("Area: "+invoice.invoiceMiddle.city,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //  Text("Pin: "+invoice.invoiceMiddle.pin,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
     
      SizedBox(height: 0.2 * PdfPageFormat.cm),
      Table.fromTextArray(
        columnWidths: {
          0:const FlexColumnWidth(0.5),
          1:const FlexColumnWidth(2.5),
          2:const FlexColumnWidth(0.8),
          3:const FlexColumnWidth(0.5),
          4:const FlexColumnWidth(0.8),
        },
        headerStyle: const TextStyle(
          fontSize: 10,
        ),
        cellStyle: const TextStyle(
          fontSize: 9,
        ),
      headers: headers,
      data: data,
      ),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Text("Cash: ${invoice.invoiceCash.cash}",style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
      ),),
       Text("Total: ${invoice.invoiceCash.total}",
     style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 15,
     ),),
      ],),
      //   Text("UPIAmount: "+invoice.invoiceCash.upiAmnt,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //  Text("Card1: "+invoice.invoiceCash.card1,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //   Text("Card2: "+invoice.invoiceCash.card2,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
      //  Text("Exchange: "+invoice.invoiceCash.exchange,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      // Text("Finance: "+invoice.invoiceCash.finance,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      // Text("COD: "+invoice.invoiceCash.cod,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
      // Text("Credit: "+invoice.invoiceCash.credit,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
      //   Text("Discount: "+invoice.invoiceCash.discountamt,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
    //    Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //     Text("Advance: "+invoice.invoiceCash.advance,style: TextStyle(
    //   fontWeight: FontWeight.bold,
    //   fontSize: 10.0
    //   )),

    // //   Text("Total: "+invoice.invoiceCash.total,
    // //  style: TextStyle(
    // //    fontWeight: FontWeight.bold,
    // //    fontSize: 15.0
    // //  ))
    //     ]),
    //   SizedBox(height: 0.2 * PdfPageFormat.cm),
    //  Center( child:Text("Total: "+invoice.invoiceCash.total,
    //  style: TextStyle(
    //    fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
     Text("Sales Employee: ${invoice.invoiceCash.salesEmployee}",
     style: TextStyle(
      fontWeight: FontWeight.bold,
       fontSize: 10,
     ),),
     SizedBox(height: 0.2 * PdfPageFormat.cm),
    //  Text("Remarks: "+invoice.invoiceCash.remarks,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  )),
    //   Text("Delivery Date: "+invoice.invoiceCash.deliverydate,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  )),
    //   Text("Delivery Time: "+invoice.invoiceCash.deliveryTime,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))
    ],
 ),],)
 ;}
   static Widget inVoiceHead(Invoice invoice)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Center( child:Text(invoice.headerinfo.companyName,
     style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
     ),),),
    //   Center( child:Text(invoice.headerinfo.address,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text(invoice.headerinfo.area,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text("- "+invoice.headerinfo.pincode,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]), 
    //   Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text("Mobile:",
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text(" "+invoice.headerinfo.mobile,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]),
    //       Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Center( child:Text("GstNo: ",
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    //    Center( child:Text("- "+invoice.headerinfo.mobile,
    //  style: TextStyle(
    //   // fontWeight: FontWeight.bold,
    //    fontSize: 10.0
    //  ))),
    // ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      // Text("Sales Order: "+invoice.headerinfo.salesOrder,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
     SizedBox(height: 0.4 * PdfPageFormat.cm),
      
    ],
  );
  static Widget inVoiceTable(Invoice invoice){
    final headers =[
      "s.No",
      "Description",
      "Quantity",
    ];
    final data = invoice.items.map((e) {
      final total = (e.quantity);
      return [
        e.slNo,
        (e.descripton),
        (e.quantity),
      ];
    }).toList();
    return Table.fromTextArray(
      headers: headers,
      data: data,
      );
  } 

   static Widget inVoiceCash(Invoice invoice)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       SizedBox(height: 0.4 * PdfPageFormat.cm),
       Text("Cash: ${invoice.invoiceCash.cash}",style: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: 10,
      ),),
      //  Text("Card: "+invoice.invoiceCash.card1,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      //  Text("Exchange: "+invoice.invoiceCash.exchange,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      // Text("Finance: "+invoice.invoiceCash.finance,style: TextStyle(
      //  fontWeight: FontWeight.bold,
      //  fontSize: 10.0
      // )),
      // Text("COD: "+invoice.invoiceCash.cod,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
      // Text("Credit: "+invoice.invoiceCash.credit,style: TextStyle(
      // fontWeight: FontWeight.bold,
      // fontSize: 10.0
      // )),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
     Center( child:Text("Total: ${invoice.invoiceCash.total}",
     style: const TextStyle(
      // fontWeight: FontWeight.bold,
       fontSize: 10,
     ),),),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
     Text("Sales Employee: ${invoice.invoiceCash.salesEmployee}",
     style: const TextStyle(
      // fontWeight: FontWeight.bold,
       fontSize: 10,
     ),),
    ],
 );
}