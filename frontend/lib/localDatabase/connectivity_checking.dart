import 'package:connectivity/connectivity.dart';

class ConnectivityChecks{

  
  
  Future<bool> checkNetworkConnectivity() async{
  var connectivityResult =  await Connectivity().checkConnectivity();
    return connectivityResult !=  ConnectivityResult.none;
    
    
  }
}
