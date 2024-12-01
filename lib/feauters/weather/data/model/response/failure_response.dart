import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/feauters/weather/data/model/entity/entity.dart';

part 'failure_response.g.dart';

@JsonSerializable()
class FailureResponse {
  final Failure error;

  FailureResponse({required this.error});

  factory FailureResponse.fromJson(Map<String, dynamic> json) =>
      _$FailureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FailureResponseToJson(this);
}
