import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrinter extends StatefulWidget {
  FingerPrinter({Key? key}) : super(key: key);

  @override
  State<FingerPrinter> createState() => _FingerPrinterState();
}

class _FingerPrinterState extends State<FingerPrinter> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _localAuthentication.canCheckBiometrics;
      return isAvailable;
    } catch (e) {
      return false;
    }
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
        print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
            localizedReason: 'Use a biometria para efetuar o login.',
            useErrorDialogs: true,
            stickyAuth: true);
    if (isAuthenticated) {
      print('deu certo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
