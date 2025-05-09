
class AddressrModel {
  PlusCode plusCode;
  List<Result> results;
  String status;
  int? stcode;

  AddressrModel({
    required this.plusCode, required this.results, required this.status, this.stcode,
  });

  factory AddressrModel.fromJson(dynamic json, int stcode) {
    final list = json['results'] as List; //jsonDecode
    // print(list);
    final dataList =
        list.map((dynamic enquiries) => Result.fromJson(enquiries)).toList();

    return AddressrModel(
        plusCode: PlusCode.fromJson(json['plus_code']),
        results: dataList,
        // List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
        status: json['status'].toString(),
        stcode: stcode,);
  }
  Map<String, dynamic> toJson() => {
        'plus_code': plusCode.toJson(),
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
        'status': status,
      };
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  // factory PlusCode.fromRawJson(String str) => PlusCode.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory PlusCode.fromJson(dynamic json) {
    return PlusCode(
      compoundCode: json['compound_code'].toString(),
      globalCode: json['global_code'].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
        'compound_code': compoundCode,
        'global_code': globalCode,
      };
}

class Result {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  List<String>? types;
  PlusCode? plusCode;

  Result({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    this.types,
    this.plusCode,
  });

  // factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Result.fromJson(dynamic json) {
    final list = json['address_components'] as List; //jsonDecode
    // print(list);
    final dataList = list
        .map((dynamic enquiries) => AddressComponent.fromJson(enquiries))
        .toList();

    return Result(
      addressComponents: dataList,
      // List<AddressComponent>.from(
      //     json['address_components']
      //         .map((x) => AddressComponent.fromJson(x))),
      formattedAddress: json['formatted_address'].toString(),
      geometry: Geometry.fromJson(json['geometry']),
      placeId: json['place_id'].toString(),
      // types: List<String>.from(json['types'].map((x) => x)),
      plusCode: json['plus_code'] == null
          ? null
          : PlusCode.fromJson(json['plus_code']),
    );
  }
  Map<String, dynamic> toJson() => {
        'address_components':
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        'formatted_address': formattedAddress,
        'geometry': geometry.toJson(),
        'place_id': placeId,
        'types': List<dynamic>.from(types!.map((x) => x)),
        'plus_code': plusCode?.toJson(),
      };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String>? types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    this.types,
  });

  // factory AddressComponent.fromRawJson(String str) => AddressComponent.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory AddressComponent.fromJson(dynamic json) => AddressComponent(
        longName: json['long_name'].toString(),
        shortName: json['short_name'].toString(),
        // types: List<String>.from(json['types'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'long_name': longName,
        'short_name': shortName,
        'types': List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Viewport? bounds;
  Location location;
  String locationType;
  Viewport viewport;

  Geometry({
    required this.bounds,
    required this.location,
    required this.locationType,
    required this.viewport,
  });

  // factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(dynamic json) => Geometry(
        bounds:
            json['bounds'] == null ? null : Viewport.fromJson(json['bounds']),
        location: Location.fromJson(json['location']),
        locationType: json['location_type'].toString(),
        viewport: Viewport.fromJson(json['viewport']),
      );

  Map<String, dynamic> toJson() => {
        'bounds': bounds?.toJson(),
        'location': location.toJson(),
        'location_type': locationType,
        'viewport': viewport.toJson(),
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  // factory Viewport.fromRawJson(String str) => Viewport.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Viewport.fromJson(dynamic json) => Viewport(
        northeast: Location.fromJson(json['northeast']),
        southwest: Location.fromJson(json['southwest']),
      );

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  // factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Location.fromJson(dynamic json) => Location(
        lat: double.parse(json['lat'].toString()),
        lng: double.parse(json['lng'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}
