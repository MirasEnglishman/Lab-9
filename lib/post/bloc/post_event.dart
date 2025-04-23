part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

final class GetPostEvent extends PostEvent {}
