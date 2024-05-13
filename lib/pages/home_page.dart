import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routing_router/pages/product_details_page.dart';
import 'package:routing_router/prodacts.dart';
import '../components/user_acc.dart';
import '../components/bottom_navigator_bar.dart';
import './shop_bag.dart'; // Import ShopBag page
import './favorite_page.dart'; // Import FavoritePage
import './login_page.dart'; // Import LoginPage

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentIndex = 0;
  TextEditingController _searchController =
      TextEditingController(); // Controller for TextField
  List<Map<String, dynamic>> filteredProducts =
      List.from(products); // Initialize filteredProducts

  @override
  void dispose() {
    _searchController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigatorBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return buildCardPositions(context); // Display IntroPage content
      case 1:
        return ShopBag(); // Display ShopBagPage content
      case 2:
        return FavoritePage(); // Display FavoritePage content
      case 3:
        return LoginPage(); // Display AccountPage content
      default:
        return Container(); // Return a default widget if necessary
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildElevatedButton(String text, IconData icon) {
    return ElevatedButton(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildCardPositions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAcc(),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _searchController, // Assign the controller
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 194, 194, 194),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Mahsulotlarni qidirish:',
                          labelStyle: TextStyle(fontSize: 16),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredProducts = products
                                .where((product) => product['title']
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 6),
            child: Row(
              children: <Widget>[
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add),
                SizedBox(
                  width: 10,
                ),
                buildElevatedButton("jahfbda", Icons.add)
              ],
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Card dimensions
              double cardWidth = 200; // Fixed width of your card
              double cardHeight = 280; // Fixed height of your card

              // Screen width
              double screenWidth = constraints.maxWidth;

              // Number of cards
              int numberOfCards = (screenWidth / cardWidth).floor();

              // Adjust number of cards
              numberOfCards = numberOfCards == 0 ? 1 : numberOfCards;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfCards,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: cardWidth /
                      cardHeight, // width / height ratio of your card
                ),
                padding: EdgeInsets.symmetric(horizontal: 25),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: filteredProducts[index]["title"],
                    label: filteredProducts[index]["label"],
                    price: filteredProducts[index]["price"],
                    star: filteredProducts[index]["star"],
                    imgPath: filteredProducts[index]["imgPath"],
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
