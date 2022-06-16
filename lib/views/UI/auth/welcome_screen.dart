import 'package:dapp/constants/routes.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/utils/margins.dart';
import 'package:dapp/utils/navigation.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:dapp/views/widgets/button_style.dart';
import 'package:dapp/views/widgets/custom_button.dart';
import 'package:dapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navService = locator<NavigationHandler>();
  var passwordBox = Hive.box('passwordBox');
  var privateKeyBox = Hive.box('privateKeyBox');
  @override
  Widget build(BuildContext context) {
    final walletModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpaceLarge,
              CustomText(
                "To-Don't",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              verticalSpaceSmall,
              CustomText(
                "This is a Proof of Concept To-do dApp \n So you're most welcome to my experiment \n I hope you enjoy the experiment",
                color: Colors.black,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMassive,
              CustomButton(
                buttonText: "Get Started",
                buttonStyle: buttonStyle(color: Colors.black, buttonWidth: 150),
                onPressed: () {
                  if (passwordBox.isNotEmpty) {
                    walletModel.createWallet(
                        password: passwordBox.get("password"),
                        seed: privateKeyBox.get("seed"));
                    walletModel.getWalletBalance(privateKeyBox.get("seed"));
                    walletModel.retrieveSeed();
                    _navService.pushNamed(Routes.TODOROUTE);
                  } else {
                    walletModel.generateMnemonic();
                    _navService.pushNamed(Routes.SHOWMNEMONICS);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
