import 'package:dapp/constants/routes.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/utils/margins.dart';
import 'package:dapp/utils/navigation.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:dapp/views/widgets/button_style.dart';
import 'package:dapp/views/widgets/custom_button.dart';
import 'package:dapp/views/widgets/custom_text.dart';
import 'package:dapp/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController passwordController = TextEditingController();
  final _navService = locator<NavigationHandler>();
  @override
  Widget build(BuildContext context) {
    final walletModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CustomText(
                  "Secure Wallet",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                verticalSpaceSmall,
                CustomText(
                  "This app serves as a proper Ethereum wallet and a \n To-do app \n So this is a precaution to make sure that you're the one trying to access the app.",
                  textAlign: TextAlign.center,
                  fontSize: 12,
                ),
                verticalSpaceMedium,
                CustomTextField(
                  title: "Password",
                  obscure: true,
                  controller: passwordController,
                ),
                verticalSpaceLarge,
                CustomButton(
                  onPressed: () {
                    walletModel.createWallet(
                        password: passwordController.text,
                        seed: walletModel.seed);
                    walletModel.getWalletBalance(walletModel.seed);
                    _navService.pushNamed(Routes.TODOROUTE);
                  },
                  textColor: Colors.white,
                  buttonText: "Create Account",
                  buttonStyle: buttonStyle(
                    buttonWidth: 200,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
