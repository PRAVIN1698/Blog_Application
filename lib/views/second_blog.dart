import 'package:flutter/material.dart';
import 'api_fetcher.dart';

class SecondBlog extends StatefulWidget {
  final String imageUrl;
  final String heading;

  SecondBlog({required this.imageUrl, required this.heading});

  @override
  _SecondBlogState createState() => _SecondBlogState();
}

class _SecondBlogState extends State<SecondBlog> {
  late String paragraph = '';

  ApiFetcher apiFetcher = ApiFetcher();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiFetcher.fetchSecondBlog();
      paragraph = data['paragraph'];
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 0,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      const Color.fromARGB(255, 192, 190, 190).withOpacity(0.7),
                ),
                child: Center(
                  child: Text(
                    widget.heading,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$paragraph',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
