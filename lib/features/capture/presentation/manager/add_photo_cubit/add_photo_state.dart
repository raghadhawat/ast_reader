part of 'add_photo_cubit.dart';

@immutable
sealed class AddPhotoState {}

final class AddPhotoInitial extends AddPhotoState {}

final class AddPhotoLoading extends AddPhotoState {}

final class AddPhotoSuccess extends AddPhotoState {
  final AddPhotoModel addPhotoModel;

  AddPhotoSuccess({required this.addPhotoModel});
}

final class AddPhotoFailure extends AddPhotoState {
  final String errMessage;

  AddPhotoFailure({required this.errMessage});
}
