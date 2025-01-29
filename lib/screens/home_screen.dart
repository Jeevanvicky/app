import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load products')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Stack(
        children: [
          // Online background image
          Positioned.fill(
            child: Image.network(
              'https://your-image-url.com/home_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(products[index]['name']),
                        subtitle: Text('Price: ${products[index]['price']}'),
                        leading: Icon(Icons.shopping_cart),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
