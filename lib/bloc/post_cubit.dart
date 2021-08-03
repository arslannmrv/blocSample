import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/bloc/post_state.dart';

import 'post_repository.dart';


class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;
  PostsCubit(this._postsRepository) : super(PostsInitial());

  Future<void> getPosts() async {
    try {
      emit(PostsLoading());
      await Future.delayed(Duration(milliseconds: 500));
      final response = await _postsRepository.getPosts();
      emit(PostsCompleted(response));
    } on NetworkError catch (e) {
      emit(CatsError(e.message));
    }
  }
}