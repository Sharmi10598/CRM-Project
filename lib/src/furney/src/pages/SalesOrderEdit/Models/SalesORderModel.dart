class SalesModel {
  String docno;
  String bpName;
  String bpCode;
  String currentACbalance;
  String ordersBal;
  String paymentTerms;
  String contactPerson;
  String currency;
  String status;
  String salesEmp;
  String docDate;
  double totalBeforeDiscount;
  double discount;
  double discountpercent;
  double tax;
  double total;
  bool isTextFiledEnabled;
  SalesModel({
    required this.isTextFiledEnabled,
    required this.docno,
    required this.docDate,
    required this.bpCode,
    required this.bpName,
    required this.contactPerson,
    required this.currency,
    required this.currentACbalance,
    required this.discount,
    required this.discountpercent,
    required this.ordersBal,
    required this.paymentTerms,
    required this.salesEmp,
    required this.status,
    required this.tax,
    required this.total,
    required this.totalBeforeDiscount,
  });
}
  // static List<TextEditingController> mycontroller =
  //     List.generate(15, (i) => TextEditingController());
  // static String? currentDateTime;

  // static PageController pageController = PageController();
  // int pageChanged = 0;
  // static String isHaveAdvance = '';
  // static bool isCameFromqutation = false;
  
  // //
  // List<ContactEmployeValue> contactValue = [];
  // List<ContactEmployeValue> filtercontactValue = [];
  // void callapi() {
  //   ContactPersonsAPi.getGlobalData().then((value) {
  //     if (value.deliveryModaleValue!.isNotEmpty) {
  //       setState(() {
  //         contactValue = value.deliveryModaleValue!;
  //         filtercontactValue = contactValue;
  //         LogisticPageState.shipto = value.ShipToDefault.toString();
  //         LogisticPageState.billto = value.BilltoDefault.toString();
  //       });
  //     }else{
        
  //     }
  //   });
  // }
