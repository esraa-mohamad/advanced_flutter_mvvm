import 'dart:io';

import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/register/viewModel/register_view_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/constants.dart';
import '../../../../app/di.dart';
import '../../../common/state_render/state_renderer_imp.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobilePhoneEditingController =
      TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _registerViewModel.start();
    _userNameEditingController.addListener(
        () => _registerViewModel.setUserName(_userNameEditingController.text));
    _emailEditingController.addListener(
            () => _registerViewModel.setEmail(_emailEditingController.text));
    _passwordEditingController.addListener(
            () => _registerViewModel.setPassword(_passwordEditingController.text));
    _mobilePhoneEditingController.addListener(
            () => _registerViewModel.setMobilePhone(_mobilePhoneEditingController.text));
    _registerViewModel.isUserRegisterSuccessfullyStreamController.stream.listen((isRegistered){
      if(isRegistered){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });

      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),

      ),
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outState,
        builder: (context , snapshot){
          return snapshot.data?.getScreenWidget(context , _getContentView(), (){
            _registerViewModel.register();
          }) ??
              _getContentView() ;
        },
      ),
    );
  }

  Widget _getContentView(){
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p28),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child:   Column(
              children: [
                // image
                const Center(
                  child: Image(
                    image: AssetImage(ImageAssets.splashLogo),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),

                // user name
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _registerViewModel.userNameErrorOutput,
                    builder: (context , snapshot){
                      return TextFormField(
                        keyboardType:  TextInputType.text,
                        controller: _userNameEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username ,
                          errorText: (snapshot.data)
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                // mobile phone
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                    child:Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country){
                              // update view model with country code
                              _registerViewModel.setCountryMobileCode(country.dialCode ?? Constants.token);
                            },
                            initialSelection: '+20',
                            favorite: const ['+20','FR' "+966"],
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            hideMainText: true,
                            alignLeft: false,
                            ),
                        ),
                        Expanded(
                          flex: 4,
                          child:  StreamBuilder<String?>(
                            stream: _registerViewModel.mobilePhoneErrorOutput,
                            builder: (context , snapshot){
                              return TextFormField(
                                keyboardType:  TextInputType.phone,
                                controller: _mobilePhoneEditingController,
                                decoration: InputDecoration(
                                    hintText: AppStrings.mobilePhone,
                                    labelText: AppStrings.mobilePhone ,
                                    errorText: (snapshot.data)
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                // email
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _registerViewModel.emailErrorOutput,
                    builder: (context , snapshot){
                      return TextFormField(
                        keyboardType:  TextInputType.emailAddress,
                        controller: _emailEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email ,
                            errorText: (snapshot.data)
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                // password
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _registerViewModel.passwordErrorOutput,
                    builder: (context , snapshot){
                      return TextFormField(
                        keyboardType:  TextInputType.visiblePassword,
                        controller: _passwordEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password ,
                          errorText: (snapshot.data)
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),

                // profile picture
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child:Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                      border: Border.all(
                        color: ColorManager.grey
                      )
                    ),
                    child:GestureDetector(
                      child:  _getMediaWidget(),
                      onTap: (){
                        _showPicker(context);
                      },
                    ),
                  ) ,
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),

                // button
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _registerViewModel.areAllOutputValid,
                    builder: (context , snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ?(){_registerViewModel.register();}
                              : null,
                          child: const Text(
                            AppStrings.register,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // text button
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p18,
                      left: AppPadding.p28,
                      right: AppPadding.p28
                  ),
                  child:TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child :Text(
                      AppStrings.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget  _getMediaWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8 , right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
              child:Text(
                  AppStrings.profilePicture
              ),
          ),
          Flexible(
              child: StreamBuilder<File>(
                stream: _registerViewModel.profilePictureOutput,
                builder: (context , snapshot){
                  return _imagePickedByData(snapshot.data);
                },
              )
          ),
          Flexible(
            child:SvgPicture.asset(ImageAssets.photoCamera),
          ),
        ],
      ),
    );
  }

  _showPicker(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward),
                    leading: const Icon(Icons.camera_front),
                    title: const Text(AppStrings.photoGallery),
                    onTap: (){
                      _photoFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward),
                    leading: const Icon(Icons.camera_alt),
                    title: const Text(AppStrings.photoCamera),
                    onTap: (){
                      _photoFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
          );
        }
    );
  }

  _photoFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image?.path ?? "" ));
  }

  _photoFromCamera()async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePicture(File(image?.path ?? "" ));
  }

  Widget _imagePickedByData(File? image)
  {
    if(image != null && image.path.isNotEmpty){
      // return image
      return Image.file(image);
    }else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _registerViewModel.dispose();
  }
}
