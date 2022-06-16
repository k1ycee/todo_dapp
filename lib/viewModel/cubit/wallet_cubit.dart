import 'package:bloc/bloc.dart';
import 'package:dapp/backend/wallet.dart';
import 'package:dapp/utils/list_shuffle.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletCreationConcrete walletCreationConcrete;
  WalletCubit(this.walletCreationConcrete) : super(WalletInitial());


  void generateMnemonic(){
    final mnemonicKeys = walletCreationConcrete.generateMnemonicKeys();
    final shuffledMnemonicKeys = shuffle(mnemonicKeys.split(" "));
    emit(GenerateMnemonic(shuffledMnemonicKeys!));
  }

  
}
