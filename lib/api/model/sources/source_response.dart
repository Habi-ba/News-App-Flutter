import 'source.dart';

/// status : "ok"

class SourceResponse {
  SourceResponse({this.status, this.source, this.code, this.message});

  SourceResponse.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['sources'] != null) {
      source = [];
      json['sources'].forEach((v) {
        source?.add(Source.fromJson(v));
      });
    }
  }

  String? status;
  List<Source>? source;
  String? message;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (source != null) {
      map['sources'] = source?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
