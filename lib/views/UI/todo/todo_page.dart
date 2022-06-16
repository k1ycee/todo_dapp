import 'package:dapp/backend/cotract_linkup.dart';
import 'package:dapp/utils/margins.dart';
import 'package:dapp/viewModel/wallet_vm.dart';
import 'package:dapp/views/widgets/button_style.dart';
import 'package:dapp/views/widgets/custom_button.dart';
import 'package:dapp/views/widgets/custom_text.dart';
import 'package:dapp/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/crypto.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var privateKeyBox = Hive.box('privateKeyBox');
  @override
  Widget build(BuildContext context) {
    final walletModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          verticalSpaceLarge,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // verticalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Address",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        CustomText(
                          walletModel.walletAddress,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Wallet Balance",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        CustomText(
                          "${walletModel.walletBalance} Eth",
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          verticalSpaceMedium,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                CustomTextField(
                  title: "Title",
                  controller: titleController,
                ),
                verticalSpaceSmall,
                CustomTextField(
                  title: "Description",
                  controller: descriptionController,
                ),
                verticalSpaceLarge,
                CustomButton(
                  onPressed: () {
                    ContractLink().send(
                        "createTodo",
                        [titleController.text, descriptionController.text],
                        walletModel.seed);
                    // walletModel.createWallet(
                    //     password: passwordController.text,
                    //     seed: walletModel.seed);
                    // walletModel.getWalletBalance(walletModel.seed);
                    // _navService.pushNamed(Routes.TODOROUTE);
                  },
                  textColor: Colors.white,
                  buttonText: "Create Todo",
                  buttonStyle: buttonStyle(
                    buttonWidth: 200,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
