class StockSnapModel {
  String response;
  String expmsg;
  int stsCode;
  StockSnapModel({
    required this.response,
    required this.stsCode,
    required this.expmsg,
  });
  factory StockSnapModel.fromJson(String jsons, int stscode) {
    if (stscode == 200) {
      return StockSnapModel(response: jsons, stsCode: stscode, expmsg: '');
    } else {
      return StockSnapModel(response: jsons, stsCode: stscode, expmsg: '');
    }
  }
  factory StockSnapModel.issue(String jsons, int statuzCode) {
    return StockSnapModel(
      response: jsons, stsCode: statuzCode, expmsg: jsons,
      // data: null
    );
  }
}
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);



// List<int> welcomeFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));


