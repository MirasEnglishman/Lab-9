import 'package:flutter/material.dart';
import 'package:lab_9_1/models/profile.dart';
import 'package:lab_9_1/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  late PostBloc postBloc;
  Profile? profile;
  int? userId;
  int? id;
  String? title;
  String? body;
  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileBloc.add(FetchedProfileEvent());
    postBloc = BlocProvider.of<PostBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User INFO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.elliptical(700, 50),
            bottomLeft: Radius.elliptical(700, 50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder(
        bloc: profileBloc,
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
          if (state is LoadedProfileState) {
            profile = state.profile;
            return buildBody();
          }
          if (state is FailureProfileState) {
            return Center(child: Text("Error"));
          }
          return Container();
        },
      ),
    );
  }

  Widget buildBody() {
    userId = profile?.userId;
    id = profile?.id;
    title = profile?.title;
    body = profile?.body;

    return ListView(
      children: [
        SizedBox(height: 50),
        Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text(userId != null ? userId.toString() : 'Нет userID'),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text(id != null ? id.toString() : 'Нет ID'),
              ),
              ListTile(
                leading: Icon(Icons.alternate_email_outlined),
                title: Text(title!),
              ),
              ListTile(
                leading: Icon(Icons.phone_android_outlined),
                title: Text(body!),
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
