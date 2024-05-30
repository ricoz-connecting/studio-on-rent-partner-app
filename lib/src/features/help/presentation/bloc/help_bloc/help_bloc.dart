// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/get_help.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final GetHelp _getHelp;
  HelpBloc({required GetHelp getHelp})
      : _getHelp = getHelp,
        super(HelpInitial()) {
    on<HelpEvent>((event, emit) {
      // TODO: implement event handler
      emit(HelpLoadingState());
    });
    on<GetHelpEvent>(
      (event, emit) async {
        final res = await _getHelp.call(null);
        res.fold((l) => emit(HelpFailureState(message: l.message)),
            (r) => emit(HelpSuccessState(helps: r)));
      },
    );
  }
}
