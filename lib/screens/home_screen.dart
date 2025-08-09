import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _offerPageController = PageController();
  ScrollController _categoryController = ScrollController();
  Timer? _timer;
  int _currentOfferIndex = 0;

  // Add quantity state management for popular deals
  Map<int, int> _quantities = {
    0: 2,
    1: 2,
    2: 2,
    3: 2,
  };

  final List<OfferCard> offers = [
    OfferCard(
      title: 'Happy Weekend',
      discount: '25% OFF',
      subtitle: 'On All Fruits',
      imagePath: 'assets/images/vegetables_offer.jpg',
    ),
    OfferCard(
      title: 'Fresh Vegetables',
      discount: '30% OFF',
      subtitle: 'Farm Fresh Daily',
      imagePath: 'assets/images/strawberries.jpg',
    ),
    OfferCard(
      title: 'Electronics Sale',
      discount: '40% OFF',
      subtitle: 'Latest Gadgets',
      imagePath: 'assets/images/electronics.jpg',
    ),
  ];

  final List<Category> categories = [
    Category('Groceries', 'assets/images/groceries.jpg', Color(0xFF4AB786)),
    Category('Electronics', 'assets/images/electronics.jpg', Color(0xFF6B73FF)),
    Category('Fashion', 'assets/images/fashion.jpg', Color(0xFFFF6B6B)),
    Category('Mobiles', 'assets/images/mobiles.jpg', Color(0xFFFFB800)),
    Category('Appliances', 'assets/images/washing_machine.jpg', Color(0xFF9C27B0)),
    Category('Beauty', 'assets/images/strawberries.jpg', Color(0xFFE91E63)),
  ];

  final List<PreviousOrderItem> previousOrders = [
    PreviousOrderItem('Oil', 'assets/images/strawberries.jpg', 1),
    PreviousOrderItem('Bread', 'assets/images/chips.jpg', 1),
    PreviousOrderItem('Sauce', 'assets/images/coffee_maker.jpg', 2),
    PreviousOrderItem('More', '', 5),
  ];

  final List<PopularDeal> popularDeals = [
    PopularDeal('Strawberries', 10, 4.8, 'assets/images/strawberries.jpg', '25% OFF'),
    PopularDeal('Fried Chips', 12, 4.5, 'assets/images/chips.jpg', ''),
    PopularDeal('Coffee Maker', 299, 4.9, 'assets/images/coffee_maker.jpg', '15% OFF'),
    PopularDeal('Headphones', 89, 4.7, 'assets/images/headphones.jpg', '20% OFF'),
  ];

  final List<TopBrand> topBrands = [
    TopBrand('Hollister', 'assets/images/hollister.png'),
    TopBrand('Chanel', 'assets/images/chanel.png'),
    TopBrand('Prada', 'assets/images/prada.png'),
    TopBrand('Nike', 'assets/images/nike.png'),
    TopBrand('Adidas', 'assets/images/adidas.png'),
    TopBrand('Zara', 'assets/images/zara.png'),
  ];

  final List<BeautyDeal> beautyDeals = [
    BeautyDeal('Revlon', 'Upto\n40% Off', 'assets/images/revlon.png'),
    BeautyDeal('Lakme', 'Upto\n30% Off', 'assets/images/lakme.png'),
    BeautyDeal('Garnier', 'Upto\n25% Off', 'assets/images/garnier.png'),
    BeautyDeal('Maybelline', 'Upto\n35% Off', 'assets/images/maybelline.png'),
    BeautyDeal('Clinique', 'Upto\n45% Off', 'assets/images/clinique.png'),
    BeautyDeal('Sugar', 'Upto\n30% Off', 'assets/images/sugar.png'),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentOfferIndex < offers.length - 1) {
        _currentOfferIndex++;
      } else {
        _currentOfferIndex = 0;
      }
      _offerPageController.animateToPage(
        _currentOfferIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _offerPageController.dispose();
    _categoryController.dispose();
    super.dispose();
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
                    // Top Header Row
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFF4AB786),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Bangalore',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          'HyperMart',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4AB786),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            // Language Selection
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Eng',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Notification Bell (moved to profile position)
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Address Row
                    Row(
                      children: [
                        Text(
                          'JPM Layout, 560076',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
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
                            child: Text(
                              'Search Anything..',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(Icons.mic, color: Color(0xFF4AB786)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Auto-scrolling Offer Cards
                    Container(
                      height: 140,
                      child: PageView.builder(
                        controller: _offerPageController,
                        itemCount: offers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF4AB786),
                                  Color(0xFF4AB786).withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -20,
                                  top: -20,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        offers[index].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        offers[index].discount,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        offers[index].subtitle,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Categories Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Scrollable Categories
                    Container(
                      height: 100,
                      child: ListView.builder(
                        controller: _categoryController,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: 12),
                            child: CategoryCard(
                              title: category.title,
                              imagePath: category.imagePath,
                              color: category.color,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Previous Order Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Previous Order',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFFEA7173),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Order Again',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Previous Order Details
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4AB786),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Delivered',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                'On Wed, 27 Jul 2022',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: previousOrders.map((item) {
                              if (item.title == 'More') {
                                return Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${item.quantity}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(item.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: item.quantity > 1
                                    ? Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEA7173),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${item.quantity}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : null,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                'Order ID: #2829299',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4AB786),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Order Again',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Final Total: ₹ 123',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Popular Deals Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Deals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
                      ],
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Popular Deals Grid
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final deal = popularDeals[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                image: DecorationImage(
                                  image: AssetImage(deal.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (deal.offer.isNotEmpty)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEA7173),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    deal.offer,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '₹ ${deal.price}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4AB786),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        '${deal.rating}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_quantities[index]! > 1) {
                                          _quantities[index] = _quantities[index]! - 1;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEA7173),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${_quantities[index]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _quantities[index] = _quantities[index]! + 1;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4AB786),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      print('Added ${deal.name} (${_quantities[index]}) to cart');
                                      // Add to cart logic here
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${deal.name} added to cart!'),
                                          duration: Duration(seconds: 1),
                                          backgroundColor: Color(0xFF4AB786),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFDAA5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Add to cart',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: popularDeals.length,
              ),
            ),

            // Top Brands Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Brands',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topBrands.length,
                        itemBuilder: (context, index) {
                          final brand = topBrands[index];
                          return Container(
                            width: 90,
                            margin: EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey[200]!),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(
                                      brand.logoPath,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              brand.name.substring(0, 1).toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exclusive Beauty Deals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
                      ],
                    ),
                    SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: beautyDeals.length,
                      itemBuilder: (context, index) {
                        final deal = beautyDeals[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Brand logo at top
                              Positioned(
                                top: 12,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 30,
                                  child: Image.asset(
                                    deal.logoPath,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          deal.brandName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Green circle with offer at bottom
                              Positioned(
                                bottom: 8,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4AB786),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        deal.offer,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom spacing for navigation bar
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForCategory(title),
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String title) {
    switch (title.toLowerCase()) {
      case 'groceries':
        return Icons.local_grocery_store;
      case 'electronics':
        return Icons.electrical_services;
      case 'fashion':
        return Icons.shopping_bag;
      case 'mobiles':
        return Icons.phone_android;
      case 'appliances':
        return Icons.kitchen;
      case 'beauty':
        return Icons.face;
      default:
        return Icons.category;
    }
  }
}

class OfferCard {
  final String title;
  final String discount;
  final String subtitle;
  final String imagePath;

  OfferCard({
    required this.title,
    required this.discount,
    required this.subtitle,
    required this.imagePath,
  });
}

class Category {
  final String title;
  final String imagePath;
  final Color color;

  Category(this.title, this.imagePath, this.color);
}

class PreviousOrderItem {
  final String title;
  final String imagePath;
  final int quantity;

  PreviousOrderItem(this.title, this.imagePath, this.quantity);
}

class PopularDeal {
  final String name;
  final int price;
  final double rating;
  final String imagePath;
  final String offer;

  PopularDeal(this.name, this.price, this.rating, this.imagePath, this.offer);
}

class TopBrand {
  final String name;
  final String logoPath;

  TopBrand(this.name, this.logoPath);
}

class BeautyDeal {
  final String brandName;
  final String offer;
  final String logoPath;

  BeautyDeal(this.brandName, this.offer, this.logoPath);
}