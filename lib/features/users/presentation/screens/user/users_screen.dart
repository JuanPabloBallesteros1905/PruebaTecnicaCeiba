import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/utils/textos.dart';
import 'package:users/features/users/data/mappers/user_model_response.dart';
import 'package:users/features/users/presentation/screens/user/bloc/users_bloc.dart';
import 'package:users/features/users/presentation/widgets/index.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersBloc blocUsers = UsersBloc();
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    blocUsers.add(GetUsers());
  }

  @override
  void dispose() {
    searchController.dispose();
    blocUsers.close();
    super.dispose();
  }

  List<UserModelResponse> filterUsers(List<UserModelResponse> users, String query) {
    if (query.isEmpty) return users;

    return users.where((user) {
      final name = user.name.toLowerCase();
      final email = user.email.toLowerCase();
      final phone = user.phone.toLowerCase();
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) ||
          email.contains(searchLower) ||
          phone.contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Textos.mainAppBarTittle,
          style: const TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => blocUsers,
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return const CustomLoading();
            }

            if (state is UsersDataLoaded) {
              final filteredUsers = filterUsers(state.users, searchQuery);
              
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _customSearchBar(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  if (filteredUsers.isEmpty)
                    SliverFillRemaining(
                      child: _EmptyState(),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = filteredUsers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: CustomCardUser(
                                showSeePots: true,
                                name: item.name,
                                phone: item.phone,
                                email: item.email,
                                onpress: () {
                                  Navigator.pushNamed(
                                    context, 
                                    'userDetails',
                                    arguments: {
                                      "userId": item.id.toString(),
                                      "name": item.name,
                                      "phone": item.phone,
                                      "email": item.email
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          childCount: filteredUsers.length,
                        ),
                      ),
                    ),
                ],
              );
            }

            if (state is UsersError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        blocUsers.add(GetUsers());
                      },
                      child: const Text('Reintentar'),
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

  Widget _customSearchBar() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Buscar usuarios...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    searchQuery = '';
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _EmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Sin resultados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No se encontraron usuarios para "$searchQuery"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

