import 'package:dapp/constants/routes.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/utils/margins.dart';
import 'package:dapp/utils/navigation.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:dapp/views/widgets/button_style.dart';
import 'package:dapp/views/widgets/custom_button.dart';
import 'package:dapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowMnemonics extends StatefulWidget {
  const ShowMnemonics({Key? key}) : super(key: key);

  @override
  State<ShowMnemonics> createState() => _ShowMnemonicsState();
}

class _ShowMnemonicsState extends State<ShowMnemonics> {
  final _navService = locator<NavigationHandler>();
  @override
  Widget build(BuildContext context) {
    final walletModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  "Mnemonics",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                CustomText(
                  "Please take your time to write down these mnemonic keys in the order the appear. \n Also remember that you have to keep them secret. \n if you lose them, you lose your account and all that is in it.",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            verticalSpaceLarge,
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: CustomText(
                  walletModel.mnemonicString,
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            verticalSpaceLarge,
            CustomButton(
              onPressed: () =>
                  {_navService.pushNamed(Routes.MNEMONICKEYSELECTIONROUTE)},
              textColor: Colors.white,
              buttonText: "Next",
              buttonStyle: buttonStyle(
                buttonWidth: 150,
                color: Colors.black,
                // buttonHeight: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
