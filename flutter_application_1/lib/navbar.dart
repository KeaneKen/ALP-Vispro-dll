import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.cartCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      backgroundColor: Colors.transparent,
      color: const Color(0xFFACC270),
      buttonBackgroundColor: const Color(0xFFEA9B03),
      height: 70,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      onTap: onTap,
      items: [
        Icon(
          currentIndex == 0 ? Icons.home : Icons.home_outlined,
          size: 30,
          color: currentIndex == 0 ? Colors.white : const Color(0xFF40250D),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              currentIndex == 1 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              size: 30,
              color: currentIndex == 1 ? Colors.white : const Color(0xFF40250D),
            ),
            if (cartCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      cartCount > 99 ? '99+' : cartCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Icon(
          currentIndex == 2 ? Icons.chat : Icons.chat_bubble_outline,
          size: 30,
          color: currentIndex == 2 ? Colors.white : const Color(0xFF40250D),
        ),
        Icon(
          currentIndex == 3 ? Icons.person : Icons.person_outline,
          size: 30,
          color: currentIndex == 3 ? Colors.white : const Color(0xFF40250D),
        ),
      ],
    );
  }
}
