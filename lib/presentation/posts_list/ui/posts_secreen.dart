import 'package:bloc_exemple/domain/entities/post_entityl.dart';
import 'package:bloc_exemple/domain/repository/posts_repository.dart';
import 'package:bloc_exemple/presentation/posts_list/posts_list_bloc/posts_list_bloc.dart';
import 'package:bloc_exemple/presentation/posts_list/ui/add_post.dart';
import 'package:bloc_exemple/presentation/posts_list/ui/update_post_secreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PostsSecreen extends StatefulWidget {

  static Widget page()=>BlocProvider<PostsListBloc>
    (create:(context)=>PostsListBloc(),
    child: PostsSecreen(),
  );



   PostsSecreen({Key? key}) : super(key: key);

  @override
  State<PostsSecreen> createState() => _PostsSecreenState();
}

class _PostsSecreenState extends State<PostsSecreen> {
  @override
  void initState() {
    super.initState();
    _fetchingData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body:BlocBuilder<PostsListBloc,PostsListState>(
        builder: (context,state){
          if(state is PostsListLoading){
            return LodingPosts();
          }else if(state is PostsListInitial){
            return const Center(child: Text("initial"),);
          }else if(state is PostsListError){
            return ErrorLoading();
          }else{
            return PostsList((state as PostsListStateLoaded).posts);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navToAddPost,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget LodingPosts()=>Center(child: CircularProgressIndicator(),);

  Widget ErrorLoading()=>Center(
    child: Column(
      children: [
        const Text("Error"),
        const SizedBox(height: 10,),
        ElevatedButton(onPressed: _fetchingData, child: const Text("Retry"))
      ],
    ),);

  Widget PostsList(List<PostEntity> posts)=>ListView(
    children: [
      ...List.generate(posts.length,
              (index) =>postItem(posts.elementAt(index)))
    ],
  );

  Widget postItem(PostEntity post)=>ListTile(
    title: Text(post.title,style: const TextStyle(fontWeight: FontWeight.bold),),
    subtitle: Text(post.body,overflow:TextOverflow.ellipsis ,),
    trailing: SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(onPressed:()=>_navToUpdate(post), icon: const Icon(Icons.edit,color: Colors.lightBlueAccent,)),
          //const SizedBox(width: 10,),
          IconButton(onPressed:()=> _onDeleteButtonClick(post), icon:const Icon(Icons.delete,color: Colors.deepOrange,))
        ],
      ),
    ),
  );


  void _fetchingData() {
    PostsRepository repository=RepositoryProvider.of<PostsRepository>(context);
    BlocProvider.of<PostsListBloc>(context).add(FetchPosts(repository));
  }







  void _navToAddPost() {
    Navigator.of(context).push(MaterialPageRoute(builder:
        (context)=>CreatePostSecreen.page()
    )
    );
  }

  void _navToUpdate(PostEntity post) {
    Navigator.of(context).push(MaterialPageRoute(builder:
        (context)=>UpdatePostSecreen.page(post)
    )
    );
  }

  void _onDeleteButtonClick(PostEntity postEntity) {
    PostsRepository repository=RepositoryProvider.of<PostsRepository>(context);
    BlocProvider.of<PostsListBloc>(context).add(
        DeletePost(postEntity: postEntity,
            repository: repository,
            context: context)
    );
  }
}
