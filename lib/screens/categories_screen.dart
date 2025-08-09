import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filters = ['All', 'Popular', 'New', 'Trending'];

  final List<CategoryItem> _categories = [
    CategoryItem('Groceries', 'Fresh vegetables, fruits & daily essentials', 'assets/images/groceries.jpg', Color(0xFF4AB786), '2.5k+ items'),
    CategoryItem('Electronics', 'Phones, laptops, gadgets & accessories', 'assets/images/electronics.jpg', Color(0xFF6B73FF), '1.8k+ items'),
    CategoryItem('Fashion', 'Clothing, shoes, bags & accessories', 'assets/images/fashion.jpg', Color(0xFFFF6B6B), '3.2k+ items'),
    CategoryItem('Mobiles', 'Smartphones, tablets & mobile accessories', 'assets/images/mobiles.jpg', Color(0xFFFFB800), '890+ items'),
    CategoryItem('Home & Kitchen', 'Appliances, furniture & home decor', 'assets/images/washing_machine.jpg', Color(0xFF9C27B0), '1.5k+ items'),
    CategoryItem('Beauty & Personal Care', 'Skincare, makeup & personal hygiene', 'assets/images/strawberries.jpg', Color(0xFFE91E63), '750+ items'),
    CategoryItem('Sports & Fitness', 'Gym equipment, sportswear & accessories', 'assets/images/running_shoes.jpg', Color(0xFF00BCD4), '650+ items'),
    CategoryItem('Books & Stationery', 'Books, notebooks & office supplies', 'assets/images/chips.jpg', Color(0xFF795548), '420+ items'),
    CategoryItem('Automotive', 'Car accessories, tools & spare parts', 'assets/images/headphones.jpg', Color(0xFF607D8B), '330+ items'),
    CategoryItem('Baby & Kids', 'Toys, clothes & baby care products', 'assets/images/chair.jpg', Color(0xFFFF9800), '580+ items'),
    CategoryItem('Health & Wellness', 'Medicines, supplements & health devices', 'assets/images/coffee_maker.jpg', Color(0xFF4CAF50), '290+ items'),
    CategoryItem('Pet Supplies', 'Pet food, toys & accessories', 'assets/images/desk_lamp.jpg', Color(0xFF8BC34A), '180+ items'),
  ];

  List<CategoryItem> get _filteredCategories {
    List<CategoryItem> filtered = _categories;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((category) =>
      category.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          category.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    // Apply filters (for demo, just returning all for now)
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Header
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600]),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search categories...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.mic, color: Color(0xFF4AB786)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Filter Chips
                    Container(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        itemBuilder: (context, index) {
                          final filter = _filters[index];
                          final isSelected = _selectedFilter == filter;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Color(0xFF4AB786) : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.grey[700],
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Categories Stats
                    Row(
                      children: [
                        Text(
                          '${_filteredCategories.length} Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.grid_view, color: Color(0xFF4AB786), size: 20),
                            SizedBox(width: 8),
                            Icon(Icons.list, color: Colors.grey[400], size: 20),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Categories Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final category = _filteredCategories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        // Navigate to category products
                        print('Tapped on ${category.name}');
                        _showCategoryDialog(category);
                      },
                    );
                  },
                  childCount: _filteredCategories.length,
                ),
              ),
            ),

            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(CategoryItem category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 5,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _getIconForCategory(category.name),
                size: 40,
                color: category.color,
              ),
            ),
            SizedBox(height: 16),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                category.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category.itemCount,
                style: TextStyle(
                  color: category.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to category products
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: category.color,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'View Products',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'groceries':
        return Icons.local_grocery_store;
      case 'electronics':
        return Icons.electrical_services;
      case 'fashion':
        return Icons.shopping_bag;
      case 'mobiles':
        return Icons.phone_android;
      case 'home & kitchen':
        return Icons.kitchen;
      case 'beauty & personal care':
        return Icons.face;
      case 'sports & fitness':
        return Icons.fitness_center;
      case 'books & stationery':
        return Icons.menu_book;
      case 'automotive':
        return Icons.directions_car;
      case 'baby & kids':
        return Icons.child_care;
      case 'health & wellness':
        return Icons.health_and_safety;
      case 'pet supplies':
        return Icons.pets;
      default:
        return Icons.category;
    }
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Image/Icon Container
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  // Background Pattern
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Category Icon
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _getIconForCategory(category.name),
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  // Item Count Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        category.itemCount.split('+')[0] + '+',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: category.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Category Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: category.color,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 12,
                            color: category.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'groceries':
        return Icons.local_grocery_store;
      case 'electronics':
        return Icons.electrical_services;
      case 'fashion':
        return Icons.shopping_bag;
      case 'mobiles':
        return Icons.phone_android;
      case 'home & kitchen':
        return Icons.kitchen;
      case 'beauty & personal care':
        return Icons.face;
      case 'sports & fitness':
        return Icons.fitness_center;
      case 'books & stationery':
        return Icons.menu_book;
      case 'automotive':
        return Icons.directions_car;
      case 'baby & kids':
        return Icons.child_care;
      case 'health & wellness':
        return Icons.health_and_safety;
      case 'pet supplies':
        return Icons.pets;
      default:
        return Icons.category;
    }
  }
}

class CategoryItem {
  final String name;
  final String description;
  final String imagePath;
  final Color color;
  final String itemCount;

  CategoryItem(this.name, this.description, this.imagePath, this.color, this.itemCount);
}