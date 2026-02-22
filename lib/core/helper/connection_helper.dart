// check if the user is connected to the internet

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionHelper {
  // Check if the device is connected to the internet
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // Not connected to any network
    if (connectivityResult == ConnectivityResult.none) {
      return false; 
    } 
    
    // Connected to either mobile data or Wi-Fi
    else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn) {
      return true; 
    }

    return false; // Default to not connected
  }
}
