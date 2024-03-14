// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
// 01
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int ? status ;
  @JsonKey(name: "message")
  String ? message ;

}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String ? id ;
  @JsonKey(name: "name")
  String ? name ;
  @JsonKey(name :"numberOfNotifications")
  int ? numberOfNotifications ;
  
  CustomerResponse({required this.id , required this.name , required this.numberOfNotifications});

  //  from json
  factory CustomerResponse.fromJson(Map<String,dynamic> json) =>
      _$CustomerResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "phone")
  String ? phone ;
  @JsonKey(name: "email")
  String ? email ;
  @JsonKey(name :"link")
  String ? link ;

  ContactResponse({required this.email , required this.link ,  required this.phone});

  //  from json
  factory ContactResponse.fromJson(Map<String,dynamic> json) =>
      _$ContactResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse ? customer ;
  @JsonKey(name: "contacts")
  ContactResponse ? contacts ;
  
  AuthenticationResponse({required this.contacts , required this.customer ,});

  //  from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse{
  @JsonKey(name: "support")
  String ? support ;

  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String,dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$ForgetPasswordResponseToJson(this);
}
