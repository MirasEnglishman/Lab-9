// lib/data/mobile_api.dart

import 'package:dio/dio.dart';
import 'package:lab_9_1/models/profile.dart';
import 'package:lab_9_1/models/user.dart';              // <-- ваша модель User
import 'package:firebase_database/firebase_database.dart';
import 'package:retrofit/retrofit.dart';

part 'mobile_api.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class MobileClient {
  factory MobileClient(Dio dio, {String baseUrl}) = _MobileClient;

  @GET("posts/1")
  Future<Profile> getProfileData();

  @GET("posts")
  Future<List<Profile>> getListData();

}
