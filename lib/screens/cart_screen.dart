import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onNavigateToHome;

  const CartScreen({
    Key? key,
    required this.onNavigateToHome,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Strawberries',
      price: 10,
      originalPrice: 15,
      quantity: 2,
      imagePath: 'assets/images/strawberries.jpg',
      offer: '25% OFF',
      weight: '500g',
      rating: 4.8,
    ),
    CartItem(
      id: '2',
      name: 'Fried Chips',
      price: 12,
      originalPrice: 12,
      quantity: 1,
      imagePath: 'assets/images/chips.jpg',
      offer: '',
      weight: '200g',
      rating: 4.5,
    ),
    CartItem(
      id: '3',
      name: 'Coffee Maker',
      price: 299,
      originalPrice: 350,
      quantity: 1,
      imagePath: 'assets/images/coffee_maker.jpg',
      offer: '15% OFF',
      weight: '1 piece',
      rating: 4.9,
    ),
    CartItem(
      id: '4',
      name: 'Headphones',
      price: 89,
      originalPrice: 110,
      quantity: 1,
      imagePath: 'assets/images/headphones.jpg',
      offer: '20% OFF',
      weight: '1 piece',
      rating: 4.7,
    ),
  ];

  String selectedPaymentMethod = 'cash';
  bool showCouponField = false;
  String couponCode = '';
  double couponDiscount = 0;

  double get subtotal {
    return cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  double get totalOriginalPrice {
    return cartItems.fold(0, (total, item) => total + (item.originalPrice * item.quantity));
  }

  double get deliveryFee => subtotal > 500 ? 0 : 40;
  double get taxes => subtotal * 0.05; // 5% tax
  double get totalSavings => totalOriginalPrice - subtotal + couponDiscount;
  double get grandTotal => subtotal + deliveryFee + taxes - couponDiscount;

  void updateQuantity(String itemId, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        cartItems.removeWhere((item) => item.id == itemId);
      } else {
        final itemIndex = cartItems.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          cartItems[itemIndex].quantity = newQuantity;
        }
      }
    });
  }

  void removeItem(String itemId) {
    setState(() {
      cartItems.removeWhere((item) => item.id == itemId);
    });
  }

  void applyCoupon() {
    if (couponCode.toLowerCase() == 'save10') {
      setState(() {
        couponDiscount = subtotal * 0.1; // 10% discount
        showCouponField = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coupon applied! ₹${couponDiscount.toInt()} discount'),
          backgroundColor: Color(0xFF4AB786),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid coupon code'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      children: [
        // Header
        _buildHeader(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFF4AB786).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 60,
                    color: Color(0xFF4AB786),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Add items to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: widget.onNavigateToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4AB786),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Start Shopping',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        // Header
        _buildHeader(),

        Expanded(
          child: CustomScrollView(
            slivers: [
              // Cart Items
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index < cartItems.length) {
                      return _buildCartItem(cartItems[index]);
                    }
                    return null;
                  },
                  childCount: cartItems.length,
                ),
              ),

              // Savings Info
              SliverToBoxAdapter(
                child: _buildSavingsInfo(),
              ),

              // Coupon Section
              SliverToBoxAdapter(
                child: _buildCouponSection(),
              ),

              // Payment Methods
              SliverToBoxAdapter(
                child: _buildPaymentMethods(),
              ),

              // Price Breakdown
              SliverToBoxAdapter(
                child: _buildPriceBreakdown(),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),

        // Bottom Checkout Bar
        _buildCheckoutBar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Removed back button - empty container to maintain spacing
          SizedBox(width: 40), // Maintains spacing where back button was
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (cartItems.isNotEmpty)
                    Text(
                      '${cartItems.length} item${cartItems.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (cartItems.isNotEmpty)
            GestureDetector(
              onTap: () {
                // Clear cart dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Clear Cart'),
                    content: Text('Are you sure you want to remove all items?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            cartItems.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Clear',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.grey[700],
                  size: 20,
                ),
              ),
            )
          else
            SizedBox(width: 40), // Maintains spacing when cart is empty
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                // Actual image with fallback
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imagePath,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
                // Offer badge
                if (item.offer.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFEA7173),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        item.offer,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => removeItem(item.id),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  item.weight,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '${item.rating}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '₹${item.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4AB786),
                      ),
                    ),
                    if (item.originalPrice > item.price) ...[
                      SizedBox(width: 8),
                      Text(
                        '₹${item.originalPrice}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8),

          // Quantity Controls
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => updateQuantity(item.id, item.quantity - 1),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Color(0xFFEA7173),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${item.quantity}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => updateQuantity(item.id, item.quantity + 1),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Color(0xFF4AB786),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '₹${(item.price * item.quantity).toInt()}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsInfo() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF4AB786).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF4AB786),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.savings_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are saving ₹${totalSavings.toInt()}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4AB786),
                  ),
                ),
                Text(
                  'Great job on finding these deals!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (!showCouponField && couponDiscount == 0)
            GestureDetector(
              onTap: () {
                setState(() {
                  showCouponField = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_offer_outlined, color: Color(0xFF4AB786)),
                    SizedBox(width: 12),
                    Text(
                      'Apply Coupon Code',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4AB786),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          if (showCouponField)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF4AB786)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => couponCode = value,
                          decoration: InputDecoration(
                            hintText: 'Enter coupon code',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: applyCoupon,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFF4AB786),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try: SAVE10 for 10% off',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          if (couponDiscount > 0)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF4AB786).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF4AB786)),
                  SizedBox(width: 12),
                  Text(
                    'Coupon applied! Saved ₹${couponDiscount.toInt()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4AB786),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          _buildPaymentOption('cash', 'Cash on Delivery', Icons.money),
          _buildPaymentOption('card', 'Credit/Debit Card', Icons.credit_card),
          _buildPaymentOption('upi', 'UPI Payment', Icons.account_balance_wallet),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == value ? Color(0xFF4AB786) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selectedPaymentMethod == value ? Color(0xFF4AB786).withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selectedPaymentMethod == value ? Color(0xFF4AB786) : Colors.grey[600],
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selectedPaymentMethod == value ? FontWeight.w600 : FontWeight.normal,
                color: selectedPaymentMethod == value ? Color(0xFF4AB786) : Colors.black,
              ),
            ),
            Spacer(),
            if (selectedPaymentMethod == value)
              Icon(
                Icons.check_circle,
                color: Color(0xFF4AB786),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildPriceRow('Item Total', subtotal),
          _buildPriceRow('Delivery Fee', deliveryFee),
          _buildPriceRow('Taxes & Fees', taxes),
          if (couponDiscount > 0)
            _buildPriceRow('Coupon Discount', -couponDiscount, isDiscount: true),
          Divider(height: 24),
          _buildPriceRow('Grand Total', grandTotal, isBold: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false, bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Color(0xFF4AB786) : Colors.black,
            ),
          ),
          Text(
            '${amount < 0 ? '-' : ''}₹${amount.abs().toInt()}',
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Color(0xFF4AB786) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹${grandTotal.toInt()}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4AB786),
                ),
              ),
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Proceed to checkout
                _showCheckoutDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4AB786),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
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
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF4AB786)),
            SizedBox(width: 8),
            Text('Order Placed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your order has been placed successfully.'),
            SizedBox(height: 8),
            Text(
              'Order ID: #${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Total: ₹${grandTotal.toInt()}'),
            Text('Payment: ${selectedPaymentMethod == 'cash' ? 'Cash on Delivery' : selectedPaymentMethod.toUpperCase()}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              setState(() {
                cartItems.clear();
              });
            },
            child: Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final int price;
  final int originalPrice;
  int quantity;
  final String imagePath;
  final String offer;
  final String weight;
  final double rating;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.imagePath,
    required this.offer,
    required this.weight,
    required this.rating,
  });
}