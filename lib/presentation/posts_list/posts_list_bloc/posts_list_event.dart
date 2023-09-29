part of 'posts_list_bloc.dart';

@immutable
abstract class PostsListEvent {}


class FetchPosts extends PostsListEvent{
  final PostsRepository repository;
  FetchPosts(this.repository);
}
class CreatePost extends PostsListEvent{
  final String title;
  final String body;
  final int id;
  final int userId;
  final PostsRepository repository;
  final BuildContext context;
  late PostEntity post;

  CreatePost({
    required this.title,
    required this.body,
    required this.id,
    required this.userId,
    required this.repository,
    required this.context
}):post=PostEntity(id: id, title: title, body: body, userId: userId);
}
class UpdatePost extends PostsListEvent{

  final BuildContext context;
  final PostsRepository repository;
  final PostEntity postEntity;
  UpdatePost({
    required String title,
    required String body,
    required this.repository,
    required this.context,
    required this.postEntity
}){
    postEntity.title=title;
    postEntity.body=body;
  }


}
class DeletePost extends PostsListEvent{
  final PostEntity postEntity;
  final PostsRepository repository;
  final BuildContext context;
  DeletePost({
    required this.postEntity,
    required this.repository,
    required this.context
  });
}
