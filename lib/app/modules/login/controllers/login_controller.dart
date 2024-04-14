import 'package:bca/app/routes/app_pages.dart';
import 'package:bca/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nfc_manager/nfc_manager.dart';

class LoginController extends GetxController {
  ValueNotifier<dynamic> nfcResult = ValueNotifier(null);

  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  final RxString _authorized = 'Not Authorized'.obs;
  final RxBool _isAuthenticating = false.obs;
  final RxBool authenticated = false.obs;

  //TODO: Implement LoginController
  final isLoading = false.obs;
  final canSubmit = false.obs;
  final lang = 'en'.obs;

  final passwordText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final index = 0.obs;

  Map<String, Map<String, String>> translate = {
    'en': {
      'hello': 'HELLO',
      'login': 'Login',
      'login_desc': 'Login in with another account',
      'about': 'About myBCA',
      'cc': 'Credit Card Application',
      'country': 'EN',
      'icon': Assets.en
    },
    'id': {
      'hello': 'HALO',
      'login': 'Masuk',
      'login_desc': 'Masuk menggunakan akun lain',
      'about': 'Tentang myBCA',
      'cc': 'Pengajuan Kartu Kredit',
      'country': 'ID',
      'icon': Assets.id
    },
  };

  List<NavCard> listBottomNav = [
    NavCard(Assets.telephone, "Halo BCA 1500888",
        'https://www.bca.co.id/id/Individu/layanan/Customer-Service/HaloBCA'),
    NavCard(Assets.creditCard, 'Credit Card Application',
        'https://webform.bca.co.id/applycc/#/'),
    NavCard(Assets.whatsapp, "WhatsApp BCA", 'https://wa.me/628111500998'),
    NavCard(Assets.web, "Website bca.co.id", 'https://www.bca.co.id/en'),
    NavCard(Assets.letter, "Pengajuan KPR", 'https://www.bca.co.id/en'),
    NavCard(Assets.car, "KKB BCA Virtual Mall", 'https://www.bca.co.id/en'),
    NavCard(Assets.upArrow, "BCA Sekuritas", 'https://www.bca.co.id/en'),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChange(i) {
    index.value = i;
  }

  Future<void> onTapFaceId() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      print(canCheckBiometrics);
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    _canCheckBiometrics = canCheckBiometrics;
  }

  Future<void> authenticate() async {
    try {
      authenticated.value = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      _isAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating.value = false;
      _authorized.value = 'Error - ${e.message}';
      return;
    }
    if (authenticated.value) {
      print(authenticated.value);
      Get.toNamed(Routes.HOME);
    }
    _authorized.value = authenticated.value ? 'Authorized' : 'Not Authorized';
    print(_authorized.value);
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      authenticated.value = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      _isAuthenticating.value = false;
      _authorized.value = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating.value = false;
      _authorized.value = 'Error - ${e.message}';
      return;
    }
    _authorized.value = authenticated.value ? 'Authorized' : 'Not Authorized';
  }

  void validatePassword() =>
      canSubmit.value = formKey.currentState?.validate() ?? false;

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    _isAuthenticating.value = false;
  }

  Future<void> onTapLogin() async {
    Get.toNamed(Routes.HOME);
  }

  Future<void> onTapLang() async {
    lang.value = lang.value == 'en' ? 'id' : 'en';
  }

  Future<void> onTapFlazz() async {
    print('object');
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      nfcResult.value = tag.data;
      NfcManager.instance.stopSession();
      print(tag);
    });
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      nfcResult.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        nfcResult.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: nfcResult.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        NdefRecord.createMime(
            'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        NdefRecord.createExternal(
            'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        nfcResult.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        nfcResult.value = e;
        NfcManager.instance
            .stopSession(errorMessage: nfcResult.value.toString());
        return;
      }
    });
  }

  void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        nfcResult.value = 'Tag is not ndef';
        NfcManager.instance
            .stopSession(errorMessage: nfcResult.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        nfcResult.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        nfcResult.value = e;
        NfcManager.instance
            .stopSession(errorMessage: nfcResult.value.toString());
        return;
      }
    });
  }
}

// for clas Navigator
class NavCard {
  const NavCard(this.icon, this.text, this.link);

  final String icon;
  final String text;
  final String link;
}
