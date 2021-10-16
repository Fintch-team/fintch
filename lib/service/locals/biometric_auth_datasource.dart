import 'package:fintch/gen_export.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService extends Service {
  static final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      throw FailedException("Biometric Auth Failed", 422);
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      throw FailedException("Biometric Auth Failed", 422);
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      bool rs = await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      print(rs);
      return rs;
    } catch (e) {
      throw FailedException("Biometric Auth Failed", 422);
    }
  }
}
