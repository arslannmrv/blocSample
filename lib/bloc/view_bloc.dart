import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/bloc/post_cubit.dart';
import 'post_repository.dart';
import 'post_state.dart';

class BlocPostsView extends StatefulWidget {
  @override
  _BlocPostsViewState createState() => _BlocPostsViewState();
}

class _BlocPostsViewState extends State<BlocPostsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(SamplePostsRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostsInitial) {
              return buildCenterInitialChild(context);
            } else if (state is PostsLoading) {
              return buildCenterLoading();
            } else if (state is PostsCompleted) {
              return buildListViewPosts(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(PostsState state) {
    final error = state as CatsError;
    return Text(error.message);
  }

  ListView buildListViewPosts(PostsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(state.response[index].title),
        subtitle: Text(state.response[index].body),
      ),
      itemCount: state.response.length,
    );
  }

  Center buildCenterLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return Center(
      child: Column(
        children: [Text("Hello"), buildTextButtonCall(context)],
      ),
    );
  }

  TextButton buildTextButtonCall(BuildContext context) {
    return TextButton(
      child: Text("Posts"),
      onPressed: () {
        context.read()<PostsCubit>().getPosts();
      },
    );
  }
}
