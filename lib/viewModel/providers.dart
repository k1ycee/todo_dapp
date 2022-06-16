import 'package:dapp/backend/wallet.dart';
import 'package:dapp/viewModel/cubit/wallet_cubit.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(
      create: (_) => WalletViewModel(WalletCreationConcrete())),
  BlocProvider(create: (_) => WalletCubit(WalletCreationConcrete()))
];
