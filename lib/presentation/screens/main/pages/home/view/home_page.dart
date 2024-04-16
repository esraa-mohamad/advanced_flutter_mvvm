
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/home/home_viewModel/home_viewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  // *** stream banners ***
  Widget _getBannersCarousel(){
    return StreamBuilder<List<Banners>>(
        stream: _homeViewModel.outputBanners,
        builder: (context , snapshot){
          return _getBannersWidget(snapshot.data);
        }
    );
  }

  // *** banners data list ***
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

  // *** stream services ***
  Widget _getServices(){
    return StreamBuilder<List<Services>>(
        stream: _homeViewModel.outputServices,
        builder: (context , snapshot){
          return _getServicesWidget(snapshot.data);
        }
    );
  }

  // *** services const data list ***
  Widget _getServicesWidget(List<Services>? services){
    if(services != null){
      return Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12
          ),
          child: Container(
            height: AppSize.s140,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: services.map((service) =>
                  Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary,
                            width: AppSize.s1
                        )
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit:BoxFit.cover,
                            height: AppSize.s100,
                            width: AppSize.s100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
            ),
          ),
      );
    }else{
      return Container();
    }
  }

  // *** stream stores ***
  Widget _getStores(){
    return StreamBuilder<List<Stores>>(
        stream: _homeViewModel.outputStores,
        builder: (context , snapshot){
          return _getStoresWidget(snapshot.data);
        }
    );
  }

  // *** stores data lis ***
  Widget _getStoresWidget(List<Stores>? stores){
    if(stores != null){
      return Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12,
            top: AppPadding.p12
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              GridView.count(
                crossAxisCount: AppSize.s2,
                crossAxisSpacing: AppSize.s8,
                mainAxisSpacing: AppSize.s8,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children:
                  List.generate(
                      stores.length,
                      (index) {
                        return InkWell(
                          onTap: (){
                            // navigator to stores details
                            Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                          },
                          child: Card(
                            elevation: AppSize.s4,
                            child: Image.network(stores[index].image , fit: BoxFit.cover, ),
                          ),
                        );
                      }
                  ),
              ),
            ],
          ),
      );
    }else{
      return Container();
    }
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
