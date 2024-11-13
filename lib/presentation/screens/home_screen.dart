import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Bloc and Cubits"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Cubits"),
            subtitle: const Text("Gestor de estado cubit"),
            leading: const Icon(Icons.looks_one_outlined),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/cubits'),
          ),
          ListTile(
            title: const Text("BloC"),
            subtitle: const Text("Gestor de estado bloc"),
            leading: const Icon(Icons.looks_two_outlined),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/bloc'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          ),
          ListTile(
            title: const Text("New user"),
            subtitle: const Text("User registration"),
            leading: const Icon(Icons.person_add_alt_1_outlined),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/new-user'),
          ),
        ],
      ),
    );
  }
}
