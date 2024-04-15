import 'dart:js_interop';

import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/home/home_viewModel/home_viewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/model/model.dart';
import '../../../../../resources/strings_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind(){
    _homeViewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _homeViewModel.outState,
            builder: (context , snapshot){
              return snapshot.data?.getScreenWidget(context , _getContentView(), (){
                _homeViewModel.start();
              }) ??
                  _getContentView() ;
            }
        ),
      )
    );
  }

  // *** all content home view ***
  Widget _getContentView (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSections(AppStrings.services),
        _getServices(),
        _getSections(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  // *** list banners ***
  Widget _getBannersCarousel(){
    return StreamBuilder<List<Banners>>(
        stream: _homeViewModel.outputBanners,
        builder: (context , snapshot){
          return _getBannersWidget(snapshot.data);
        }
    );
  }

  // *** banners data
  Widget _getBannersWidget(List<Banners>? banners){
    if(banners != null){
      return CarouselSlider(
          items: banners.map((banner) =>
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(banner.image,fit:BoxFit.cover,),
                  ),
                ),
              )
          ).toList(),
          options: CarouselOptions(
            height: AppSize.s90,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true
          )
      );
    }else{
      return Container();
    }
  }
  // *** sections ***
  Widget _getSections(String title){
    return  Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p4,
        ),
        child: Text(
          title ,
          style: Theme.of(context).textTheme.labelSmall,
        ),
    );
  }

  // *** services ***
  Widget _getServices(){
    return Center();
  }

  // *** stores ***
  Widget _getStores(){
    return Center();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
