import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/repository/help_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class SendIssues
    implements Usecases<TableModel, FutureEitherFailure<List<TableEntity>>> {
  final HelpRepository helpRepository;

  SendIssues({required this.helpRepository});
  @override
  FutureEitherFailure<List<TableEntity>> call(TableModel params) {
    // TODO: implement call
    return helpRepository.sendIssues(params);
  }
}
