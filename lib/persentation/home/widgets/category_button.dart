import 'package:flutter/material.dart';
import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/data/models/responses/category_response_model.dart';

class CategoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;
  final Category data;

  const CategoryButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                data.image!.contains('http')
                    ? data.image!
                    : '${Variables.baseUrlImage}${data.image}',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            //  ClipRRect(
            //  borderRadius: BorderRadius.circular(5.0),
            //       child: Image.network(
            //         data.image!.contains('http')
            //             ? data.image!
            //             : '${Variables.baseUrlImage}${data.image}',
            //         width: 170.0,
            //         height: 112.0,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            SizedBox(
              width: 70.0,
              child: Text(
                label,
                style: const TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
