import 'package:dapp/utils/exception_handler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractLink {
  late Client httpClient;
  late Web3Client ethClient;

  ContractLink() {
    httpClient = Client();
    ethClient = Web3Client(dotenv.env["ALCHEMY_API"]!, httpClient);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/todo_abi.json");
    // String finalAbi = jsonDecode(abi)["abi"].toString();
    String contractAddress = dotenv.env["CONTRACT_ADDRESS"]!;
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "SimpleTodoContract"),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

  Future<String> send(
      String functionName, List<dynamic> args, String privateKey) async {
    try {
      EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
      print(credential);
      DeployedContract contract = await loadContract();
      final ethFunction = contract.function(functionName);
      final result = ethClient.sendTransaction(
        credential,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 300000),
        chainId: 4,
      );
      return result;
    } catch (error) {
      throw CustomException(errorMessage: error.toString());
    }
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    try {
      final contract = await loadContract();
      final ethFunction = contract.function(functionName);
      final result = await ethClient.call(
          contract: contract, function: ethFunction, params: args);
      return result;
    } catch (error) {
      throw CustomException(errorMessage: error.toString());
    }
  }
}
