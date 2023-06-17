import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiFetcher {
  List<String> gridviewurls = [];
  List<String> headings_3 = [];
  List<String> listviewurls = [];
  String image_first_blog = '';
  String image_Second_blog = '';
  bool foundHeading3 = false;
  bool paragraph_bool = false;
  String paragraph_firstblog = '';
  final url1 = Uri.parse(
    'https://api.notion.com/v1/blocks/cc9914a294b24306a46d0311baf552e6/children?page_size=200',
  );
  final url2 = Uri.parse(
    'https://api.notion.com/v1/blocks/1d00ea9592304d46bd95629c4eed38c3/children?page_size=200',
  );
  final headers = {
    'Authorization':
        'Bearer secret_6FUwEepND9KKRbw6SUxYailRLqVEMbsnhs5DgQxzIQ3',
    'Content-Type': 'application/json',
    'Notion-Version': '2022-02-22',
  };

  Future<List<String>> fetchListViewData() async {
    final response = await http.get(url1, headers: headers);
    final api2Response = await http.get(url2, headers: headers);

    if (response.statusCode == 200 && api2Response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final api2Data = jsonDecode(api2Response.body);

      final blocks = jsonData['results'];
      final blocks_api2 = api2Data['results'];

      for (var block in blocks) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          listviewurls.add(imageUrl);
        }
      }

      for (var block in blocks_api2) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          listviewurls.add(imageUrl);
        }
      }

      listviewurls.forEach((element) {
        print(element);
      });

      /*if (!foundHeading3 && block['type'] == 'heading_3') {
    final richText = block['heading_3']['rich_text'];
    if (richText is List) {
      final content1 = richText[0]['text']['content'];
      headings_3.add(content1);
      foundHeading3 = true; // Set the flag to true after finding the first value
    }*/
    } else {
      print('Failed to fetch news data');
    }
    return listviewurls;
  }

  Future<List<String>> fetchGridViewData() async {
    final response = await http.get(url1, headers: headers);
    final api2Response = await http.get(url2, headers: headers);

    if (response.statusCode == 200 && api2Response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final api2Data = jsonDecode(api2Response.body);

      final blocks = jsonData['results'];
      final blocks_api2 = api2Data['results'];

      for (var block in blocks) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          gridviewurls.add(imageUrl);
        }
      }

      for (var block in blocks_api2) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          gridviewurls.add(imageUrl);
        }
      }
    } else {
      print('Failed to fetch news data');
    }
    gridviewurls.forEach((element) {
      print(element);
    });
    return gridviewurls;
  }

  Future<List<String>> fetchHeadings() async {
    final response = await http.get(url1, headers: headers);
    final api2Response = await http.get(url2, headers: headers);

    if (response.statusCode == 200 && api2Response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final api2Data = jsonDecode(api2Response.body);

      final blocks = jsonData['results'];
      final blocks_api2 = api2Data['results'];

      for (var block in blocks) {
        if (block['type'] == 'heading_3') {
          final richText = block['heading_3']['rich_text'];
          if (richText is List) {
            final content = richText[0]['text']['content'];
            headings_3.add(content);
          }
        }
      }

      for (var block in blocks_api2) {
        if (!foundHeading3 && block['type'] == 'heading_3') {
          final richText = block['heading_3']['rich_text'];
          if (richText is List) {
            final content1 = richText[0]['text']['content'];
            headings_3.add(content1);
            foundHeading3 = true;
          }
        }
      }

      /*if (!foundHeading3 && block['type'] == 'heading_3') {
    final richText = block['heading_3']['rich_text'];
    if (richText is List) {
      final content1 = richText[0]['text']['content'];
      headings_3.add(content1);
      foundHeading3 = true; // Set the flag to true after finding the first value
    }*/
    } else {
      print('Failed to fetch news data');
    }
    headings_3.forEach((element) {
      print(headings_3);
    });
    return headings_3;
  }

  Future<Map<String, dynamic>> fetchFirstBlog() async {
    final response = await http.get(url1, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final blocks = jsonData['results'];

      String? imageFirstBlogUrl;
      String? paragraphContent;

      for (var block in blocks) {
        if (block['type'] == 'image' && imageFirstBlogUrl == null) {
          imageFirstBlogUrl = block['image']['external']['url'];
        }

        if (block['type'] == 'paragraph' && paragraphContent == null) {
          final richText = block['paragraph']['rich_text'];
          if (richText is List && richText.isNotEmpty) {
            paragraphContent = richText[0]['text']['content'];
          }
        }

        if (imageFirstBlogUrl != null && paragraphContent != null) {
          return {'image': imageFirstBlogUrl, 'paragraph': paragraphContent};
        }
      }
    } else {
      print('Failed to fetch news data');
    }

    return {};
  }

  Future<Map<String, dynamic>> fetchSecondBlog() async {
    final response = await http.get(url2, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final blocks = jsonData['results'];

      String? imageSecondBlogUrl;
      String? paragraphContent;

      for (var block in blocks) {
        if (block['type'] == 'image' && imageSecondBlogUrl == null) {
          imageSecondBlogUrl = block['image']['external']['url'];
        }

        if (block['type'] == 'paragraph' && paragraphContent == null) {
          final richText = block['paragraph']['rich_text'];
          if (richText is List && richText.isNotEmpty) {
            paragraphContent = richText[0]['text']['content'];
          }
        }

        if (imageSecondBlogUrl != null && paragraphContent != null) {
          return {'image': imageSecondBlogUrl, 'paragraph': paragraphContent};
        }
      }
    } else {
      print('Failed to fetch second blog data');
    }

    return {};
  }

  Future<List<String>> fetchsearchBlog() async {
    final response = await http.get(url1, headers: headers);
    final api2Response = await http.get(url2, headers: headers);

    if (response.statusCode == 200 && api2Response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final api2Data = jsonDecode(api2Response.body);

      final blocks = jsonData['results'];
      final blocks_api2 = api2Data['results'];

      for (var block in blocks) {
        if (block['type'] == 'heading_3') {
          final richText = block['heading_3']['rich_text'];
          if (richText is List) {
            final content = richText[0]['text']['content'];
            headings_3.add(content);
          }
        }
      }

      for (var block in blocks_api2) {
        if (!foundHeading3 && block['type'] == 'heading_3') {
          final richText = block['heading_3']['rich_text'];
          if (richText is List) {
            final content1 = richText[0]['text']['content'];
            headings_3.add(content1);
            foundHeading3 = true;
          }
        }
      }
    } else {
      print('Failed to fetch news data');
    }
    return headings_3;
  }
}


