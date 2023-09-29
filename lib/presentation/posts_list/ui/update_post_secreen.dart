

import 'package:bloc_exemple/domain/entities/post_entityl.dart';
import 'package:bloc_exemple/domain/repository/posts_repository.dart';
import 'package:bloc_exemple/presentation/components/button.dart';
import 'package:bloc_exemple/presentation/components/text_field.dart';
import 'package:bloc_exemple/presentation/posts_list/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






class UpdatePostSecreen extends StatefulWidget {
  late PostEntity postEntity;

  static Widget page(PostEntity postEntity){
    return BlocProvider<PostsListBloc>(
        create: (context)=>PostsListBloc(),
      child: UpdatePostSecreen(postEntity:postEntity ),
    );
  }

   UpdatePostSecreen({required this.postEntity});

  @override
  State<UpdatePostSecreen> createState() => _UpdatePostSecreenState();
}

class _UpdatePostSecreenState extends State<UpdatePostSecreen> {

  late TextEditingController controllerTitle;
  late TextEditingController controllerBody;
  late GlobalKey<FormState> formState=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controllerTitle=TextEditingController();
    controllerBody=TextEditingController();

    controllerTitle.text=widget.postEntity.title;
    controllerBody.text=widget.postEntity.body;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(label: "Title", icon: Icons.text_fields, controller: controllerTitle),
              const SizedBox(height: 20,),
              MyTextField(label: "body", icon: Icons.text_fields, controller: controllerBody,isLarge: true,),
              const SizedBox(height: 30,),
              MyButton(label: "Update", onclick: _onUpdateButtonClick)
            ],
          ),
        ),
      ),
    );
  }



  void _onUpdateButtonClick() {
    PostsRepository repository=RepositoryProvider.of<PostsRepository>(context);
    BlocProvider.of<PostsListBloc>(context).add(
       UpdatePost(
           title: controllerTitle.text,
           body: controllerBody.text,
           repository: repository,
           context: context,
           postEntity: widget.postEntity)
    );
  }
}
