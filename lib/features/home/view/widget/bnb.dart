import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/home_bloc.dart';
import 'package:data_caching/features/home/view/bloc/home_blocs/product_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { home, favorite, add, search, person }

class BNB extends StatefulWidget {
  const BNB({
    super.key,
  });

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<HomeBloc>().state.homeProductStatus
            is HomeProductStatusError
        ? Container() 
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CrystalNavigationBar(
              currentIndex: _SelectedTab.values.indexOf(_selectedTab),
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.black.withAlpha(25),
              borderRadius: 25,
              onTap: _handleIndexChanged,
              items: [
                /// Home
                CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  unselectedIcon: IconlyLight.home,
                  selectedColor: Colors.white,
                ),

                /// Favorite
                CrystalNavigationBarItem(
                  icon: IconlyBold.heart,
                  unselectedIcon: IconlyLight.heart,
                  selectedColor: Colors.red,
                ),

                /// Add
                CrystalNavigationBarItem(
                  icon: IconlyBold.plus,
                  unselectedIcon: IconlyLight.plus,
                  selectedColor: Colors.white,
                ),

                /// Search
                CrystalNavigationBarItem(
                    icon: IconlyBold.search,
                    unselectedIcon: IconlyLight.search,
                    selectedColor: Colors.white),

                /// Profile
                CrystalNavigationBarItem(
                  icon: IconlyBold.user_2,
                  unselectedIcon: IconlyLight.user,
                  selectedColor: Colors.white,
                ),
              ],
            ),
          );
  }
}
