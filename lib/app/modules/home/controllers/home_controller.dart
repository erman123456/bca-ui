import 'package:bca/constants/assets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List<AssetIcon> payerIcon = [
    AssetIcon(icon: Assets.creditCard, name: "Kartu Kredit & Paylater"),
    AssetIcon(icon: Assets.pln, name: "PLN"),
    AssetIcon(icon: Assets.pulsa, name: "Paket Data"),
    AssetIcon(icon: Assets.pulsa, name: "Pulsa"),
    AssetIcon(icon: Assets.pulsa, name: "Paska Bayar"),
    AssetIcon(icon: Assets.ellipsis, name: "Lainnya"),
  ];

  List<AssetIcon> listIcon1 = [
    AssetIcon(icon: Assets.transfer, name: "Transfer"),
    AssetIcon(icon: Assets.wallet, name: "Deposito"),
    AssetIcon(icon: Assets.welma, name: "Welma"),
    AssetIcon(icon: Assets.estatement, name: "E-statement"),
  ];

  List<AssetIcon> listIcon2 = [
    AssetIcon(icon: Assets.paylaterIcon, name: "Paylater"),
    AssetIcon(icon: Assets.flazz, name: "Flazz"),
    AssetIcon(icon: Assets.cardless, name: "Cardless"),
    AssetIcon(icon: Assets.ellipsis, name: "Lainnya"),
  ];

  List<Transaction> favoriteTransaction = [
    Transaction(method: "Transfer ke BCA Virtual Account", name: "GP-081268137084"),
    Transaction(method: "Transfer antar rekening BCA", name: "RIAN IREGHO"),
    Transaction(method: "Transfer antar rekening BCA", name: "ZIKRI AKMAL /S"),
    Transaction(method: "Transfer antar rekening BCA", name: "FELIX SERANG"),
    Transaction(method: "Transfer antar rekening BCA", name: "HENDRY TANAKA"),
    Transaction(method: "Transfer antar rekening BCA", name: "AULYA ARYANSYAH"),
  ];

  final count = 0.obs;
  final amountShow = false.obs;

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

  void increment() => count.value++;

  void onTapAmountShow() => amountShow.value = !amountShow.value;
}

class AssetIcon {
  const AssetIcon({required this.icon, required this.name});

  final String icon;
  final String name;
}

class Transaction {
  const Transaction({required this.method, required this.name});

  final String method;
  final String name;
}
