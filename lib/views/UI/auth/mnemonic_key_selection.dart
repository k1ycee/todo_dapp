import 'package:dapp/constants/routes.dart';
import 'package:dapp/utils/margins.dart';
import 'package:dapp/utils/navigation.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:dapp/views/widgets/button_style.dart';
import 'package:dapp/views/widgets/custom_button.dart';
import 'package:dapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class MnemonicKeySelection extends StatefulWidget {
  const MnemonicKeySelection({Key? key}) : super(key: key);

  @override
  State<MnemonicKeySelection> createState() => _MnemonicKeySelectionState();
}

class _MnemonicKeySelectionState extends State<MnemonicKeySelection> {
  final _navService = locator<NavigationHandler>();
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final walletModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  "Input Mnemonic keys",
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                CustomText(
                  "Please Tap on the mnemonic keys in the order they appeared in the previous screen \n",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  "Note: If you mess with the order you get a proper address but you have to know the order you filled in",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Container(
            height: 350,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: walletModel.mnemonics.length,
              itemBuilder: (context, index) {
                return MnemonicCard(
                  mnemonicKey: walletModel.mnemonics[index],
                );
              },
            ),
          ),
          verticalSpaceMedium,
          CustomButton(
            onPressed: () {
              walletModel.generatePrivateKey(getMnemonics());
              // creationModel.createEthereumWallet(),
              // creationModel.getWalletInformation()
              _navService.pushNamed(Routes.PASSWORDROUTE);
            },
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
    );
  }
}

class MnemonicCard extends StatefulWidget {
  final String? mnemonicKey;
  const MnemonicCard({Key? key, this.mnemonicKey}) : super(key: key);

  @override
  _MnemonicCardState createState() => _MnemonicCardState();
}

List<String> mnemonic = [];

class _MnemonicCardState extends State<MnemonicCard> {
  bool isSelected = false;

  @override
  void dispose() {
    mnemonic.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final walletModel = Provider.of<WalletViewModel>(context);
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        mnemonicSelected("${widget.mnemonicKey} ");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          width: 214,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey,
            ),
            color: isSelected ? Colors.black : Colors.transparent,
          ),
          child: Center(
            child: CustomText(
              widget.mnemonicKey,
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  mnemonicSelected(String value) {
    mnemonic.add(value);
  }
}

String getMnemonics() {
  return mnemonic.join();
}
