import 'dart:convert';

ReverseQueryResponse reverseQueryResponseFromJson(String str) => ReverseQueryResponse.fromJson(json.decode(str));

String reverseQueryResponseToJson(ReverseQueryResponse data) => json.encode(data.toJson());

class ReverseQueryResponse {
  ReverseQueryResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  String? type;
  List<double>? query;
  List<Feature>? features;
  String? attribution;

  factory ReverseQueryResponse.fromJson(Map<String, dynamic> json) => ReverseQueryResponse(
    type: json["type"],
    query: List<double>.from(json["query"].map((x) => x)),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    attribution: json["attribution"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "query": List<dynamic>.from(query!.map((x) => x)),
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
    "attribution": attribution,
  };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.matchingText,
    this.matchingPlaceName,
    this.center,
    this.geometry,
    this.address,
    this.context,
  });

  String? id;
  String? type;
  List<String>? placeType;
  double? relevance;
  Properties? properties;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  String? matchingText;
  String? matchingPlaceName;
  List<double>? center;
  Geometry? geometry;
  String? address;
  List<Context>? context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    type: json["type"],
    placeType: List<String>.from(json["place_type"].map((x) => x)),
    relevance: json["relevance"].toDouble(),
    properties: Properties.fromJson(json["properties"]),
    textEs: json["text_es"],
    placeNameEs: json["place_name_es"],
    text: json["text"],
    placeName: json["place_name"],
    matchingText: json["matching_text"],
    matchingPlaceName: json["matching_place_name"],
    center: List<double>.from(json["center"].map((x) => x.toDouble())),
    geometry: Geometry.fromJson(json["geometry"]),
    address: json["address"],
    context: List<Context>.from(json["context"]?.map((x) => Context.fromJson(x)) ?? [] ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "place_type": List<dynamic>.from(placeType!.map((x) => x)),
    "relevance": relevance,
    "properties": properties!.toJson(),
    "text_es": textEs,
    "place_name_es": placeNameEs,
    "text": text,
    "place_name": placeName,
    "matching_text": matchingText,
    "matching_place_name": matchingPlaceName,
    "center": List<dynamic>.from(center!.map((x) => x)),
    "geometry": geometry!.toJson(),
    "address": address,
    "context": List<dynamic>.from(context!.map((x) => x.toJson())),
  };
}

class Context {
  Context({
    this.id,
    this.textEs,
    this.text,
    this.wikidata,
    this.languageEs,
    this.language,
    this.shortCode,
  });

  String? id;
  String? textEs;
  String? text;
  String? wikidata;
  Language? languageEs;
  Language? language;
  ShortCode? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
      id: json["id"],
      textEs: json["text_es"],
      text: json["text"],
      wikidata: json["wikidata"] == null ? null : json["wikidata"],
      languageEs: json["language_es"] == null ? null : languageValues.map![json["language_es"]],
      language: json["language"] == null ? null : languageValues.map![json["language"]],
      shortCode: json["short_code"] == null ? null : shortCodeValues.map![json["short_code"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text_es": textEs,
    "text": text,
    "wikidata": wikidata == null ? null : wikidata,
    "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
    "language": language == null ? null : languageValues.reverse[language],
    "short_code": shortCode == null ? null : shortCodeValues.reverse[shortCode],
  };
}

enum Language { EN, ES, FR }

final languageValues = EnumValues({
  "en": Language.EN,
  "es": Language.ES,
  "fr": Language.FR
});

enum ShortCode { AU_QLD, AU, AU_NSW }

final shortCodeValues = EnumValues({
  "au": ShortCode.AU,
  "AU-NSW": ShortCode.AU_NSW,
  "AU-QLD": ShortCode.AU_QLD
});

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
    this.interpolated,
  });

  String? type;
  List<double>? coordinates;
  bool? interpolated;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    interpolated: json["interpolated"] == null ? null : json["interpolated"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
    "interpolated": interpolated == null ? null : interpolated,
  };
}

class Properties {
  Properties({
    this.accuracy,
  });

  String? accuracy;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
      accuracy: json["accuracy"],
  );

  Map<String, dynamic> toJson() => {
      "accuracy": accuracy,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap ?? {};
  }
}
