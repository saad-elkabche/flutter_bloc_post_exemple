

import 'package:bloc_exemple/data/models/PostModel.dart';
import 'package:bloc_exemple/domain/entities/post_entityl.dart';
import 'package:bloc_exemple/domain/exceptions/mapper_exception.dart';
import 'package:logger/logger.dart';

class RemoteMapper{
  final Logger log;
  RemoteMapper(
    this.log
      );

  PostEntity toPostEntity(PostModel postModel){

    try{
      return PostEntity(id: postModel.id, title: postModel.title, body:postModel.body, userId: postModel.userId);
    }catch(e){
      throw MapperException<PostModel,PostEntity>(e.toString());
    }
  }

  List<PostEntity> toPostEntityList(List<PostModel> list){
      return list.map(
              (postModel){
                try{
                  return PostEntity(id: postModel.id,
                      title: postModel.title,
                      body:postModel.body,
                      userId: postModel.userId) ;
                }catch(ex){
                  throw MapperException<PostModel,PostEntity>("${ex.toString()} model id:${postModel.id}");
                }

              }).toList();
  }


  PostModel toPostModel(PostEntity postEntity){
    try{
      return PostModel(id: postEntity.id,
          title: postEntity.title,
          body: postEntity.body,
          userId: postEntity.userId);
    }catch(ex){
      throw MapperException<PostEntity,PostModel>(ex.toString());
    }
  }

}