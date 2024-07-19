import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/persentation/home/pages/category_products_page.dart';

import '../../bloc/category/category_bloc.dart';
import '../category_button.dart';

class MenuCategories extends StatefulWidget {
  const MenuCategories({super.key});

  @override
  State<MenuCategories> createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(const CategoryEvent.getCategories());
    super.initState();
  }



@override
Widget build(BuildContext context) {
  return BlocBuilder<CategoryBloc, CategoryState>(
    builder: (context, state) {
      
      return state.maybeWhen(
        loaded: (categories) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories.map((category) {
                return SizedBox(
                  width: 85,
                  // height: 60,
                  child: CategoryButton(
                    imagePath: category.image!,
                    label: category.name!,
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context){
                          return CategoryProductsPage(id: category.id!, label: category.name!);
                        },

                      ),
                      );
                    },
                    data: category,
                  ),
                );
              }).toList(),
            ),
          );
        },
        orElse: () {
          return const SizedBox.shrink();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (message) {
          return Center(
            child: Text(message),
          );
        },
      );
    },
  );
}
}

        //   return Row(
        //   children: [
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuBestseller.path,
        //         label: 'Bestseller',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuFlashsale.path,
        //         label: 'Flashsale',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuToprated.path,
        //         label: 'Toprated',
        //         onPressed: () {},
        //       ),
        //     ),
        //     Flexible(
        //       child: CategoryButton(
        //         imagePath: Assets.images.categories.menuMore.path,
        //         label: 'More',
        //         onPressed: () {},
        //       ),
        //     ),
        //   ],
        // );
