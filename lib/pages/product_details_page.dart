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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.imgPath),
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

  @override
  void initState() {
    super.initState();
    isFavorite =
        widget.isLiked; // Set isFavorite using isLiked from ProductCard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      image: AssetImage(widget.imgPath),
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
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.white : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Product Title: ${widget.title}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Product Label: ${widget.label}'),
                Text('Price: ${widget.price}'),
                Text('Star Rating: ${widget.star}'),
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
                      Navigator.pop(context,
                          isFavorite); // Pass isFavorite back to previous page
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
