import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_exemple/core/utils.dart';
import 'package:bloc_exemple/domain/entities/post_entityl.dart';
import 'package:bloc_exemple/domain/repository/posts_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'posts_list_event.dart';
part 'posts_list_state.dart';

class PostsListBloc extends Bloc<PostsListEvent, PostsListState> {
  PostsListBloc() : super(PostsListInitial()) {

    on<FetchPosts>(_fetchPosts);
    on<CreatePost>(_createPost);
    on<UpdatePost>(_updateData);
    on<DeletePost>(_deleteData);

  }

  FutureOr<void> _fetchPosts(FetchPosts event, Emitter<PostsListState> emit) async{
    PostsRepository postsRepository=event.repository;
    emit(PostsListLoading());
    try{
      List<PostEntity> posts=await postsRepository.getPosts();
      emit(PostsListStateLoaded(posts));
    }catch(ex){
      emit(PostsListError());
    }
  }

  FutureOr<void> _createPost(CreatePost event, Emitter<PostsListState> emit)async {

    PostEntity postEntity=event.post;
    BuildContext context=event.context;
    PostsRepository repository=event.repository;
    showProgressBar(context);
    try{
      PostEntity postEntityResponse=await repository.createPost(postEntity);
      print("=========================from bloc:${postEntityResponse.toJson()}");
      showSnackBar(context,"Success" , Colors.green);
    }catch(ex){
      showSnackBar(context, "Failed", Colors.red);
    }
    hideProgressBar(context);
  }

  FutureOr<void> _updateData(UpdatePost event, Emitter<PostsListState> emit) async{
    BuildContext context=event.context;
    PostsRepository repository=event.repository;
    showProgressBar(context);
    try{
      PostEntity postEntityResponse=await repository.updatePost(event.postEntity);
      print("=========================from bloc:${postEntityResponse.toJson()}");
      showSnackBar(context, "success", Colors.lightGreenAccent);
    }catch(ex){
      showSnackBar(context, "failed", Colors.redAccent);

    }
    hideProgressBar(context);
  }

  FutureOr<void> _deleteData(DeletePost event, Emitter<PostsListState> emit) async{
    PostEntity postEntity=event.postEntity;
    PostsRepository repository=event.repository;
    showProgressBar(event.context);
    try{
          await repository.deletePost(postEntity);
          showSnackBar(event.context, "success", Colors.green);
    }catch(ex){
      showSnackBar(event.context, "failed", Colors.redAccent);
    }
    hideProgressBar(event.context);
  }
}
