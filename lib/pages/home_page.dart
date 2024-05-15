import 'package:flutter/material.dart';
import '../components/user_acc.dart';
import '../components/bottom_navigator_bar.dart';
import './shop_bag.dart'; // ShopBag sahifasini import qilish
import './favorite_page.dart'; // FavoritePage sahifasini import qilish
import './login_page.dart'; // LoginPage sahifasini import qilish
import '../pages/product_details_page.dart'; // ProductDetailsPage sahifasini import qilish
import '../prodacts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentIndex = 0;
  String _selectedCategory = ""; // Tanlangan kategoriya
  List<Map<String, dynamic>> filteredProducts =
      List.from(products); // Filtrlangan mahsulotlar ro'yxati

  TextEditingController _searchController =
      TextEditingController(); // TextField uchun controller

  @override
  void dispose() {
    _searchController.dispose(); // O'chirish
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigatorBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        isAddToCartPressed: indexes_card.length > 0,
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return buildCardPositions(context); // IntroPage tarkibini ko'rsatish
      case 1:
        return ShopBag(); // ShopBagPage tarkibini ko'rsatish
      case 2:
        return FavoritePage(); // FavoritePage tarkibini ko'rsatish
      case 3:
        return LoginPage(); // AccountPage tarkibini ko'rsatish
      default:
        return Container(); // Agar kerak bo'lsa sukutli widgetni qaytarish
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildElevatedButton(String text, String icon) {
    return ElevatedButton(
      child: Row(
        children: <Widget>[
          Image.network(icon),
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
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                        controller:
                            _searchController, // Controller ni o'zlashtirish
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
                      onPressed: () {
                        _showCategoryDialog(context);
                      },
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
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Card o'lchamlari
              double cardWidth = 180; // Karta o'lchamining o'zlashtirilgan eni
              double cardHeight = 330 -
                  ((constraints.maxWidth + 250))
                      .clamp(0, 20); // Karta o'lchamining o'zlashtirilgan bo'yi

              // Ekranning eni
              double screenWidth = constraints.maxWidth;

              // Kartalar soni
              int numberOfCards = (screenWidth / cardWidth).floor();

              // Kartalar sonini o'zgartirish
              numberOfCards = numberOfCards == 0 ? 1 : numberOfCards;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfCards,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: cardWidth /
                      cardHeight, // Karta o'lchamining eni va bo'yi nisbati
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

  // Kategoriya modal oynasini ko'rsatish uchun funktsiya
  Future<void> _showCategoryDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kategoriyani tanlang'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildCategoryItem(
                    "Hammasi"), // Barcha mahsulotlar uchun kategoriya
                _buildCategoryItem("Kurtka"),
                _buildCategoryItem("Futbolka"),
                _buildCategoryItem("Shim"),
                _buildCategoryItem("Ko'ylak"),
                _buildCategoryItem("So'mka"),
                // Qo'shimcha kategoriyalar
              ],
            ),
          ),
        );
      },
    );
  }

  // Kategoriya tanlovini qurish uchun qism
  Widget _buildCategoryItem(String category) {
    return ListTile(
      title: Text(category),
      onTap: () {
        setState(() {
          _selectedCategory = category;
          if (_selectedCategory == "Hammasi") {
            filteredProducts = List.from(products); // Barcha mahsulotlar
          } else {
            filteredProducts = products
                .where((product) =>
                    product['category'].toString().toLowerCase() ==
                    _selectedCategory.toLowerCase())
                .toList(); // Tanlangan kategoriyaga mos keladigan mahsulotlar
          }
        });
        Navigator.of(context).pop(); // Modal oynani yopish
      },
    );
  }
}
