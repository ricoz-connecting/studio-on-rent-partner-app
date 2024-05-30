import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract class HelpRepository {
  FutureEitherFailure<List<HelpEntity>> getHelps();
  FutureEitherFailure<List<TableEntity>> getIssues();
  FutureEitherFailure<List<TableEntity>> sendIssues(TableModel tableentity);

}
