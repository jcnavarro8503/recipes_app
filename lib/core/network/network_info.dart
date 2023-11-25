import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get isOnLine;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    final connected = await Connectivity().checkConnectivity();
    return ConnectivityResult.none != connected;
  }

  @override
  Future<bool> get isOnLine async {
    final onLine = await Connectivity().checkConnectivity();
    return (ConnectivityResult.mobile == onLine ||
        ConnectivityResult.wifi == onLine ||
        ConnectivityResult.vpn == onLine);
  }
}
