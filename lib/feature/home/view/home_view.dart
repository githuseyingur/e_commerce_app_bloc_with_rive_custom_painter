import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/feature/home/cubit/home_cubit.dart';
import 'package:flutter_ui/feature/home/cubit/home_state.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/widget/category_card_widget.dart';
import 'package:flutter_ui/widget/product_card_widget.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/feature/unavailable/view/unavailable_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      backgroundColor: ColorConstants.primaryBackground,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
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
                            color: ColorConstants.primaryGreen, width: 2),
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
                  itemCount: productList
                      .map((p) => p.category!.name!)
                      .toSet()
                      .toList()
                      .length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final categoryList = productList
                        .map((p) => p.category!.name!)
                        .toSet()
                        .toList();
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .setCategory(categoryList[index]);
                      },
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return CategoryCardWidget(
                            isSelected:
                                state.selectedCategory == categoryList[index],
                            title: categoryList[index],
                          );
                        },
                      ),
                    );
                  },
                ), // CATEGORIES
              )),
          Expanded(
              flex: 36,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return GridView.builder(
                      itemCount: state.filteredProductList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) => ProductCardWidget(
                        product: state.filteredProductList[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UnavailableView(),
                          ),
                        ),
                        favouriteOnTap: () {},
                        favouriteColor: Colors.black,
                      ),
                    );
                  },
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
            activeDotColor: ColorConstants.primaryGreen,
            dotColor: Colors.white54, //! BAK
          ),
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
