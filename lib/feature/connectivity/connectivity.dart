import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { connected, disconnected, unknown }

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>(
      (ref) => ConnectivityNotifier(),
);

class ConnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityStatus _connectionStatus = ConnectivityStatus.unknown;

  ConnectivityNotifier() : super(ConnectivityStatus.unknown) {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _updateConnectionStatus(ConnectivityResult.none); // Initial check
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        _connectionStatus = ConnectivityStatus.connected;
        break;
      case ConnectivityResult.none:
        _connectionStatus = ConnectivityStatus.disconnected;
        break;
      default:
        _connectionStatus = ConnectivityStatus.unknown;
    }
    state = _connectionStatus;
  }
}