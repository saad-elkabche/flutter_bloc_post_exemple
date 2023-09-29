part of 'posts_list_bloc.dart';

@immutable
abstract class PostsListState {}

class PostsListInitial extends PostsListState {}

class PostsListLoading extends PostsListState {}
class PostsListError extends PostsListState {}


class PostsListStateLoaded extends PostsListState{
  final List<PostEntity> posts;
  PostsListStateLoaded(this.posts);
}

