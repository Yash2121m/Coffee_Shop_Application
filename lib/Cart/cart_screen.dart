import 'package:Coffee_Shop_Application/Checkout/checkout_screen.dart';
import 'package:Coffee_Shop_Application/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

//https://blog.logrocket.com/building-shopping-cart-flutter/

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.cartItems[index];
                    return ListTile(
                      leading: Image.asset("images/${product.image}"),
                      title: Text(product.name),
                      subtitle: Text('₹${product.price.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          cartProvider.removeProduct(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: ₹${cartProvider.totalPrice.toString()}',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: BorderRadius.circular(30)),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                  },
                  // onTap: () {
                  //     MaterialPageRoute(builder: (context) => const checkoutScreen());
                  // },
                  child: const Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
