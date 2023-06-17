/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<dynamic> imagesAndTexts = [];

  List<String> urls = [];
  List<String> richTextList = [];
  List<String> plainTextList = [];
  dynamic richText = [''];

  @override
  void initState() {
    super.initState();
    fetchImagesAndTexts();
  }

  Future<void> fetchImagesAndTexts() async {
    // First API - Fetch images
    final String api1Url =
        'https://api.notion.com/v1/blocks/cc9914a294b24306a46d0311baf552e6/children?page_size=200';
    final String apiToken =
        'secret_6FUwEepND9KKRbw6SUxYailRLqVEMbsnhs5DgQxzIQ3';

    final response = await http.get(Uri.parse(api1Url), headers: {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
      'Notion-Version': '2022-02-22',
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final blocks = jsonData['results'];

      for (var block in blocks) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          urls.add(imageUrl);

          //Creating heading

          if (block['type'] == 'heading_3') {
            richText = block['heading_3']['rich_text']['content'];
            richTextList.add(richText[0]['text']['content']);
          }
        }

        if (block['type'] == 'paragraph') {
          richText = block['paragraph']['rich_text']['content'];
          richTextList.add(richText[0]['text']['content']);
        }
      }

      urls.forEach((element) {
        print(element);
      });

      print('-----');
    } else {
      print('Failed to fetch news data: ${response.statusCode}');
    }

    /*if (api1Response.statusCode == 200) {
      final api1Data = jsonDecode(api1Response.body);
      final List<dynamic> api1Images = api1Data['images'];

      // Second API - Fetch strings
      final String api2Url =
          'https://api.notion.com/v1/blocks/1d00ea9592304d46bd95629c4eed38c3/children?page_size=200';

      final api2Response = await http.get(Uri.parse(api2Url), headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
        'Notion-Version': '2022-02-22',
      });

      if (api2Response.statusCode == 200) {
        final api2Data = jsonDecode(api2Response.body);
        final List<dynamic> api2Strings = api2Data['strings'];

        // Combine images and strings
        final int length = api1Images.length < api2Strings.length
            ? api1Images.length
            : api2Strings.length;

        for (int i = 0; i < length; i++) {
          imagesAndTexts.add({
            'image': api1Images[i]['url'],
            'text': api2Strings[i],
          });
        }

        setState(() {});
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: ListView.builder(
        itemCount: imagesAndTexts.length,
        itemBuilder: (context, index) {
          final imageData = imagesAndTexts[index];

          return Column(
            children: [
              Image.network(
                imageData['image'],
                width: 200,
                height: 200,
              ),
              Text(
                imageData['text'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

*/