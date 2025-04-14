// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/feature/home/cubit/home_cubit.dart';
import 'package:flutter_ui/feature/home/view/home_view.dart';
import 'package:flutter_ui/feature/profile/view/profile_view.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';

class RootPageView extends StatefulWidget {
  const RootPageView({super.key});

  @override
  State<RootPageView> createState() => _RootPageViewState();
}

class _RootPageViewState extends State<RootPageView> {
  late PageController _pageController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);

    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: context.read<RootPageCubit>().tabPages,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BlocBuilder<RootPageCubit, RootPageState>(
          builder: (context, state) {
            return BottomNavigationBar(
              backgroundColor: const Color(0xFF1F1F1F),
              selectedItemColor: const Color(0xFFD7FC70),
              unselectedItemColor: const Color(0xFF737373),
              currentIndex: state.selectedPage,
              onTap: onTabTapped,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icon/navicon1.png"),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icon/navicon2.png"),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icon/navicon3.png"),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icon/navicon4.png"),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icon/navicon5.png"),
                    ),
                    label: ""),
              ],
            );
          },
        ),
      ),
    );
  }

  void onPageChanged(int pageIndex) {
    context.read<RootPageCubit>().setPageIndex(pageIndex);
  }

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }
}
