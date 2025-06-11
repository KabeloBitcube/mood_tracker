import 'dart:developer';

import 'package:bloc/bloc.dart';

class MoodObserver extends BlocObserver{
  const MoodObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change){
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}