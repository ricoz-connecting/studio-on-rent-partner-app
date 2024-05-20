
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/chat_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetChat
    implements Usecases<String, FutureEitherFailure<List<ChatEntity>>> {
  final BookingsRepository bookingsRepository;

  GetChat({required this.bookingsRepository});
  @override
  FutureEitherFailure<List<ChatEntity>> call(String params) {
    // TODO: implement call
    return bookingsRepository.getChats(params);
  }
}
