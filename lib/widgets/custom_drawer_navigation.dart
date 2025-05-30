import 'package:flutter/material.dart';

class CustomDrawerNavigation extends StatelessWidget{
  const CustomDrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildMenuItems(context)
        ],
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 45),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Pagina Inicial'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.amp_stories_rounded),
          title: const Text('Explorar'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Carrinho de compras'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Sair da conta'),
          onTap: () => {},
        ),
      ],
    ),
  );
}