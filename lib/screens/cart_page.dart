import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/cart_service.dart';
import 'package:ecommerce_app/widgets/cart_card.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget{
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{
  List<Map<String, dynamic>> _cartItems = [];
  double _cartTotal = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async{
    setState(() {
      _isLoading = true;
    });

    try{

      final cartItems = await CartService.getProductsOnCart();
      final cartTotal = await CartService.getCartTotal();

      setState(() {
        _cartItems = cartItems;
        _cartTotal = cartTotal;
        _isLoading = false;
      });

    }catch(e){
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar itens no carrinho: $e')));
    }
  }

  Future<void> _removeItem(String cartItemId) async{
    await CartService.removeItemFromCart(cartItemId);
    await _loadCartData();
  }

  Future<void> _plusItem(String cartItemId) async{
    await CartService.plusOneCartItem(cartItemId);
    await _loadCartData();
  }

  Future<void> _minusItem(String cartItemId) async{
    await CartService.minusOneCartItem(cartItemId);
    await _loadCartData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: CustomDrawerNavigation(),
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(color: customLightGrey),
    ),
    body: _cartItems.isEmpty?
      Center(
        child: Text('Nenhum produto no carrinho!'),
      ) 
        : _isLoading? 
        Center(
          child: CircularProgressIndicator(color: customBlue,),
        )
        :
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Header(),
          SizedBox(height: 50),
          Text('Total: R\$${_cartTotal.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700),),
          SizedBox(
            height: 750,
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index){
                final item = _cartItems[index];
                final product = item['product'];
                final quantity = item['quantity'];
                final cartItemId = item['cartItemId'];

                return CartCard(
                  imageUri: product['image'],
                  productName: product['name'],
                  productPrice: (product['priceWithDiscount'] > 0? product['priceWithDiscount'] : product['price']) / 100,
                  quantity: quantity,
                  cartItemId: cartItemId,
                  removeItem: () => _removeItem(cartItemId),
                  plusItem: () => _plusItem(cartItemId),
                  minusItem: () => _minusItem(cartItemId),
                );
              }
            )
          ),
        ],
      ),
    )
  );
}