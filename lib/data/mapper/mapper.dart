import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/app/extension.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:advanced_flutter/domain/model/model.dart';
// 04
extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain()
  {
    return Customer(
        id: this?.id.orEmpty() ?? Constants.empty,
        name: this?.name.orEmpty() ?? Constants.empty,
        numberOfNotifications: this?.numberOfNotifications.orZero() ?? Constants.zero
    );
  }
}

extension ContactResponseMapper on ContactResponse?{
  Contact toDomain()
  {
    return Contact(
        phone: this?.phone.orEmpty() ?? Constants.empty,
        email: this?.email.orEmpty() ?? Constants.empty,
        link: this?.link.orEmpty() ?? Constants.empty
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain()
  {
    return Authentication(
        customer: this?.customer.toDomain(),
        contact: this?.contacts.toDomain(),
    );
  }
}