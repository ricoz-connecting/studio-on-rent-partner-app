import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/get_issues.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/send_issues.dart';

part 'issues_event.dart';
part 'issues_state.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  final GetIssues _getIssues;
  final SendIssues _sendIssues;
  IssuesBloc({required GetIssues getIssues, required SendIssues sendIssues})
      : _getIssues = getIssues,
        _sendIssues = sendIssues,
        super(IssuesInitial()) {
    on<IssuesEvent>((event, emit) {
      // TODO: implement event handler
      emit(IssuesLoadingState());
    });
    on<GetIssuesEvent>(
      (event, emit) async {
        final res = await _getIssues.call(null);
        res.fold((l) => emit(IssuesFailureState(message: l.message)),
            (r) => emit(IssuesSuccessState(tables: r)));
      },
    );
    on<SendIssuesEvent>(
      (event, emit) async {
        final res = await _sendIssues.call(event.tableEntity);
        res.fold((l) => emit(IssuesFailureState(message: l.message)),
            (r) => emit(IssuesSuccessState(tables: r)));
      },
    );
  }
}
