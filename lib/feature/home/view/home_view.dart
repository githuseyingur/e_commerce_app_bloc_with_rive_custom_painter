import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/home/cubit/home_cubit.dart';
import 'package:flutter_ui/feature/home/cubit/home_state.dart';
import 'package:flutter_ui/feature/home/widget/slider_image_widget.dart';
import 'package:flutter_ui/feature/home/widget/slider_indicator.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/feature/home/widget/category_card_widget.dart';
import 'package:flutter_ui/feature/home/widget/product_card_widget.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:go_router/go_router.dart';

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
          SizedBox(
            height: 0.012.sh,
          ),
          Container(
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
          SizedBox(
            height: 0.012.sh,
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
                  width: 0.9.sw,
                  height: 0.33.sw,
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  alignment: Alignment.bottomCenter,
                  child: CarouselSlider.builder(
                    itemCount: sliderImages.length,
                    itemBuilder: (context, index, realIndex) {
                      return SliderImageWidget(
                        onTap: () {
                          context.push('/unavailable');
                        },
                        sliderImage: sliderImages[index],
                      );
                    },
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          context.read<HomeCubit>().setSliderIndex(index);
                        },
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
          Padding(
            padding: const EdgeInsets.only(left: 4.8, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return SliderIndicator(
                        activeSliderIndex: state.activeSliderIndex);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.024.sh,
          ),
          SizedBox(
            height: 0.04.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    productList.map((p) => p.category!).toSet().toList().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final categoryList =
                      productList.map((p) => p.category!).toSet().toList();
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
            ),
          ),
          Expanded(
              flex: 36,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return GridView.builder(
                      itemCount: state.filteredProductList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 0.5.sw,
                        mainAxisExtent: 0.34.sh,
                        crossAxisSpacing: 0.024.sw,
                        mainAxisSpacing: 0.024.sw,
                      ),
                      itemBuilder: (context, index) =>
                          BlocBuilder<RootPageCubit, RootPageState>(
                        builder: (context, rootState) {
                          return ProductCardWidget(
                            product: state.filteredProductList[index],
                            onTap: () {
                              context.push(
                                '/product_detail',
                                extra: {
                                  'productId':
                                      state.filteredProductList[index].id!,
                                  'cubit': context.read<RootPageCubit>()
                                },
                              );
                            },
                            favouriteOnTap: () {
                              context.read<RootPageCubit>().setFavourite(
                                  state.filteredProductList[index].id!);
                            },
                            favouriteColor: rootState.favouriteProducts
                                    .contains(
                                        state.filteredProductList[index].id!)
                                ? Colors.black
                                : Colors.black26,
                          );
                        },
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
