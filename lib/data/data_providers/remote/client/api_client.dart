

import 'package:bloc_exemple/data/models/PostModel.dart';
import 'package:bloc_exemple/domain/exceptions/server_exception.dart';
import 'package:dio/dio.dart';


abstract class ApiClient{
  Future<List<PostModel>> getPostModels();
  Future<PostModel> createPost(PostModel postModel);
  Future<PostModel> updatePost(PostModel postModel);
  Future deletePost(PostModel postModel);

}

class ApiClientIml implements ApiClient{
   late Dio _dio;


 ApiClientIml(String baseUrl){
   _dio=Dio()
     ..options.baseUrl=baseUrl
     ..options.connectTimeout=const Duration(seconds: 5)
     ..options.receiveTimeout=const Duration(seconds: 20)
       ..interceptors.add(LogInterceptor(request: true,requestBody: true,responseBody: true));


 }
  @override
  Future<List<PostModel>> getPostModels() async{
    var response=await _dio.get('/posts');
    if(response.statusCode!=200){
      throw ServerException(response.statusCode ?? -1,"url :${_dio.options.baseUrl }/posts");
    }
    List<dynamic> data=response.data;
    List<PostModel> listPosts=data.map((json) =>PostModel.fromJson(json as Map<String,dynamic>)).toList();
    return listPosts;
  }

  @override
  Future<PostModel> createPost(PostModel postModel) async{
    var response =await _dio.post(
      '/posts',
      data: postModel.toJson()
    );
    if(response.statusCode!=201){
      throw ServerException(response.statusCode ?? -1, "create");
    }
    print("=========================from api client");
    return PostModel.fromJson(response.data as Map<String,dynamic>);
  }

  @override
  Future deletePost(PostModel postModel) async{
    var response=await _dio.delete('/posts/${postModel.id}');
    if(response.statusCode!=200){
      throw ServerException(response.statusCode ?? -1, "delete Post");
    }
  }

  @override
  Future<PostModel> updatePost(PostModel postModel) async{
    var response=await _dio.put('/posts/${postModel.id}',data: postModel.toJson());
    if(response.statusCode!=200){
      throw ServerException(response.statusCode ?? -1, "update post");
    }
    return PostModel.fromJson(response.data as Map<String,dynamic>);
  }

}