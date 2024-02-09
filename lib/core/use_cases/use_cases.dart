import 'package:solar_energy_prediction/core/utils/typedefs.dart';

abstract class UseCase<T, R> {
  const UseCase();

  T call(R input);
}

abstract class FutureUseCase<T, R> {
  const FutureUseCase();

  ResultFuture<T> call(R input);
}
