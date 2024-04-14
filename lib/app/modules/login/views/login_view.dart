import 'package:bca/app/modules/login/views/slider_component_view.dart';
import 'package:bca/app/modules/utils/default_submit_button.dart';
import 'package:bca/app/modules/utils/password_field.dart';
import 'package:bca/constants/assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  static final Color white = Colors.white;
  static final Color blue900 = Colors.blue[900]!;
  static final Color blue200 = Colors.blue[200]!;
  static final Color blue700 = Colors.blue[700]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SliderComponentView(),
          Padding(
            padding: EdgeInsets.only(top: 160),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Obx(() {
                return body();
              }).paddingAll(16),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget body() {
    final translate = controller.translate;
    final lang = controller.lang;
    final tr = translate[lang]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr['hello'].toString(),
              style: TextStyle(color: blue900),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: [
                Image.asset(
                  tr['icon'].toString(),
                  width: 30,
                ),
                Text(
                  tr['country'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ).padding(left: 3),
              ].toRow().padding(vertical: 3, horizontal: 5),
            ).padding(right: 5).gestures(onTap: () => controller.onTapLang()),
          ],
        ),
        Text(
          'ERMAN SIBARANI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blue900,
          ),
        ),
        Text('ER****S'),
        Form(
          key: controller.formKey,
          child: PasswordFormField(
            labelText: 'Password',
            hint: 'Password',
            controller: controller.passwordText,
            minLength: 6,
            onChanged: (_) => controller.validatePassword(),
          ).padding(vertical: 20),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Reset Password",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ).padding(bottom: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return DefaultSubmitButton(
                btnColor: controller.canSubmit.value ? blue900 : null,
                isOutlineButton: true,
                noPadding: true,
                width: 300,
                label: tr['login'].toString(),
                isLoading: controller.isLoading.isTrue,
                onTap: controller.canSubmit.value
                    ? () => controller.onTapLogin()
                    : null,
              );
            }),
            Spacer(),
            InkWell(
              onTap: () => controller.authenticate(),
              focusColor: blue200,
              splashColor: blue200,
              hoverColor: blue200,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: blue900,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  Assets.faceId,
                  width: 25,
                  color: blue900,
                ).padding(all: 10),
              ).ripple(),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            tr['login_desc'].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: blue900,
            ),
          ),
        ).padding(top: 20, vertical: 50),
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: [
              [
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        color: blue700,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Image.asset(
                      Assets.flazz,
                      width: 30,
                    ).padding(vertical: 13, horizontal: 7),
                  ).center(),
                ),
                Text(
                  'Flazz',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: blue900, fontWeight: FontWeight.bold),
                ).padding(top: 3),
              ].toColumn(),
              [
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        color: blue700,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                    child: Image.asset(
                      Assets.qris2,
                      width: 25,
                    ).padding(all: 10),
                  ).center(),
                ),
                Text(
                  'QRIS',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: blue900, fontWeight: FontWeight.bold),
                ).padding(top: 3),
              ].toColumn(),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
                .padding(vertical: 12),
          ),
        ),
        Spacer(),
        Center(
          child: InkWell(
            onTap: () => controller.authenticated(),
            borderRadius: BorderRadius.circular(16),
            child: Text(
              tr['about'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ).padding(vertical: 8, horizontal: 16).ripple(),
          ).ripple().backgroundColor(Colors.grey.shade100).clipRRect(all: 16),
        ).padding(bottom: 20),
      ],
    );
  }

  Widget bottomNav() {
    final List<NavCard> lists = controller.listBottomNav;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lists.length,
      itemBuilder: (context, index) {
        final currItem = lists[index];
        return SizedBox(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            width: 120,
            child: [
              Image.asset(
                currItem.icon,
                width: 25,
                color: blue900,
              ),
              Text(
                currItem.text,
                style: TextStyle(
                  color: blue900,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ).flexible(),
            ]
                .toRow()
                .padding(vertical: 4, horizontal: 8)
                .ripple()
                .clipRRect(all: 8)
                .gestures(
              onTap: () async {
                final url = currItem.link;
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url,
                      mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ),
        ).padding(left: 20);
      },
    ).height(50).padding(bottom: 40);
  }
}
