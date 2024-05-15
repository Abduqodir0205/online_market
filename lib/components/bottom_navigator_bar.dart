import 'package:flutter/material.dart';
import 'package:routing_router/pages/home_page.dart';
import 'package:routing_router/pages/favorite_page.dart';
import 'package:routing_router/pages/intro_page.dart';
import 'package:routing_router/pages/shop_bag.dart';
import 'package:routing_router/pages/account_page.dart';
import 'package:routing_router/prodacts.dart';

class BottomNavigatorBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final bool isAddToCartPressed;

  const BottomNavigatorBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.isAddToCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: const Color.fromARGB(255, 31, 31, 31),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 209, 200, 200).withOpacity(0.8),
            spreadRadius: 50,
            blurRadius: 60,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 100,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Uy',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_bag),
                if (isAddToCartPressed)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Savat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Yoqtirilgan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Qo\'shish',
          ),
        ],
      ),
    );
  }
}

class YourParentWidget extends StatefulWidget {
  const YourParentWidget({Key? key}) : super(key: key);

  @override
  _YourParentWidgetState createState() => _YourParentWidgetState();
}

class _YourParentWidgetState extends State<YourParentWidget> {
  int _currentIndex = 0;
  bool _isAddToCartPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigatorBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        isAddToCartPressed: _isAddToCartPressed,
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
      // return ShopBagPage();
      case 2:
        return FavoritePage();
      case 3:
        return AccountPage();
      default:
        return Container(); // Return a default widget if necessary
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _isAddToCartPressed = (index == 1);
    });
  }
}
