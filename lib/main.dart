import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

//converting string hexcolor to int hexcolor
Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyREDs Gate Controller',
      theme: ThemeData(),
      home: const Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE0E0),
        body: ColorfulSafeArea(
          color: Colors.white.withOpacity(0.7),
          overflowRules: const OverflowRules.all(true),
          child: ListView(
            scrollDirection: Axis.vertical,
              children: [
            Stack(
              children: [
                Container(
                  height: 319,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 27, 0, 0),
                      child: Row(
                        children: const [
                          Text(
                            'MyREDs',
                            style: TextStyle(
                              color: Color(0xFFFF0000),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            ' Gate Controller',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
                      child:
                          Center(child: Image.asset("assets/images/image.png")),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 246.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE0E0),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24, 271, 0, 20),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          fontSize: 24,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: httpService.getPosts(),
                      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                        if (snapshot.hasData) {
                          List<Post>? posts = snapshot.data;
                          return  ListView(
                            shrinkWrap: true,
                            children: posts!
                                .map(
                                    (Post post) => ContentCard(
                                  title: post.name.toString(),
                                  body: "Location ID: "+post.code.toString(),
                                  rectanglecolor: _colorFromHex(post.color1 != null? post.color1!:'25BEFF'), //if null, put blue color
                                  getplaceid: post.id,
                                )
                            )
                                .toList(),
                              physics: const NeverScrollableScrollPhysics(),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),

                  ],
                ),
              ],
            )
          ]),
        ));
  }
}

class ContentCard extends StatelessWidget {
  final String title;
  final String body;
  final Color rectanglecolor;
  final Color backgroundColor;
  final String getplaceid;

  const ContentCard({
    Key? key,
    required this.title,
    required this.body,
    required this.rectanglecolor,
    this.backgroundColor = Colors.white,
    required this.getplaceid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                body: body,
                title: title,
                rectanglecolor: rectanglecolor,
                placeid: getplaceid,
              )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 15, 25, 0),
        child: Card(
          color: backgroundColor,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: SizedBox(
            height: 78,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(13, 15, 7, 35),
                  height: 28,
                  width: 6,
                  decoration: BoxDecoration(
                    color: rectanglecolor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        body,
                        style: const TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 7),
                    child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF878787),
                        size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
