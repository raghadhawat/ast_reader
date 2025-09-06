part of 'create_plate_cubit.dart';

@immutable
sealed class CreatePlateState {}

final class CreatePlateInitial extends CreatePlateState {}
final class CreatePlateLoading extends CreatePlateState {}
final class CreatePlateSuccess extends CreatePlateState {
  final Datum data;

  CreatePlateSuccess({required this.data});
}
final class CreatePlateFailure extends CreatePlateState {
  final String errMessage;

  CreatePlateFailure({required this.errMessage});
}
