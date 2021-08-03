import 'package:flutter/foundation.dart';

import 'post.dart';

abstract class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsCompleted extends PostsState {
  final List<Post> response;

  const PostsCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PostsCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends PostsState {
  final String message;
  const CatsError(this.message);
}