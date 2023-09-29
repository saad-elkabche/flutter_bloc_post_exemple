import 'package:bloc_exemple/data/data_providers/remote/client/api_client.dart';
import 'package:bloc_exemple/data/data_providers/remote/remote_mapper.dart';
import 'package:bloc_exemple/data/models/PostModel.dart';
import 'package:bloc_exemple/domain/entities/post_entityl.dart';
import 'package:bloc_exemple/domain/repository/posts_repository.dart';

import 'package:logger/logger.dart';




class PostsRepositoryIml extends PostsRepository{

  ApiClient apiClient;
  Logger log;
  RemoteMapper mapper;

  PostsRepositoryIml({
    required this.apiClient,
    required this.log,
    required this.mapper
});


  @override
  Future<PostEntity> createPost(PostEntity Post) async{
    try{
      PostModel postModel = mapper.toPostModel(Post);
      PostModel postResponse=await apiClient.createPost(postModel);
      print("=========================from repo");
      return mapper.toPostEntity(postResponse);
    }catch(ex){
      log.w(ex.toString());
      rethrow;
    }
  }

  @override
  Future deletePost(PostEntity Post) async{
    try{
      await apiClient.deletePost(mapper.toPostModel(Post));
    }catch(ex){
      log.w(ex.toString());
      rethrow;
    }
  }

  @override
  Future<List<PostEntity>> getPosts()async {
    try{
      List<PostModel> posts=await apiClient.getPostModels();
      return mapper.toPostEntityList(posts);
    }catch(ex){
      log.w(ex.toString());
      rethrow;
    }
  }

  @override
  Future<PostEntity> updatePost(PostEntity Post) async{
    try{
      PostModel postModel = await apiClient.updatePost(mapper.toPostModel(Post));
      return mapper.toPostEntity(postModel);
    }catch(ex){
      log.w(ex.toString());
      rethrow;
    }
  }

}