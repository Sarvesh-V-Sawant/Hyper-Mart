import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperMart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CategoriesScreen(), // Categories screen
    CartScreen(), // This will be the cart screen
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Button
            CustomNavButton(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              isActive: _currentIndex == 0,
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),

            // Categories Button
            CustomNavButton(
              icon: Icons.grid_view_outlined,
              activeIcon: Icons.grid_view,
              isActive: _currentIndex == 1,
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),

            // Shopping Cart Button (Orange Circle - Always Center)
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFFF8C42),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF8C42).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            // Wishlist Button
            CustomNavButton(
              icon: Icons.favorite_border_outlined,
              activeIcon: Icons.favorite,
              isActive: _currentIndex == 3,
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),

            // Profile Button
            CustomNavButton(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              isActive: _currentIndex == 4,
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavButton extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const CustomNavButton({
    Key? key,
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF4AB786).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? Color(0xFF4AB786) : Colors.grey[400],
          size: 28,
        ),
      ),
    );
  }
}