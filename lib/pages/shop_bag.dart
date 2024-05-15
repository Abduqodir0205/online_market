import 'package:flutter/material.dart';
import '../prodacts.dart';

class ShopBag extends StatefulWidget {
  const ShopBag({Key? key}) : super(key: key);

  @override
  _ShopBagState createState() => _ShopBagState();
}

class _ShopBagState extends State<ShopBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savat"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: (indexes_card.isEmpty) // Check if the cart is empty
            ? Center(
                child: Text("Savat bo'sh"),
              )
            : ListView.builder(
                itemCount: indexes_card.length,
                itemBuilder: (context, index) {
                  // Get the product details using the index
                  var product = products[indexes_card[index]['index']];
                  var quantity = indexes_card[index]['quantity'];
                  return ShopBagCard(
                    title: product["title"],
                    label: product["label"],
                    price: product["price"],
                    imgPath: product["imgPath"],
                    quantity: quantity,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        // Update the quantity in the indexes_card list
                        indexes_card[index]['quantity'] = newQuantity;
                      });
                    },
                  );
                },
              ),
      ),
    );
  }
}

class ShopBagCard extends StatefulWidget {
  final String title;
  final String label;
  final double price;
  final String imgPath;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const ShopBagCard({
    Key? key,
    required this.title,
    required this.label,
    required this.price,
    required this.imgPath,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _ShopBagCardState createState() => _ShopBagCardState();
}

class _ShopBagCardState extends State<ShopBagCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(widget.imgPath),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.label,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.onQuantityChanged(widget.quantity - 1);
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                Text(widget.quantity.toString()),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.onQuantityChanged(widget.quantity + 1);
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
