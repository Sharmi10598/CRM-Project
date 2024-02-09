
class Invoice {
  final InvoiceHeader headerinfo;
  final InvoiceMiddle invoiceMiddle;
  final InvoiceCash invoiceCash;
  final List<InvoiceItem> items;

  const Invoice({
    required this.headerinfo,
    required this.invoiceMiddle,
    required this.invoiceCash,
    required this.items,
  });
}

class InvoiceHeader {
  final String companyName;
  // final String address;
  // final String area;
  // final String pincode;
  // final String mobile;
  // final String gstNo;
  //  final String salesOrder;

  const InvoiceHeader({
    required this.companyName,
    // required this.address,
    // required this.area,
    // required this.pincode,
    // required this.mobile,
    // required this.gstNo,
    // required this.salesOrder,
  });
}
class InvoiceMiddle{
  final String warehouseCode;
  
  final String customerName;
  
  const InvoiceMiddle({
    required this.warehouseCode,
    
    required this.customerName,
    
  });
}
class InvoiceItem {
  final String slNo;
  final String descripton;
  final String price;
  final String total;
  final String quantity;

  const InvoiceItem({
    required this.slNo,
    required this.descripton,
    required this.quantity,
     required this.total,
      required this.price,
  });
}

class InvoiceCash{
  final String cash;
  // final String card1;
  // final String card2;
  // final String exchange;
  // final String finance;
  // final String cod;
  // final String credit;
  final String total;
  // final String advance;
  // final String discountamt;
  final String salesEmployee;
  // final String remarks;
  final String upiAmnt;
  // final String deliverydate;
  // final String deliveryTime;
  const InvoiceCash({
    required this.upiAmnt,
  //  required this.upiRef,
    // required this.remarks,
    // required this.advance,
    // required this.discountamt,
    required this.cash,
    // required this.card1,
    // required this.card2,
    // required this.exchange,
    // required this.finance,
    // required this.cod,
    // required this.credit,
    required this.total,
    required this.salesEmployee,
    // required this.deliveryTime,
    // required this.deliverydate,
  }); 
}


