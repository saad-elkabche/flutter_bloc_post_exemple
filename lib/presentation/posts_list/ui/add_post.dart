import 'package:bloc_exemple/domain/repository/posts_repository.dart';
import 'package:bloc_exemple/presentation/components/button.dart';
import 'package:bloc_exemple/presentation/components/text_field.dart';
import 'package:bloc_exemple/presentation/posts_list/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CreatePostSecreen extends StatefulWidget {
  static Widget page(){
    return BlocProvider<PostsListBloc>
      (create: (conetxt)=>PostsListBloc(),
      child: CreatePostSecreen(),
    );
  }

   CreatePostSecreen({Key? key}) : super(key: key);

  @override
  State<CreatePostSecreen> createState() => _CreatePostSecreenState();
}

class _CreatePostSecreenState extends State<CreatePostSecreen> {

  late TextEditingController controllerTitle;
  late TextEditingController controllerBody;
  late GlobalKey<FormState> formState=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controllerTitle=TextEditingController();
    controllerBody=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
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
              MyTextField(label: "body", icon: Icons.text_fields, controller: controllerBody),
              const SizedBox(height: 30,),
              MyButton(label: "Create", onclick: _onCreateButtonClick)
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateButtonClick() {
   if(formState.currentState!.validate()) {
      PostsRepository repository =
          RepositoryProvider.of<PostsRepository>(context);
      BlocProvider.of<PostsListBloc>(context).add(CreatePost(
          title: controllerTitle.text,
          body: controllerBody.text,
          id: 1,
          userId: 1,
          repository: repository,
          context: context));
    }
  }
}
