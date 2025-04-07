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
    double widthSize = resWidthSize(
        context); // WIDTH AND HEIGHT PARAMETERS FOR RESPONSIVE DESIGN
    double heightSize = resHeightSize(context);

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
          selectedFontSize: widthSize * heightSize * 0.25,
          unselectedFontSize: widthSize * heightSize * 0.25,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/navicon1.png"),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/navicon2.png"),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/navicon3.png"),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/navicon4.png"),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/navicon5.png"),
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

  double resWidthSize(BuildContext context) {
    double widthSize;
    if (MediaQuery.of(context).size.width > 598) {
      widthSize = MediaQuery.of(context).size.width * 0.0072;
    } else {
      widthSize = MediaQuery.of(context).size.width * 0.01;
    }
    return widthSize;
  }

  double resHeightSize(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height * 0.01;
    return heightSize;
  }
}
