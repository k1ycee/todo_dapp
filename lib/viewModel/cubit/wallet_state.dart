

part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}


class GenerateMnemonic extends WalletState {
  final List<String> mnemonics;

  GenerateMnemonic(this.mnemonics);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GenerateMnemonic &&
      listEquals(other.mnemonics, mnemonics);
  }

  @override
  int get hashCode => mnemonics.hashCode;
}
