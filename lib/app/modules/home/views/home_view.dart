import 'package:bca/app/routes/app_pages.dart';
import 'package:bca/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static final blue800 = Colors.blue.shade800;
  static final blue900 = Colors.blue.shade900;
  static final lightBlue300 = Colors.lightBlue.shade300;
  static final lightBlue400 = Colors.lightBlue.shade400;
  static final lightBlue50 = Colors.lightBlue.shade50;
  static final greyShade300 = Colors.grey.shade300;
  static final white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: body(),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget body() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0],
            colors: [blue800, white],
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: bodyCard().padding(all: 16),
              ),
              payerLists(controller.payerIcon).padding(top: 400),
              favoriteTransaction(controller.favoriteTransaction)
                  .padding(top: 600),
              currencyCard().padding(top: 1000),
            ],
          ),
        ));
  }

  Widget currencyCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'KURS MATA UANG',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Spacer(),
              Text(
                'Selengkapnya',
                style: TextStyle(color: blue900),
              ).padding(right: 16),
            ],
          ).padding( bottom: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mata Uang",
                      style: TextStyle(
                        color: blue900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Beli",
                      style: TextStyle(
                        color: blue900,
                      ),
                    ).padding(right: 50),
                    Text(
                      "Jual",
                      style: TextStyle(
                        color: blue900,
                      ),
                    )
                  ],
                ),
                rowItem("USD", "15.000", "16.000"),
                rowItem("SGD", "11.000", "12.000"),
                rowItem("CNY", "2.000", "3.000"),
                rowItem("CNY", "17.000", "18.000")
              ],
            ).padding(all: 16),
          )
        ],
      ).padding(all: 16),
    ).boxShadow(color: greyShade300, spreadRadius: -2, blurRadius: 10);
  }

  Widget rowItem(String currency, String buy, String sell) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currency,
          style: TextStyle(
            color: blue900,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          buy,
          style: TextStyle(color: blue900),
        ),
        Text(
          sell,
          style: TextStyle(color: blue900),
        ),
      ],
    );
  }

  Widget favoriteTransaction(List<Transaction> lists) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Transaksi Favorit',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Spacer(),
              Text(
                'Selengkapnya',
                style: TextStyle(color: blue900),
              ).padding(right: 16),
            ],
          ).padding(top: 16, left: 16),
          GridView.count(
            physics: const ClampingScrollPhysics(),
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 1,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              for (var i = 0; i < lists.length; i++) ...[
                transactionItem(lists[i].method, lists[i].name),
              ]
            ],
          ).height(400)
        ],
      ),
    )
        .height(500)
        .boxShadow(color: greyShade300, spreadRadius: -2, blurRadius: 10);
  }

  Widget transactionItem(String method, String name) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                method,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blue800,
                ),
              ).width(130),
              Text(
                name,
                style: TextStyle(
                  color: blue800,
                ),
              ).padding(top: 5),
            ],
          ).padding(all: 20),
          Image.asset(
            Assets.transfer,
            width: 30,
            height: 30,
            color: Colors.blue.withOpacity(0.3),
          ).positioned(right: 10, top: 10)
        ],
      ),
    );
  }

  Widget payerLists(List<AssetIcon> lists) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'BAYAR & ISI ULANG',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Spacer(),
              Text(
                'Selengkapnya',
                style: TextStyle(color: blue900),
              ).padding(right: 16),
            ],
          ).padding(top: 16, left: 16),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lists.length,
            itemBuilder: (context, index) {
              final currItem = lists[index];
              return payerItem(
                icon: currItem.icon,
                size: 50,
                text: currItem.name,
              ).padding(horizontal: 5);
            },
          ).height(130),
        ],
      ),
    )
        .height(250)
        .boxShadow(color: greyShade300, spreadRadius: -3, blurRadius: 10);
  }

  Widget payerItem(
      {required String icon, required double size, required String text}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: lightBlue50,
            borderRadius: BorderRadius.circular(10),
          ),
        ).rotate(angle: 14.95),
        Image.asset(
          icon,
          width: size / 2,
          color: blue900,
        ),
        Text(
          text,
          style: TextStyle(color: blue900),
          textAlign: TextAlign.center,
        ).width(100).padding(top: 100)
      ],
    );
  }

  Widget bodyCard() {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("HALO", style: TextStyle(color: blue900)),
          Text(
            "ERMAN SIBARANI",
            style: TextStyle(
              color: blue800,
              fontWeight: FontWeight.bold,
            ),
          ).padding(top: 10, bottom: 15),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        [
                          Text(
                            'Rekening: ',
                            style: TextStyle(
                              color: lightBlue400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '820 - 528 - 3052 ',
                            style: TextStyle(
                              color: lightBlue400,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.lIconlyArrowRight2,
                            width: 15,
                            height: 15,
                            color: lightBlue300,
                          ),
                        ].toRow().padding(bottom: 16),
                        [
                          Text(
                            'IDR',
                            style: TextStyle(fontSize: 16),
                          ).padding(right: 5),
                          Obx(() {
                            final amount = controller.amountShow.value
                                ? '10.000.000'
                                : '*******';
                            return Text(
                              amount,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ].toRow(),
                      ],
                    ),
                    Obx(() {
                      return SvgPicture.asset(
                        controller.amountShow.value
                            ? Assets.bIconlyShow
                            : Assets.bIconlyHide,
                      );
                    }).gestures(
                      onTap: () => controller.amountShow.toggle(),
                    ),
                  ],
                ).padding(vertical: 15, horizontal: 20),
              ],
            ),
          )
              .boxShadow(
                color: greyShade300,
                spreadRadius: -2,
                blurRadius: 10,
              )
              .padding(bottom: 20),
          [
            iconLists(controller.listIcon1),
            SizedBox(height: 40),
            iconLists(controller.listIcon2),
          ].toColumn()
        ],
      ).padding(top: 10),
    );
  }

  Widget iconLists(List<AssetIcon> lists) {
    return List.generate(lists.length, (index) {
      final currItem = lists[index];
      return [
        Image.asset(
          currItem.icon,
          width: 35,
        ).padding(bottom: 10),
        Text(
          currItem.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blue900,
          ),
        ).flexible(),
      ]
          .toColumn(mainAxisAlignment: MainAxisAlignment.center)
          .padding(vertical: 4, horizontal: 8);
    }).toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).height(70);
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: blue800,
      elevation: 0,
      leadingWidth: 100,
      leading: SvgPicture.asset(Assets.mybca, color: white, width: 30)
          .padding(left: 16),
      actions: [
        SvgPicture.asset(Assets.lIconlySetting, color: white),
        SvgPicture.asset(Assets.lIconlyLogout, color: white)
            .ripple()
            .gestures(onTap: () => Get.toNamed(Routes.LOGIN))
            .padding(horizontal: 16),
      ],
    );
  }

  Widget bottomNav() {
    return Stack(
      fit: StackFit.expand,
      children: [
        [
          svgIcon(Assets.bank, "Beranda"),
          imageIcon(Assets.history, "Riwayat"),
          SizedBox(width: 50),
          svgIcon(Assets.bIconlyNotification, "Notifikasi"),
          imageIcon(Assets.account, "Akun Saya"),
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .padding(top: 10, horizontal: 20)
            .backgroundLinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [blue800, blue900],
            )
            .height(80)
            .clipRRect(topRight: 16, topLeft: 16)
            .padding(top: 30),
        qrisIcon(),
      ],
    ).height(110);
  }

  Widget qrisIcon() {
    final double size = 50;
    return [
      Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: lightBlue300,
              borderRadius: BorderRadius.circular(20),
            ),
          ).rotate(angle: 14.95).center(),
          Image.asset(
            Assets.qris2,
            width: size / 2,
            color: white,
          ).center().padding(top: 12),
        ],
      ),
      Image.asset(
        Assets.qris,
        width: 40,
        color: white,
      ).center().padding(top: 10)
    ].toColumn();
  }

  Widget svgIcon(String icon, String name) {
    return [
      SvgPicture.asset(
        icon,
        width: 25,
        color: white,
      ).padding(bottom: 5),
      Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontSize: 10,
        ),
      ).flexible(),
    ].toColumn();
  }

  Widget imageIcon(String icon, String name) {
    return [
      Image.asset(
        icon,
        width: 25,
        color: white,
      ).padding(bottom: 5),
      Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: white,
          fontSize: 10,
        ),
      ).flexible(),
    ].toColumn();
  }
}
