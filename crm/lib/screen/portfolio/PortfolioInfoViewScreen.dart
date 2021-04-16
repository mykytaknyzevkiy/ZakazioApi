import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';
import 'package:zakazy_crm_v2/screen/RightScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class PortfolioInfoViewScreen extends RightScreen {
  final PortfolioModel portfolioModel;
  final UserProfileViewModel _viewModel;

  final scrollController = ScrollController();

  PortfolioInfoViewScreen(this.portfolioModel, this._viewModel);

  @override
  Widget body(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(portfolioModel.label,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
      Divider(
        color: Colors.transparent,
        height: 40,
      ),
      Expanded(
        child: Scrollbar(
          controller: scrollController,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(fileUrl(portfolioModel.wallpaper), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
                    width: width(context) - 50,
                    height: ((width(context) - 50) / 2)
                ),
                Divider(
                    height: 15,
                    color: Colors.transparent
                ),
                SizedBox(
                  width: width(context) - 50,
                  child: Text(portfolioModel.description),
                ),
                Divider(
                    height: 15,
                    color: Colors.transparent
                ),
                MediaQuery.of(context).size.width > phoneSize
                    ? imageSliderDesktop(context)
                    : imageSliderMobile(context),
              ],
            ),
          ),
        )
      ),
      Divider(
          height: 15,
          color: Colors.transparent
      ),
      MyButton(
          title: "Закрыть",
          onPressed: () => _viewModel.toEditData.add(null),
          isEnable: true
      )
    ],
  );

  imageSliderMobile(BuildContext context) => CarouselSlider(
    options: CarouselOptions(
      height: width(context) / 2,
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: false,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    ),
    items: portfolioModel.imageSlides.map((String i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image(
                width: double.infinity,
                height: double.infinity,
                image: CachedNetworkImageProvider(fileUrl(i), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
                fit: BoxFit.cover,
              )
          );
        },
      );
    }).toList(),
  );

  imageSliderDesktop(BuildContext context) => Column(
    children: List.generate(portfolioModel.imageSlides.length, (index) => Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Image(
          width: (width(context) - 50),
          height: ((width(context) - 50) / 2),
          image: CachedNetworkImageProvider(fileUrl(portfolioModel.imageSlides[index]), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
          fit: BoxFit.cover,
        )
    )),
  );

  @override
  double width(BuildContext context) => MediaQuery.of(context).size.width > phoneSize
      ? 550
      : 350;

}