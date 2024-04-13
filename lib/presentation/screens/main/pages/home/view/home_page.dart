import 'package:advanced_flutter/app/di.dart';
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
    return const Center(
      child: Text(
        AppStrings.home
      ),
    );
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
