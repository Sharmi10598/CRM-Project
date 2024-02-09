
// ignore_for_file: omit_local_variable_types, file_names
// ignore_for_file: omit_local_variable_types
class BalanceCreaditModal{
  String ?odatametadata;
  List<BalanceCreaditValue>? balanceCreaditValue;
  String? error;
 
  BalanceCreaditModal({
   required this.odatametadata,
   this.balanceCreaditValue,
   this.error,

  });
   factory BalanceCreaditModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list =  jsons['value'] as List; //jsonDecode
      // print(list);
      List<BalanceCreaditValue> dataList = list
          .map((dynamic enquiries) => BalanceCreaditValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return BalanceCreaditModal(
        balanceCreaditValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
       // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return BalanceCreaditModal(
        odatametadata: null,
          );
    }
  }

   factory BalanceCreaditModal.issue(String e) {
      return BalanceCreaditModal(
       odatametadata: null,
        error:e,
          );
  }
}

class BalanceCreaditValue{
double ? CreditLimit;
double ?Balance;
double ?OrdersBal;

BalanceCreaditValue({
 required  this.CreditLimit,
 required this.Balance,
 this.OrdersBal,

});

 factory BalanceCreaditValue.fromJson(dynamic jsons) {      
    return BalanceCreaditValue(
      CreditLimit: jsons['CreditLine']as double, 
      Balance: jsons['Balance']as double, 
      OrdersBal:jsons['OrdersBal']as double,
       );
 }
}


