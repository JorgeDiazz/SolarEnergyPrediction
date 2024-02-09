import 'package:dartz/dartz.dart';
import 'package:solar_energy_prediction/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
