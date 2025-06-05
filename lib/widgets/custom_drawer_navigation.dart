import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawerNavigation extends StatelessWidget{
  const CustomDrawerNavigation({
    super.key,
  });

  Future<int> _TotalItemsOnCart() async{
    final cartItems = await CartService.getProductsOnCart();
    int total = cartItems.length;
    return total;
  } 

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
          onTap: () => {
            Navigator.pushReplacementNamed(context, '/home')
          },
        ),
        ListTile(
          leading: const Icon(Icons.amp_stories_rounded),
          title: const Text('Explorar'),
          onTap: () => {
            Navigator.pushReplacementNamed(context, '/catalog')
          },
        ),
        FutureBuilder<int>(
              future: _TotalItemsOnCart(),
              builder: (context, snapshot) {
                int total = snapshot.data ?? 0;
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Row(
                    children: [
                      const Text('Carrinho de compras'),
                      const SizedBox(width: 16),
                      if (total > 0)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: customYellow,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$total',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: customTextGrey),
                          ),
                        ),
                    ],
                  ),
                  onTap: () => Navigator.pushReplacementNamed(context, '/cart'),
                );
              },
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
          onTap: () async{
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}