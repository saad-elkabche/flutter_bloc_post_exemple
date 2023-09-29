import 'package:bloc_exemple/data/data_providers/remote/client/api_client.dart';
import 'package:bloc_exemple/data/data_providers/remote/remote_mapper.dart';
import 'package:bloc_exemple/data/repository/posts_repository.dart';
import 'package:bloc_exemple/domain/repository/posts_repository.dart';
import 'package:bloc_exemple/presentation/posts_list/posts_list_bloc/posts_list_bloc.dart';
import 'package:bloc_exemple/presentation/posts_list/ui/posts_secreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PostsRepository>(
    create: (context){
        ApiClientIml apiClientIml=ApiClientIml('https://jsonplaceholder.typicode.com');
        Logger logger=Logger(
        printer: PrettyPrinter(
          printEmojis: true,
          colors: true,
          printTime: false
        ),
      );
       return PostsRepositoryIml(apiClient:apiClientIml , log: logger, mapper: RemoteMapper(logger));
    },
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PostsSecreen.page()
    ),
);
  }
}

