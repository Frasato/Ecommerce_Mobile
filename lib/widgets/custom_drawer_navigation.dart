import 'package:flutter/material.dart';

class CustomDrawerNavigation extends StatelessWidget{
  final int cartItemCount;

  const CustomDrawerNavigation({
    super.key,
    this.cartItemCount = 0
  });

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
          title: Row(
            children: [
              Text('Carrinho de compras'),
              SizedBox(width: 16),
              if(cartItemCount > 0) ...[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle
                  ),
                  child: Text('13'),
                )
              ],
            ],
          ),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('Pedidos'),
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