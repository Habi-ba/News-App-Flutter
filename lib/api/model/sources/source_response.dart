import 'package:hive_ce/hive_ce.dart';

import 'source.dart';

part 'source_response.g.dart';

/// status : "ok"
@HiveType(typeId: 1)
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

  @HiveField(0)
  String? status;
  @HiveField(1)
  List<Source>? source;
  @HiveField(2)
  String? message;
  @HiveField(3)
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
