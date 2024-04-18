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

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  int ? id ;
  @JsonKey(name: "title")
  String ? title ;
  @JsonKey(name: "image")
  String ? image ;

  ServicesResponse({required this.id , required this.title , required this.image});


  factory ServicesResponse.fromJson(Map<String,dynamic> json) =>
      _$ServicesResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: "id")
  int ? id ;
  @JsonKey(name: "title")
  String ? title ;
  @JsonKey(name: "image")
  String ? image ;
  @JsonKey(name: "link")
  String ? link ;

  BannersResponse({required this.id , required this.title , required this.image , required this.link});


  factory BannersResponse.fromJson(Map<String,dynamic> json) =>
      _$BannersResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$BannersResponseToJson(this);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: "id")
  int ? id ;
  @JsonKey(name: "title")
  String ? title ;
  @JsonKey(name: "image")
  String ? image ;

  StoresResponse({required this.id , required this.title , required this.image});


  factory StoresResponse.fromJson(Map<String,dynamic> json) =>
      _$StoresResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$StoresResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServicesResponse>? services;

  @JsonKey(name: "banners")
  List<BannersResponse>? banners;

  @JsonKey(name: "stores")
  List<StoresResponse>? stores;

  HomeDataResponse(
      {required this.services, required this.banners, required this.stores});

  factory HomeDataResponse.fromJson(Map<String,dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String,dynamic> json) =>
      _$HomeResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() =>
      _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse(this.id, this.title, this.image,this.details, this.services, this.about);

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}