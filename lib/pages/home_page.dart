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
            Expanded(
              child: DynamicCardGrid(),
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
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class DynamicCardGrid extends StatefulWidget {
  @override
  _DynamicCardGridState createState() => _DynamicCardGridState();
}

class _DynamicCardGridState extends State<DynamicCardGrid> {
  List<Widget> cards = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return cards[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    addCards();
  }

  void addCards() {
    for (int i = 0; i < 6; i++) {
      cards.add(buildCardProduct('Title $i', 'Label $i', 20.0 + i,
          4.0 - i * 0.5, 'assets/images/user.jpg'));
    }
  }

  Widget buildCardProduct(
      String title, String label, double price, double star, String imagePath) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                width: 210,
                height: 180,
                imagePath,
                fit: BoxFit.cover, // Rasmlarni kichik o'lchamda chiqarish
              ),
              IconButton(
                onPressed: () {
                  // Yuqori o'ng tomonda yurak iconi bosilganda amalni qo'shing
                },
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < star ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
