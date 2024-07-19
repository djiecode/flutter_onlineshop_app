import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/core/assets/assets.gen.dart';
import 'package:flutter_onlineshop_app/core/router/app_router.dart';
import 'package:flutter_onlineshop_app/persentation/home/bloc/all_laptop/all_laptop_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/widgets/organism/all_category_product_list.dart';
import 'package:go_router/go_router.dart';

class CategoryProductsPage  extends StatefulWidget {
  // final List<Product> items;
  final int id;
  final String label;
  const CategoryProductsPage ({super.key, required this.id, required this.label});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
  
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AllLaptopBloc>().add(
          AllLaptopEvent.getByCategory(
            widget.id,
          ),
        );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
        BlocBuilder<AllLaptopBloc, AllLaptopState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (products) {
                return AllCategoryProductList(
                    // title: 'All Product',
                    // onSeeAllTap: () {},
                    items: products.length>20
                        ? products.sublist(0, 2)
                        : products);
              },
              orElse: () => const Center(child:Text('ss')),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => const Center(
                child: Text('no data'),
              ),
            );
          },
        ),
        ],
      ),
    );
  }
}
