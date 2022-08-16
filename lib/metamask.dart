import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/ethereum.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 4;

  String currentAddress = '';

  var account = "";

  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      // debugPrint("***********************************");
      // debugPrint(accs[0]);
      // debugPrint("***********************************");
      account = accs[0];

      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
