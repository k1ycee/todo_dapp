import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:web3dart/credentials.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:web3dart/web3dart.dart';
import "package:hex/hex.dart";

abstract class WalletCreationAbs {
  String generateMnemonicKeys();
  Future<String> getPrivateKey(String mnemonic);
  Wallet createEthWallet({String seed, String password});
  Future walletBalance(String seed);
}

class WalletCreationConcrete implements WalletCreationAbs {
  late Client httpClient;
  late Web3Client ethClient;

  WalletCreationConcrete() {
    httpClient = Client();
    ethClient = Web3Client(dotenv.env["ALCHEMY_API"]!, httpClient);
  }
  
  @override
  Wallet createEthWallet({String? seed, String? password}) {
    return Wallet.createNew(
      EthPrivateKey.fromHex(seed!),
      password!,
      Random.secure(),
    );
  }

  @override
  String generateMnemonicKeys() {
    final mnemonic = bip39.generateMnemonic();
    return mnemonic;
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(HEX.decode(seed),
        masterSecret: dotenv.env["MASTER_SECRET"]!);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  Future walletBalance(String seed) async {
    var credentials = EthPrivateKey.fromHex(seed);
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    return balance.getValueInUnit(EtherUnit.ether);
  }
}
