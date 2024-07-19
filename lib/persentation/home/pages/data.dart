import 'package:flutter/material.dart';

// Dummy Category model
class Category {
  final String name;
  final String image;
  Category({required this.name, required this.image});
}

// Dummy CategoryButton widget
class CategoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;
  final Category data;

  CategoryButton({
    required this.imagePath,
    required this.label,
    required this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Image.network(imagePath, width: 40, height: 40),
          Text(label),
        ],
      ),
    );
  }
}

// Your main widget
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final ScrollController _scrollController = ScrollController();
  late Category selectedCategory;

  // Dummy data
  final List<Category> categories = [
    Category(name: 'Category 1', image: 'https://via.placeholder.com/40'),
    Category(name: 'Category 2', image: 'https://via.placeholder.com/40'),
    // Add more categories as needed
  ];

  @override
  void initState() {
    super.initState();
    // Set the default selected category to the first one in the list
    selectedCategory = categories[0];
  }

  void selectCategory(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories.map((category) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 80,
                  height: 60,
                  child: CategoryButton(
                    imagePath: category.image,
                    label: category.name,
                    onPressed: () => selectCategory(category),
                    data: category,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('Selected Category: ${selectedCategory.name}'),
        // Display more details or content related to the selected category
        const Text('czcmzx,cmz,cmz,cmz,mcz,cz'),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Text('Selected Category: ${selectedCategory.name}'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: CategoryList(),
    ),
  ));
}
