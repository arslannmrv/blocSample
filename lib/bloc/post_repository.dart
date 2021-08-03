import 'dart:convert';
import 'dart:io';

import 'post.dart';
import 'package:http/http.dart' as http;

abstract class PostsRepository {
  Future<List<Post>> getPosts();
}

class SamplePostsRepository implements PostsRepository {
   final _baseUrl = 'jsonplaceholder.typicode.com';
  @override
  Future<List<Post>> getPosts() async {
    final uri= Uri.https(_baseUrl, '/posts');

    final response = await http.get(uri);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => Post.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}