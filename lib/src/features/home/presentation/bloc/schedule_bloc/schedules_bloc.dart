import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_schedules.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/update_schedule.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  final GetSchedules _getSchedules;
  final UpdateSchedule _updateSchedule;
  SchedulesBloc(
      {required GetSchedules getSchedules,
      required UpdateSchedule updateSchedule})
      : _getSchedules = getSchedules,
        _updateSchedule = updateSchedule,
        super(SchedulesInitial()) {
    on<SchedulesEvent>((event, emit) {
      // TODO: implement event handler
      emit(ScheduleLoadingState());
    });
    on<GetScheduleEvent>(
      (event, emit) async {
        final res = await _getSchedules.call(event.agentId);
        res.fold((l) => emit(ScheduleFailureState(message: l.message)),
            (r) => emit(ScheduleSuccessState(schedules: r)));
      },
    );
    on<UpdateScheduleEvent>(
      (event, emit) async {
        final res = await _updateSchedule.call(event.params);
        res.fold((l) => emit(ScheduleFailureState(message: l.message)),
            (r) => emit(ScheduleSuccessState(schedules: r)));
      },
    );
  }
}
