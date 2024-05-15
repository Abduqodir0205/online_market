import 'package:flutter/material.dart';
import 'package:routing_router/prodacts.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String label;
  final double price;
  final double star;
  final String imgPath;
  final int index; // Add index attribute

  const ProductCard({
    Key? key,
    required this.title,
    required this.label,
    required this.price,
    required this.star,
    required this.imgPath,
    required this.index, // Initialize index
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isLiked; // Declare isLiked variable

  @override
  void initState() {
    super.initState();
    isLiked = indexes.contains(widget.index); // Set initial value for isLiked
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              title: widget.title,
              label: widget.label,
              price: widget.price,
              star: widget.star,
              imgPath: widget.imgPath,
              index: widget.index,
              isLiked: isLiked, // Pass isLiked to ProductDetailsPage
            ),
          ),
        ).then((value) {
          if (value != null && value is bool) {
            setState(() {
              isLiked = value;
            });
          }
        });
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.imgPath),
                ),
              ),
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      if (isLiked) {
                        indexes.add(widget.index); // Add index to the list
                      } else {
                        indexes
                            .remove(widget.index); // Remove index from the list
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(199, 24, 24, 24),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        widget.price.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.amber[300],
                      ),
                      Text(
                        widget.star.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.shopping_bag_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Add to card')
                      ],
                    ),
                    onPressed: () {
                      indexes_card.add({
                        'index': widget.index,
                        'quantity': 1,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product details page widget

class ProductDetailsPage extends StatefulWidget {
  final String title;
  final String label;
  final double price;
  final double star;
  final String imgPath;
  final int index;
  final bool isLiked;

  const ProductDetailsPage({
    Key? key,
    required this.title,
    required this.label,
    required this.price,
    required this.star,
    required this.imgPath,
    required this.index,
    required this.isLiked,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late bool isFavorite;

  var _quantity = 0;
  String selectedSize = ''; // Add selectedSize variable

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 500,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imgPath),
                      ),
                    ),
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            if (isFavorite) {
                              indexes.add(widget.index);
                            } else {
                              indexes.remove(widget.index);
                            }
                          });
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(162, 0, 0, 0),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.white : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (_quantity > 0) {
                                  _quantity--;
                                }
                              });
                            },
                            child: Icon(Icons.remove),
                          ),
                          SizedBox(width: 10),
                          Text(_quantity.toString()),
                          SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      for (var i = 0; i < widget.star.floor(); i++)
                        Icon(Icons.star, color: Colors.amber),
                      if ((widget.star - widget.star.floor()) > 0)
                        Icon(Icons.star_half, color: Colors.amber),
                      Text(
                        "${widget.star}",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 400,
                    child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(192, 158, 158,
                          158), // Customize the color of the horizontal line
                    ),
                  ),
                  SizedBox(height: 16), // Add some spacing before the buttons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Clothes size:"),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSize = 'S';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(40, 40),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: selectedSize == 'S'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Text(
                                  "S",
                                  style: TextStyle(
                                      color: selectedSize == 'S'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSize = 'M';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(40, 40),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: selectedSize == 'M'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Text("M",
                                    style: TextStyle(
                                        color: selectedSize == 'M'
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSize = 'L';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(40, 40),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: selectedSize == 'L'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Text("L",
                                    style: TextStyle(
                                        color: selectedSize == 'L'
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSize = 'XL';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(40, 40),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: selectedSize == 'XL'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Text("XL",
                                    style: TextStyle(
                                        color: selectedSize == 'XL'
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Color:"),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(40, 40),
                                    padding: EdgeInsets.zero,
                                    backgroundColor:
                                        Color.fromARGB(255, 126, 94, 7)),
                                child: Text(""),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(40, 40),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.black),
                                child: Text(""),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(40, 40),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.grey),
                                child: Text(""),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16), // Add some spacing before the button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 0) {
                            indexes_card.add({
                              'index': widget.index,
                              'quantity': _quantity,
                            });
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Add to cart'),
                          SizedBox(
                            width: 5,
                          ),
                          Text("|"),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text("\$"),
                              Text("${widget.price * _quantity}")
                            ],
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(192, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Make it round
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 28,
                left: 8,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context, isFavorite);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
