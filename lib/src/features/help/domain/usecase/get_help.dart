import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/repository/help_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetHelp implements Usecases<Null, FutureEitherFailure<List<HelpEntity>>> {
  final HelpRepository helpRepository;

  GetHelp({required this.helpRepository});
  @override
  FutureEitherFailure<List<HelpEntity>> call(Null params) {
    // TODO: implement call
    return helpRepository.getHelps();
  }
}
