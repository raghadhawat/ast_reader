part of 'acceptplate_cubit.dart';

@immutable
sealed class AcceptplateState {}

final class AcceptplateInitial extends AcceptplateState {}
final class AcceptplateLoading extends AcceptplateState {}
final class AcceptplateSuccess extends AcceptplateState {
  final StatusModel statusModel;

  AcceptplateSuccess({required this.statusModel});
}
final class AcceptplateFailure extends AcceptplateState {
  final String errMessage;

  AcceptplateFailure({required this.errMessage});
}
