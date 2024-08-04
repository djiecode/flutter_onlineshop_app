import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/models/product_quantity.dart';
import 'package:flutter_onlineshop_app/persentation/home/widgets/product_detail.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/variables.dart';
import '../../../core/core.dart';
import '../../home/bloc/checkout/checkout_bloc.dart';

class CartTile extends StatelessWidget {
  final ProductQuantity data;
  final bool isEditable;
  final bool isSearchCard;
  const CartTile({
    super.key,
    required this.data,
    this.isEditable = true,
    this.isSearchCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // remove order
                context.read<CheckoutBloc>().add(CheckoutEvent.removeOrder(data.product));
              },
              backgroundColor: AppColors.primary.withOpacity(0.44),
              foregroundColor: AppColors.red,
              icon: Icons.delete_outlined,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10.0),
              ),
            ),
          ],
        ),
        enabled: isEditable,
        child: InkWell(
          onTap: () {
            // Navigasi ke ProductDetailsPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(data: data.product),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        data.product.image!.contains('http')
                            ? data.product.image!
                            : '${Variables.baseUrlImage}${data.product.image}',
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SpaceWidth(14.0),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.product.name ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  data.product.price!.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 0,
                                fit: FlexFit.tight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (isEditable)
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(5.0)),
                                        child: InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                CheckoutEvent.removeItem(data.product));
                                          },
                                          child: const ColoredBox(
                                            color: AppColors.primary,
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.remove,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SpaceWidth(4.0),
                                    if (isSearchCard)
                                      IconButton(
                                        onPressed: () {
                                          context.read<CheckoutBloc>().add(
                                              CheckoutEvent.addItem(data.product));
                                        },
                                        icon: Container(
                                          padding: const EdgeInsets.all(4.0),
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
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${data.quantity}'),
                                      ),
                                    const SpaceWidth(4.0),
                                    if (isEditable)
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(5.0)),
                                        child: InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                CheckoutEvent.addItem(data.product));
                                          },
                                          child: const ColoredBox(
                                            color: AppColors.primary,
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
