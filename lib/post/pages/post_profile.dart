import 'package:flutter/material.dart';
import 'package:lab_9_1/models/get_post.dart';
import 'package:lab_9_1/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostProfile extends StatefulWidget {
  const PostProfile({super.key});

  @override
  State<PostProfile> createState() => _PostProfileState();
}

class _PostProfileState extends State<PostProfile> {
  List<Posts> posts = [];
  late PostBloc postBloc;
  @override
  void initState() {
    super.initState();
    postBloc = PostBloc();
    print("Добавлено событие GetPostEvent()");
    postBloc.add(GetPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: postBloc,
      builder: (BuildContext context, state) {
        if (state is LoadingPostState) {
          return CircularProgressIndicator();
        }
        if (state is PostLoaded) {
          posts = state.posts;
          return builBody();
        } else {
          return Center(child: Text("Same error"));
        }
      },
    );
  }

  Widget builBody() {
    List<Widget> children = [];
    for (var item in posts) {
      children.add(Column(children: [Text(item.body)]));
    }
    return Center(
      child: SingleChildScrollView(child: Column(children: children)),
    );
  }
}
