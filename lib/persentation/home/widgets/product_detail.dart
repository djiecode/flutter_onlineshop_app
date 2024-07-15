// detail product from product card
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/core/core.dart';
import 'package:flutter_onlineshop_app/core/router/app_router.dart';
import 'package:flutter_onlineshop_app/data/models/responses/product_response_model.dart';
import 'package:flutter_onlineshop_app/persentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsPage extends StatelessWidget {
  // final String imageUrl;
  final Product data;
  const ProductDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (checkout, _, __, ___, ____, _____) {
                  final totalQuantity = checkout.fold<int>(
                    0,
                    (previousValue, element) =>
                        previousValue + element.quantity,
                  );
                  return totalQuantity > 0
                      ? badges.Badge(
                          badgeContent: Text(
                            totalQuantity.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.goNamed(
                                RouteConstants.cart,
                                pathParameters: PathParameters().toMap(),
                              );
                            },
                            icon: Assets.icons.cart.svg(height: 24.0),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.goNamed(
                              RouteConstants.cart,
                              pathParameters: PathParameters().toMap(),
                            );
                          },
                          icon: Assets.icons.cart.svg(height: 24.0),
                        );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(width: 16.0),
          const SizedBox(height: 40.0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
        },
        icon: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: const Offset(0, 2),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Assets.icons.order.svg(),
        ),
        label: const Text('Add to Cart'),
        // icon: const Icon(Icons.shopping_cart),
      ),
      // action button on left
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

      body: ListView(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              data.image!.contains('http')
                  ? data.image!
                  : '${Variables.baseUrlImage}${data.image}',
              // height: MediaQuery.of(context).size.height / 1.8,
              height: 300.0,
              width: 325.0,

              // fit: BoxFit.fill,
            ),
          ),

          // Product title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              data.name!,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.price!.currencyFormatRp,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(81, 177, 166, 1)),
            ),
          ),

          // product stock
          // Container(
          //   height: 20.0, // Set the height to 20px
          //   width: 10.0, // Set the width to 93px
          //   // padding: const EdgeInsets.symmetric(horizontal: 1.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50.0),
          //     color: const Color.fromRGBO(81, 177, 166, 1),
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.black.withOpacity(0.1),
          //         blurRadius: 10.0,
          //         offset: const Offset(0, 2),
          //         blurStyle: BlurStyle.outer,
          //       ),
          //     ],
          //   ),
          // child: const Text(
          //   'Tersedia: 10',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //     fontSize: 14.0,
          //   ),
          // ),
          // ),
          // Product description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Description Product',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              data.description!,
            ),
          ),
          // Product price

          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
