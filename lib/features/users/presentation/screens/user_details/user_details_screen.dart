import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/features/users/presentation/screens/user_details/bloc/users_details_bloc.dart';
import 'package:users/features/users/presentation/widgets/index.dart';

String _userId = '';
class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final UsersDetailsBloc _blocUsersDetails = UsersDetailsBloc();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _blocUsersDetails.add(GetusersPosts(userId: arguments['userId']));
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _blocUsersDetails.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocProvider.value(
      value: _blocUsersDetails,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            arguments['name'],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<UsersDetailsBloc, UsersDetailsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCardUser(
                      showSeePots: false,
                      name: arguments['name'],
                      phone: arguments['phone'],
                      email: arguments['email'],
                      onpress: () {},
                    ),
                    const Text(
                      '   Post del usuario',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final item = state.posts[index];
                          return SocialPostCard(
                            idPost: item.id.toString(),
                            title: item.title,
                            body: item.body,
                            nameUsuario: arguments['name'],
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
