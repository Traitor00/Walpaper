import 'dart:convert';
import 'package:walpaper/Jsonclass/class.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  int noOfImageToLoad = 70;
  final response = await http.get(
      "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
      headers: {
        "Authorization":
            "563492ad6f9170000100000196e977231aee4be8a176cd2fb6230a7b"
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
