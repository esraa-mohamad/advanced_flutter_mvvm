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