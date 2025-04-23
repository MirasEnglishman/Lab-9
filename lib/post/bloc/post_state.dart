part of 'post_bloc.dart';

@immutable
sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoaded extends PostState {
  final List<Posts> posts;
  const PostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class LoadingPostState extends PostState {}

final class FetchedPostState extends PostState {}

final class FailurePostState extends PostState {
  final String message;
  const FailurePostState(this.message);

  @override
  List<Object> get props => [message];
}
