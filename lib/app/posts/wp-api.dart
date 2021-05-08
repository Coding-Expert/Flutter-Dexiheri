import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final responce = await http.get(
      "https://dexiheri.gr/index.php/wp-json/wp/v2/posts?per_page=5&categories=1&order=desc&orderby=date&status=publish&fbclid=IwAR0xPxRgQmF50sLcTTWUcZtJ3xA3HYlI2a-cDaxlDVKZZ8tWzwgA0TmSoUo",
      headers: {"Accept": "application/json"});

  var convetedDatatoJson = jsonDecode(responce.body);
  return convetedDatatoJson;
}

Future fetchWpPostImageUrl(href) async {
  final responce =
      await http.get(href, headers: {"Accept": "application/json"});

  var convetedDatatoJson = jsonDecode(responce.body);
  return convetedDatatoJson;
}
