import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/repository/help_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetIssues
    implements Usecases<Null, FutureEitherFailure<List<TableEntity>>> {
  final HelpRepository helpRepository;

  GetIssues({required this.helpRepository});
  @override
  FutureEitherFailure<List<TableEntity>> call(Null params) {
    // TODO: implement call
    return helpRepository.getIssues();
  }
}
