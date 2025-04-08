import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/widget/category_card_widget.dart';
import 'package:flutter_ui/widget/product_card_widget.dart';
import 'package:flutter_ui/model/product_model.dart';
import 'package:flutter_ui/view/unavailable_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Color selectedColor = const Color(0xFFD7FC70); // CATEGORY COLORS
  Color unselectedColor = const Color(0xFF2B2B2B);
  final categories = ["Newest", "Accessories", "Hoodie", "Dresses"];
  int selectedTab = 0;
  int activeIndex = 0; // SLIDER INDEX

  final sliderImages = [
    // SLIDER IMAGE LIST
    const Image(
      image: AssetImage("assets/image/slider_image.png"),
      fit: BoxFit.fill,
    ),
    const Image(
      image: AssetImage("assets/image/slider_image.png"),
      fit: BoxFit.fill,
    ),
    const Image(
      image: AssetImage("assets/image/slider_image.png"),
      fit: BoxFit.fill,
    ),
    const Image(
      image: AssetImage("assets/image/slider_image.png"),
      fit: BoxFit.fill,
    )
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]); // REMOVE ANDROID STATUS BAR
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Column(
        children: [
          Expanded(
              flex: 7,
              child: Container(
                // APP BAR
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("assets/icon/filter_icon.png"),
                          color: Colors.white,
                          size: 22,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("assets/icon/search_icon.png"),
                          color: Colors.white,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("assets/icon/bag_icon.png"),
                          color: Colors.white,
                          size: 20,
                        )),
                  ],
                ),
              )),
          Container(
            //SLIDER CONTAINER
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.33,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFD7FC70), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.33,
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  alignment: Alignment.bottomCenter,
                  child: CarouselSlider.builder(
                    itemCount: sliderImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final sliderImage = sliderImages[index];
                      return buildImage(sliderImage, index);
                    },
                    options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                        autoPlay: true,
                        padEnds: false,
                        viewportFraction: 1.6,
                        aspectRatio:
                            2.7 // slider_image ASPECT RATIO (370x138) : 2.7

                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.8, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [sliderIndicator()],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: CategoryCardWidget(
                        isSelected: selectedTab == index,
                        title: categories[index],
                      ),
                    );
                  },
                ), // CATEGORIES
              )),
          Expanded(
              flex: 35,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCardWidget(
                    product: products[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnavailableView(),
                      ),
                    ),
                    favouriteOnTap: () {
                      setState(() {
                        if (favouriteList.contains(products[index].id)) {
                          favouriteList.remove(products[index].id);
                        } else {
                          favouriteList.add(products[index].id);
                        }
                      });
                    },
                    favouriteColor: favouriteList.contains(products[index].id)
                        ? Colors.black
                        : Colors.black26,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget sliderIndicator() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: AnimatedSmoothIndicator(
          effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              spacing: 12,
              dotWidth: 6,
              dotHeight: 6,
              activeDotColor: Color(0xFFD7FC70),
              dotColor: Color(0xFF626262)),
          activeIndex: activeIndex,
          count: 4,
        ),
      );

  Widget buildImage(Image sliderImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: sliderImage,
      );

  double resWidthSize(BuildContext context) {
    // WIDTH and HEIGHT SIZE FOR RESPONSIVE SIZE
    double widthSize;
    if (MediaQuery.of(context).size.width > 424) {
      widthSize = MediaQuery.of(context).size.width * 0.0092;
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
