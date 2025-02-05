import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/features/users/presentation/screens/user_details/bloc/users_details_bloc.dart';
import 'package:users/features/users/presentation/widgets/index.dart';

String _userId = '';

class UserDetails extends StatefulWidget {
  UserDetails({super.key});
  final UsersDetailsBloc blocUsersDetails = UsersDetailsBloc();

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _userId = arguments['userId'];

    widget.blocUsersDetails.add(GetusersPosts(userId: _userId));

    return BlocProvider(
      create: (context) => widget.blocUsersDetails,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            arguments['name'],
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<UsersDetailsBloc, UsersDetailsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostsLoaded) {
              final user = state.posts;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCardUser(
                        name: arguments['name'],
                        phone: arguments['phone'],
                        email: arguments['email'],
                        onpress: () {}),
                    Text(
                      ' Posts de usuario',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final item = state.posts[index];
                          return SocialPostCard(
                            title: item.title,
                            body: item.body,
                            nameUsuario: 'no',
                            postId: item.id.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

// Versión Estilo Red Social
class SocialPostCard extends StatelessWidget {
  final String nameUsuario;
  final String title;
  final String postId;
  final String body;

  const SocialPostCard(
      {super.key,
      required this.nameUsuario,
      required this.title,
      required this.postId,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del post
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
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          // Contenido del post
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
          // Barra de acciones
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_outlined),
                  label: const Text('Me gusta'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                  label: const Text('Comentar'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Compartir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
