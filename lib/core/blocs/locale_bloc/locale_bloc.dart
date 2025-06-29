import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_event.dart';
import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitialState()) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocaleLoadedState(event.locale.languageCode));
    });
  }
}
