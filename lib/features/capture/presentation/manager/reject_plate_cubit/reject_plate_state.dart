part of 'reject_plate_cubit.dart';

@immutable
sealed class RejectPlateState {}

final class RejectPlateInitial extends RejectPlateState {}

final class RejectPlateLoading extends RejectPlateState {}

final class RejectPlateSuccess extends RejectPlateState {
  final StatusModel statusModel;

  RejectPlateSuccess({required this.statusModel});
}

final class RejectPlateFailure extends RejectPlateState {
  final String errMessage;

  RejectPlateFailure({required this.errMessage});
}