/*import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiFetcher {
  Future<void> fetchApiData(List<String> listviewUrls,
      List<String> gridviewUrls, List<String> headings_3) async {
    bool foundHeading3 = false;
    final String apiToken =
        'secret_6FUwEepND9KKRbw6SUxYailRLqVEMbsnhs5DgQxzIQ3';

    final url1 = Uri.parse(
      'https://api.notion.com/v1/blocks/cc9914a294b24306a46d0311baf552e6/children?page_size=200',
    );
    final url2 = Uri.parse(
      'https://api.notion.com/v1/blocks/1d00ea9592304d46bd95629c4eed38c3/children?page_size=200',
    );
    final headers = {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
      'Notion-Version': '2022-02-22',
    };

    final response = await http.get(url1, headers: headers);
    final api2Response = await http.get(url2, headers: headers);

    if (response.statusCode == 200 && api2Response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final api2Data = jsonDecode(api2Response.body);

      final blocks = jsonData['results'];
      final blocks_api2 = api2Data['results'];

      for (var block in blocks) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          listviewUrls.add(imageUrl);
          gridviewUrls.add(imageUrl);
        }

        if (block['type'] == 'heading_3') {
          final richText = block['heading_3']['rich_text'];
          if (richText is List) {
            final content = richText[0]['text']['content'];
            headings_3.add(content);
          }
        }
      }

      headings_3.forEach((element) {
        print('apis :' + '$element');
      });

      for (var block in blocks_api2) {
        if (block['type'] == 'image') {
          final imageUrl = block['image']['external']['url'];
          gridviewUrls.add(imageUrl);
          listviewUrls.add(imageUrl);
        }

        if (!foundHeading3 && block['type'] == 'heading_3') {
    final richText = block['heading_3']['rich_text'];
    if (richText is List) {
      final content1 = richText[0]['text']['content'];
      headings_3.add(content1);
      foundHeading3 = true; // Set the flag to true after finding the first value
    }
  }
      }
      headings_3.forEach((element) {
        print('apis :' + '$element');
      });
    } else {
      print('Failed to fetch news data');
    }
  }
}*/

