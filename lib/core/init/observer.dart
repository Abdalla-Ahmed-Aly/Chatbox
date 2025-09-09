import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_bloc_observer.dart';

void observerInit(){
  Bloc.observer = AppBlocObserver();
}