

import 'package:flutter_bloc/flutter_bloc.dart';

part 'lectures_event.dart';
part 'lectures_state.dart';

class LecturesBloc extends Bloc<LecturesEvent, LecturesState> {
  LecturesBloc() : super(LecturesInitial()) {
    on<LecturesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}



