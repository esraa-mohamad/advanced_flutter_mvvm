class LoginRequests {
  String email;

  String password;

  LoginRequests(this.email, this.password);
}

class RegisterRequests {
  String email;

  String password;

  String userName;

  String countryMobileCode;

  String mobilePhone;

  String profilePicture;

  RegisterRequests(
      {required this.email,
      required this.password,
      required this.userName,
      required this.countryMobileCode,
      required this.mobilePhone,
      required this.profilePicture});
}
