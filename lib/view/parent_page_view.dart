import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/view/home_view.dart';

class ParentPageView extends StatefulWidget {
  const ParentPageView({super.key});

  @override
  State<ParentPageView> createState() => _ParentPageViewState();
}

class _ParentPageViewState extends State<ParentPageView> {
  int selectedTab = 0;

  late PageController _pageController;

  List<Widget> tabPages = [
    const HomeView(),
    Container(),
    Container(),
    Container(),
    Container()
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    _pageController = PageController(initialPage: selectedTab);
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
        children: tabPages,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF1F1F1F),
          selectedItemColor: const Color(0xFFD7FC70),
          unselectedItemColor: const Color(0xFF737373),
          currentIndex: selectedTab,
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
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    // PageView onPageChanged
    setState(() {
      selectedTab = page;
    });
  }

  void onTabTapped(int index) {
    // BottomNavigatonBar OnTap
    _pageController.jumpToPage(index);
  }
}
