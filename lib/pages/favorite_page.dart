import 'package:flutter/material.dart';
import '../prodacts.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<int> quantities = List<int>.filled(products.length, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoqtirilgan"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: (indexes.isEmpty || products.isEmpty) // Tekshirish
            ? Center(
                child: Text("Yoqtirilgan mahsulotlar yo'q"),
              )
            : ListView.builder(
                itemCount: indexes.length,
                itemBuilder: (context, index) {
                  return FavoriteCard(
                    title: products[index]["title"],
                    label: products[index]["label"],
                    price: products[index]["price"],
                    star: products[index]["star"],
                    imgPath: products[index]["imgPath"],
                    quantity: quantities[index],
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        quantities[index] = newQuantity;
                      });
                    },
                  );
                },
              ),
      ),
    );
  }
}

class FavoriteCard extends StatefulWidget {
  final String title;
  final String label;
  final double price;
  final double star;
  final String imgPath;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const FavoriteCard({
    Key? key,
    required this.title,
    required this.label,
    required this.price,
    required this.star,
    required this.imgPath,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set border radius here
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), // Chap tepa uchun radius
                      bottomLeft:
                          Radius.circular(10), // Chap pastki tomon uchun radius
                    ),
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
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _quantity = (_quantity > 0) ? _quantity - 1 : 0;

                          widget.onQuantityChanged(_quantity);
                        });
                      },
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(_quantity == 0 ? '1' : _quantity.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                          widget.onQuantityChanged(_quantity);
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
