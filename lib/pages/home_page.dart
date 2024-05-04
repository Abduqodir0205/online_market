import 'package:flutter/material.dart';

Color backgroundColorBtn = Colors.white;
Color iconAndTextColor = Colors.black;

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Hello. Welcome 👋'),
                    const Text(
                      'Abdusattorov Abduqodir',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user.jpg"),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 194, 194, 194)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Mahsulotlarni qidirish:',
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
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
            SizedBox(height: 20),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  buildElevatedButton('All items', Icons.category_outlined),
                  SizedBox(width: 15),
                  buildElevatedButton('Dress', Icons.diversity_1_sharp),
                  SizedBox(width: 15),
                  buildElevatedButton('Hat', Icons.houseboat_outlined),
                  SizedBox(width: 15),
                  buildElevatedButton('Watch', Icons.watch),
                  SizedBox(width: 15),
                  buildElevatedButton('Pant', Icons.panorama_vertical_outlined),
                ],
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(
                    (products.length / 2)
                        .ceil(), // Divide by 2 to handle odd number of products
                    (index) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: buildCardProduct(
                              products[index * 2]["title"],
                              products[index * 2]["label"],
                              products[index * 2]["price"],
                              products[index * 2]["star"],
                              products[index * 2]["imgPath"],
                            ),
                          ),
                          SizedBox(width: 10), // Add spacing between cards
                          Expanded(
                            child: (index * 2 + 1 < products.length)
                                ? buildCardProduct(
                                    products[index * 2 + 1]["title"],
                                    products[index * 2 + 1]["label"],
                                    products[index * 2 + 1]["price"],
                                    products[index * 2 + 1]["star"],
                                    products[index * 2 + 1]["imgPath"],
                                  )
                                : SizedBox(), // In case of odd number of products
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: const Color.fromARGB(255, 31, 31, 31),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 209, 200, 200).withOpacity(0.8),
              spreadRadius: 80,
              blurRadius: 70,
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
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.diversity_1_sharp),
              label: 'Dress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.houseboat_outlined),
              label: 'Hat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch),
              label: 'Watch',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardProduct(
      String title, String label, double price, double star, String imgPath) {
    return Card(
      color: Colors.white, // Karta rangi
      elevation: 4, // Karta ko'plab kengaytma
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Karta shakli
      ),
      child: SizedBox(
        // width: 200, // Karta kengligi
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200, // Rasmning balandligi
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imgPath),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  8, 8, 8, 8), // Yuqoridagi Paddingni o'zgartirdik
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        price.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.amber[300],
                      ),
                      Text(
                        star.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton(String text, IconData icon) {
    return ElevatedButton(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconAndTextColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: iconAndTextColor),
          )
        ],
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColorBtn,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius of 50
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> products = [
  {
    "title": "Product 1",
    "label": "Label 1",
    "price": 100.0,
    "star": 4.5,
    "imgPath": "assets/images/user.jpg",
  },
  {
    "title": "Product 2",
    "label": "Label 2",
    "price": 150.0,
    "star": 4.2,
    "imgPath": "assets/images/product2.jpg",
  },
  {
    "title": "Product 1",
    "label": "Label 1",
    "price": 100.0,
    "star": 4.5,
    "imgPath": "assets/images/product1.jpg",
  },
  {
    "title": "Product 2",
    "label": "Label 2",
    "price": 150.0,
    "star": 4.2,
    "imgPath": "assets/images/product2.jpg",
  },
  {
    "title": "Product 1",
    "label": "Label 1",
    "price": 100.0,
    "star": 4.5,
    "imgPath": "assets/images/product1.jpg",
  },
  {
    "title": "Product 2",
    "label": "Label 2",
    "price": 150.0,
    "star": 4.2,
    "imgPath": "assets/images/product2.jpg",
  },
  // Add more products as needed
];
