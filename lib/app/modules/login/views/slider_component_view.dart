import 'package:bca/app/modules/login/controllers/login_controller.dart';
import 'package:bca/constants/assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class SliderComponentView extends GetView<LoginController> {
  const SliderComponentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      Assets.banner1,
      Assets.banner2,
      Assets.banner3,
      Assets.biometric,
      Assets.investasi,
    ];
    return Obx(() {
      return Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: controller.index.value,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(microseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) => controller.onChange(index),
              scrollDirection: Axis.horizontal,
            ),
            items: imgList
                .map(
                  (item) => Center(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ).gestures(
                    onTap: () async {
                      const url = 'https://www.bca.co.id/id';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.onChange(entry),
                child: Container(
                  width: 10,
                  height: 8,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.index.value == entry.key
                        ? Colors.blue
                        : Colors.white,
                  ),
                ),
              );
            }).toList(),
          ).padding(top: 140),
        ],
      );
    });
  }
}
