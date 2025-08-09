import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'My Wishlist',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                '6 items in your wishlist',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 24),

              // Wishlist Items with Real Images
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: [
                    WishlistItemCard(
                      title: 'Wireless Headphones',
                      price: '₹2,999',
                      originalPrice: '₹3,999',
                      rating: 4.5,
                      discount: '25% OFF',
                      color: Color(0xFF6B73FF),
                      imagePath: 'assets/images/headphones.jpg',
                    ),
                    WishlistItemCard(
                      title: 'Smart Watch',
                      price: '₹8,999',
                      originalPrice: '₹12,999',
                      rating: 4.3,
                      discount: '30% OFF',
                      color: Color(0xFF4AB786),
                      imagePath: 'assets/images/smartwatch.jpg',
                    ),
                    WishlistItemCard(
                      title: 'Running Shoes',
                      price: '₹4,599',
                      originalPrice: '₹5,999',
                      rating: 4.7,
                      discount: '23% OFF',
                      color: Color(0xFFEA7173),
                      imagePath: 'assets/images/running_shoes.jpg',
                    ),
                    WishlistItemCard(
                      title: 'Coffee Maker',
                      price: '₹6,799',
                      originalPrice: '₹8,999',
                      rating: 4.2,
                      discount: '24% OFF',
                      color: Color(0xFFFFB800),
                      imagePath: 'assets/images/coffee_maker.jpg',
                    ),
                    WishlistItemCard(
                      title: 'Bluetooth Speaker',
                      price: '₹1,899',
                      originalPrice: '₹2,499',
                      rating: 4.4,
                      discount: '24% OFF',
                      color: Color(0xFF6B73FF),
                      imagePath: 'assets/images/bluetooth_speaker.jpg',
                    ),
                    WishlistItemCard(
                      title: 'Desk Lamp',
                      price: '₹1,299',
                      originalPrice: '₹1,799',
                      rating: 4.1,
                      discount: '28% OFF',
                      color: Color(0xFF4AB786),
                      imagePath: 'assets/images/desk_lamp.jpg',
                    ),
                  ],
                ),
              ),

              // Bottom Action Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Add all to cart functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4AB786),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add All to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WishlistItemCard extends StatefulWidget {
  final String title;
  final String price;
  final String originalPrice;
  final double rating;
  final String discount;
  final Color color;
  final String imagePath;

  const WishlistItemCard({
    Key? key,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.discount,
    required this.color,
    required this.imagePath,
  }) : super(key: key);

  @override
  _WishlistItemCardState createState() => _WishlistItemCardState();
}

class _WishlistItemCardState extends State<WishlistItemCard> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Area
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(
                            _getIconForProduct(widget.title),
                            size: 48,
                            color: widget.color,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Discount Badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFEA7173),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.discount,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Heart Icon
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Color(0xFFEA7173) : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        widget.rating.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Price Row
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4AB786),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.originalPrice,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Add to Cart Button
                  Container(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.title} added to cart!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4AB786),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForProduct(String title) {
    if (title.toLowerCase().contains('headphones')) return Icons.headphones;
    if (title.toLowerCase().contains('watch')) return Icons.watch;
    if (title.toLowerCase().contains('shoes')) return Icons.directions_run;
    if (title.toLowerCase().contains('coffee')) return Icons.coffee_maker;
    if (title.toLowerCase().contains('speaker')) return Icons.speaker;
    if (title.toLowerCase().contains('lamp')) return Icons.lightbulb;
    return Icons.shopping_bag;
  }
}