import 'package:flutter/material.dart';
import 'package:routing_router/pages/home_page.dart';
import 'package:routing_router/pages/intro_page.dart';
import '../prodacts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController starController = TextEditingController();
  TextEditingController imgPathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
        leading: IconButton(
          // Chap tomonda button qo'yamiz
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IntroPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: labelController,
                decoration: InputDecoration(labelText: 'Label'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: starController,
                decoration: InputDecoration(labelText: 'Star'),
              ),
              TextField(
                controller: imgPathController,
                decoration: InputDecoration(labelText: 'Image Path'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Yangi mahsulotni yaratish
                  Map<String, dynamic> newProduct = {
                    "title": titleController.text,
                    "label": labelController.text,
                    "price": double.parse(priceController.text),
                    "star": double.parse(starController.text),
                    "imgPath": imgPathController.text,
                  };
                  // Yangi mahsulotni products ro'yxatiga qo'shamiz
                  products.add(newProduct);
                  // TextFieldlarni tozalash
                  titleController.clear();
                  labelController.clear();
                  priceController.clear();
                  starController.clear();
                  imgPathController.clear();
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
