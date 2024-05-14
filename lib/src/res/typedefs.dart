import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';


typedef FutureEitherFailure<R> = Future<Either<Failure,R>>;
