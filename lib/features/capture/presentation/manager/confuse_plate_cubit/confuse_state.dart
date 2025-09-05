part of 'confuse_cubit.dart';

@immutable
sealed class ConfuseState {}

final class ConfuseInitial extends ConfuseState {}

final class ConfuseLoading extends ConfuseState {}

final class ConfuseSuccess extends ConfuseState {
  final StatusModel statusModel;

  ConfuseSuccess({required this.statusModel});
}

final class ConfuseFailure extends ConfuseState {
  final String errMessage;

  ConfuseFailure({required this.errMessage});
}
