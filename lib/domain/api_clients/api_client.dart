import 'dart:convert';
import 'dart:io';

import 'package:flutter_http_request/domain/entity/post.dart';
import 'package:path/path.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // final url = Uri(scheme: 'https',host: 'jsonplaceholder.typicode.com',path: 'posts');
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parametrs = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset= UTF-8');
    request.write(jsonEncode(parametrs));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }

  

  Future<void> fileUpload(File file) async {
    final url = Uri.parse("https://exemple.com");

    final request = await client.postUrl(url);

    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);
    // import 'package:path/path.dart'; для basename:
    request.headers.add('filename', basename(file.path));
    request.contentLength = file.lengthSync();
    final fileStream = file.openRead();
    request.addStream(fileStream);

    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception("Error uploading file");
    } else {
      return;
    }
  }
}