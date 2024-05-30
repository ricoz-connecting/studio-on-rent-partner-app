import 'package:studio_partner_app/src/features/help/data/datasource/help_data_source.dart';
import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/features/help/domain/repository/help_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class HelpRepositoryImpl implements HelpRepository {
  final HelpDataSource helpDataSource;

  HelpRepositoryImpl({required this.helpDataSource});
  @override
  FutureEitherFailure<List<HelpEntity>> getHelps() {
    // TODO: implement getHelps
    return helpDataSource.getHelps();
  }
   @override
  FutureEitherFailure<List<TableModel>> getIssues() {
    // TODO: implement getHelps
    return helpDataSource.getIssues();
  }

  @override
  FutureEitherFailure<List<TableModel>> sendIssues(TableModel tableentity) {
    // TODO: implement sendIssues
   return helpDataSource.sendIssues(tableentity);
  }
  
}
