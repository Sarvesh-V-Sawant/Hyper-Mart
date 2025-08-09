import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: AppTextStyles.buttonText.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onMicPressed;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onMicPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textSecondary),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.poppinsBody.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onMicPressed,
            child: Icon(Icons.mic, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(16),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColors.cardBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class LocationChip extends StatelessWidget {
  final String location;
  final VoidCallback? onTap;

  const LocationChip({
    Key? key,
    required this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              location,
              style: AppTextStyles.poppinsCaptionMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const ProfileAvatar({
    Key? key,
    this.size = 40,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.accent,
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Icon(
          Icons.person,
          color: iconColor ?? AppColors.secondary,
          size: size * 0.6,
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;

  const RatingWidget({
    Key? key,
    required this.rating,
    this.size = 16,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          color: color ?? Colors.amber,
          size: size,
        ),
        SizedBox(width: 4),
        Text(
          rating.toString(),
          style: AppTextStyles.poppinsCaption.copyWith(
            fontSize: size * 0.75,
          ),
        ),
      ],
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: onDecrement,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        Container(
          width: 40,
          child: Text(
            quantity.toString(),
            style: AppTextStyles.poppinsBodyBold,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: onIncrement,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}