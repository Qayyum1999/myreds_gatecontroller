import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL =
  "https://myreds.ar-mechatronics.com/v2/api.php/records/places";

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<Post> posts = body['records']
          .map<Post>(
            (dynamic item) => Post.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}