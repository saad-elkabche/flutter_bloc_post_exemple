


import 'package:bloc_exemple/domain/entities/post_entityl.dart';

abstract class PostsRepository{

  Future<List<PostEntity>> getPosts();
  Future<PostEntity> createPost(PostEntity Post);
  Future<PostEntity> updatePost(PostEntity Post);
  Future deletePost(PostEntity Post);

}