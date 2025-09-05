part of 'all_plates_cubit.dart';

@immutable
sealed class AllPlatesState {}

final class AllPlatesInitial extends AllPlatesState {}
final class AllPlatesLoading extends AllPlatesState {}
final class AllPlatesSuccess extends AllPlatesState {
  final AllPlatesModel allPlatesModel;

  AllPlatesSuccess({required this.allPlatesModel});
}
final class AllPlatesFailure extends AllPlatesState {
  final String errMessage;

  AllPlatesFailure({required this.errMessage});
}
