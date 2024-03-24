import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/app/extension.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:advanced_flutter/domain/model/model.dart';

// authentication (login) response mapper
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id.orEmpty() ?? Constants.empty,
        name: this?.name.orEmpty() ?? Constants.empty,
        numberOfNotifications:
            this?.numberOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
        phone: this?.phone.orEmpty() ?? Constants.empty,
        email: this?.email.orEmpty() ?? Constants.empty,
        link: this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer.toDomain(),
      contact: this?.contacts.toDomain(),
    );
  }
}

//  forget response mapper
extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

// home response mapper

extension ServicesResponseMapper on ServicesResponse? {
  Services toDomain() {
    return Services(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title.orEmpty() ?? Constants.empty,
        image: this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannersResponseMapper on BannersResponse? {
  Banners toDomain() {
    return Banners(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title.orEmpty() ?? Constants.empty,
        link: this?.link.orEmpty() ?? Constants.empty,
        image: this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title.orEmpty() ?? Constants.empty,
        image: this?.image.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeModel toDomain() {
    List<Services> services =
    (this?.data?.services?.map((servicesResponse) => servicesResponse.toDomain()) ??
        const Iterable.empty()).cast<Services>().toList();
    List<Banners> banners =
    (this?.data?.banners?.map((bannersResponse) => bannersResponse.toDomain()) ??
        const Iterable.empty()).cast<Banners>().toList();
    List<Stores> stores =
    (this?.data?.stores?.map((storesResponse) => storesResponse.toDomain()) ??
        const Iterable.empty()).cast<Stores>().toList();
    var data = HomeData(services: services, banners: banners, stores: stores);
    return HomeModel(data);
  }
}
