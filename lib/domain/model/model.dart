// onboarding models
class SliderObject
{
  String title;
  String subTitle;
  String image ;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class SliderViewObject
{
  SliderObject sliderObject ;
  int numOfSlides ;
  int currentIndex;

  SliderViewObject(this.sliderObject , this.numOfSlides , this.currentIndex);

}
// login models

class Customer{
  String  id ;
  String  name ;
  int  numberOfNotifications ;

  Customer({required this.id , required this.name , required this.numberOfNotifications});
}

class Contact{
  String  phone ;
  String  email ;
  String  link ;

  Contact({required this.phone , required this.email , required this.link});
}

class Authentication{
  Customer?  customer ;
  Contact?  contact ;

  Authentication({required this.customer , required this.contact});
}

class Services {
  int id ;
  String title ;
  String image ;

  Services({required this.id , required this.title , required this.image});
}

class Banners {
  int id ;
  String title ;
  String link ;
  String image ;

  Banners({required this.id , required this.title , required this.link ,required this.image});
}

class Stores {
  int id ;
  String title ;
  String image ;

  Stores({required this.id , required this.title , required this.image});
}

class HomeData {
  List<Services> services ;
  List<Banners> banners ;
  List<Stores> stores ;

  HomeData({required this.services , required this.banners , required this.stores});
}

class HomeModel {
  HomeData ? data ;
  HomeModel(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}