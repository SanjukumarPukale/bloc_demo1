import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

enum InternetState {Initial, Lost, Gained}  
  // enum is using instead blank classes extends InternetState


// in cubit event is not prensent
class InternetCubit extends Cubit<InternetState> {

  Connectivity _connectivity = Connectivity();
  StreamSubscription connectivitySubscription;

  InternetCubit() : super(InternetState.Initial){
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(InternetState.Gained);
      }
      else{
        emit(InternetState.Lost);
      }
    });
  }

  @override
  Future<void> close(){
    connectivitySubscription.cancel();
    return super.close();
  }

  
}