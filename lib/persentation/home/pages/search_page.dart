import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/core/assets/assets.gen.dart';
import 'package:flutter_onlineshop_app/core/components/spaces.dart';
import 'package:flutter_onlineshop_app/core/router/app_router.dart';
import 'package:flutter_onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_onlineshop_app/persentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/bloc/search/search_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/models/product_quantity.dart';
import 'package:flutter_onlineshop_app/persentation/orders/widgets/cart_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_onlineshop_app/core/components/search_input.dart';


class SearchPage extends StatefulWidget {
  final bool? requestSearchFocus;
  final String? sKeyword;
  const SearchPage({
    Key? key,
    this.requestSearchFocus,
    this.sKeyword,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  late final FocusNode _focusNode = FocusNode();
  final SearchBloc _blocSearchProduct = SearchBloc(ProductRemoteDatasource());

  @override
  void initState() {
    // if (widget.requestSearchFocus == true) {
    //   _focusNode.requestFocus();
    // }
    _focusNode.requestFocus();
    if (widget.sKeyword case var key?) {
      _blocSearchProduct.add(SearchEvent.onPassingArgument(key));
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  loaded: (cart, _, __, ___, ____, _____) {
                    final totalQuantity = cart.fold<int>(
                      0,
                      (previousValue, element) =>
                          previousValue + (element.quantity),
                    );
                    if (totalQuantity == 0) {
                      return IconButton(
                        onPressed: () {
                          context.goNamed(
                            RouteConstants.cart,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        icon: Assets.icons.cart.svg(height: 24.0),
                      );
                    } else {
                      return badges.Badge(
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
                      );
                    }
                  });
            },
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          SearchInput(
            controller: _textController,
            focusNode: _focusNode,
            onChanged: (value) {
              _blocSearchProduct.add(SearchEvent.onTextChanged(value));
            },
          ),
          const SpaceHeight(16.0),
          BlocBuilder<SearchBloc, SearchState>(
            bloc: _blocSearchProduct,
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Text("No result"),
                onEmpty: () => const Text("Please type"),
                onNotFound: () => const Text("Product Not found"),
                onError: (message) => Text(message),
                onLoaded: (products) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) => CartTile(
                      isEditable: false,
                      isSearchCard: true,
                      data: ProductQuantity(
                        quantity: 0,
                        product: products[index],
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
