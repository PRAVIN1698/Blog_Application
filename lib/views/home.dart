import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'api_fetcher.dart';
import 'first_blog.dart';
import 'second_blog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  String searchText = '';
  List<String> listviewurls = [];
  List<String> gridviewurls = [];
  List<String> headings_3 = [];

  ApiFetcher apiFetcher = ApiFetcher();

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function here
  }

  Future<void> fetchData() async {
    try {
      List<String> listviewData = await apiFetcher.fetchListViewData();
      List<String> gridviewData = await apiFetcher.fetchGridViewData();
      List<String> headingsData = await apiFetcher.fetchHeadings();

      setState(() {
        listviewurls = listviewData;
        gridviewurls = gridviewData;
        headings_3 = headingsData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void navigateToAnotherClass(String searchText) {
    bool foundHeading = false;
    for (String heading in headings_3) {
      if (heading.toLowerCase().contains(searchText.toLowerCase())) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FirstBlog(
              imageUrl: listviewurls[0],
              heading: heading,
            ),
          ),
        );
        foundHeading = true;
        break;
      }
    }
    for (String heading in headings_3) {
      if (heading.toLowerCase().contains(searchText.toLowerCase())) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondBlog(
              imageUrl: listviewurls[1],
              heading: heading,
            ),
          ),
        );
        foundHeading = true;
        break;
      }
    }

    if (!foundHeading) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Search Result'),
            content: Text('No results found for "$searchText".'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 350,
              height: 40,
              child: TextField(
                controller: _textEditingController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Dodgecoin to the moon...',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      String searchText = _textEditingController.text;
                      navigateToAnotherClass(searchText);
                    },
                    child: Icon(Icons.search),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 236, 234, 234),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 56, 8),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          CarouselSlider.builder(
            itemCount: listviewurls.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              String heading = headings_3[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstBlog(
                          imageUrl: listviewurls[index],
                          heading: heading,
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondBlog(
                          imageUrl: listviewurls[index],
                          heading: heading,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        listviewurls[index],
                        fit: BoxFit.cover,
                        height: 300,
                        width: 350,
                      ),
                      Positioned(
                        left: 40,
                        right: 40,
                        top: 60,
                        bottom: 40,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headings_3[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 236, 234, 234),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1,
              autoPlay: false,
              enlargeCenterPage: true,
            ),
          ),
          SizedBox(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: gridviewurls.length,
              itemBuilder: (BuildContext context, int index) {
                if (index >= headings_3.length) {
                  return SizedBox();
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(8, 16, 16, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        gridviewurls[index],
                        fit: BoxFit.cover,
                        height: 125,
                        width: double.infinity,
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 10,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headings_3[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
