import 'package:flutter/material.dart';
import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/data/models/responses/order_detail_response_model.dart';

import '../../../core/components/spaces.dart';
import '../../../core/core.dart';


// class ProductTile extends StatelessWidget {
//   final OrderItem data;
//   const ProductTile({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.stroke),
//         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: Row(
//         children: [
//           // ClipRRect(
//           //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//           //   child: Image.network(
//           //     '${Variables.baseUrlImage}${data.product!.image!}',
//           //     width: 68.0,
//           //     height: 68.0,
//           //   ),
//           // ),
//           // const SpaceWidth(14.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 data.product!.name!,
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '${data.product!.price?.currencyFormatRp} x ${data.quantity} = ${(data.product!.price! * data.quantity!).currencyFormatRp}',
//                     style: const TextStyle(
//                       color: AppColors.primary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProductTile extends StatelessWidget {
  final OrderItem data;
  const ProductTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //   child: Image.network(
          //     '${Variables.baseUrlImage}${data.product!.image!}',
          //     width: 68.0,
          //     height: 68.0,
          //   ),
          // ),
          // const SpaceWidth(14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.product!.name!,
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${data.product!.price?.currencyFormatRp} x ${data.quantity} = ${(data.product!.price! * data.quantity!).currencyFormatRp}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
