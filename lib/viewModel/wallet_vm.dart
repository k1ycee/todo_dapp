import 'package:dapp/backend/wallet.dart';
import 'package:dapp/utils/list_shuffle.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WalletViewModel extends ChangeNotifier {
  final WalletCreationConcrete walletCreationConcrete;
  WalletViewModel(this.walletCreationConcrete);

  List<String> _mnemonics = [];
  List<String> get mnemonics => _mnemonics;

  String _mnemonicString = "";
  String get mnemonicString => _mnemonicString;

  String _seed = "";
  String get seed => _seed;

  String _walletBalance = "";
  String get walletBalance => _walletBalance;

  String _walletAddress = "";
  String get walletAddress => _walletAddress;

  var passwordBox = Hive.box('passwordBox');
  var privateKeyBox = Hive.box('privateKeyBox');

  void generateMnemonic() {
    final mnemonicKeys = walletCreationConcrete.generateMnemonicKeys();
    _mnemonicString = mnemonicKeys;
    final shuffledMnemonicKeys = shuffle(mnemonicKeys.split(" "));
    _mnemonics = shuffledMnemonicKeys!;
    notifyListeners();
  }

  void generatePrivateKey(String mnemonic) async {
    final privateKeySeed = await walletCreationConcrete.getPrivateKey(mnemonic);
    _seed = privateKeySeed;
    privateKeyBox.put('seed', seed);
    notifyListeners();
  }

  void retrieveSeed() {
    _seed = privateKeyBox.get("seed");
    notifyListeners();
  }

  void createWallet({String? password, String? seed}) {
    passwordBox.put('password', password);
    final wallet =
        walletCreationConcrete.createEthWallet(password: password, seed: seed);
    _walletAddress = wallet.privateKey.address.toString();
    notifyListeners();
  }

  void getWalletBalance(String seed) async {
    final balance = await walletCreationConcrete.walletBalance(seed);
    _walletBalance = balance.toString();
    notifyListeners();
  }
}
