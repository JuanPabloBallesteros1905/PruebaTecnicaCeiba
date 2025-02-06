


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/users/presentation/screens/user_details/bloc/users_details_bloc.dart';

class SocialPostCard extends StatelessWidget {
  final String nameUsuario;
  final String title;
  final String postId;
  final String body;
  final String idPost;

  const SocialPostCard({
    super.key,
    required this.nameUsuario,
    required this.title,
    required this.postId,
    required this.body,
    required this.idPost,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[700],
              child: Text(
                nameUsuario.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              nameUsuario,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Post $postId'),
         
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(body),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    final commentsBloc = UsersDetailsBloc();
                    commentsBloc.add(GetComments(postId: postId));

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => BlocProvider(
                        create: (context) => commentsBloc,
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.9,
                          minChildSize: 0.5,
                          maxChildSize: 0.95,
                          builder: (_, scrollController) => CommentsSheet(
                            scrollController: scrollController,
                          ),
                        ),
                      ),
                    ).then((_) => commentsBloc.close());
                  },
                  icon: const Icon(Icons.comment_outlined),
                  label: const Text('Ver comentarios'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





class CommentsSheet extends StatelessWidget {
  final ScrollController scrollController;

  const CommentsSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comentarios',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<UsersDetailsBloc, UsersDetailsState>(
              builder: (context, state) {
                if (state is DataCommentsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is DataCommentsLoaded) {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      final item = state.comments[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                item.name.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.email,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.body,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}