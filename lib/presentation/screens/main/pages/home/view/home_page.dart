import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/home/home_viewModel/home_viewModel.dart';
import 'package:flutter/material.dart';

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

  // *** banners ***
  Widget _getBannersCarousel(){
    return Center();
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
