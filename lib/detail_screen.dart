import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final String title;
  final String body;
  final Color rectanglecolor;
  final String placeid;

  const DetailScreen(
      {Key? key,
        required this.title,
        required this.body,
        required this.rectanglecolor,
        required this.placeid,
      })
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String _gatestatusEntrance = 'Close';
  late String _gatestatusExit = 'Close';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0), // here the desired height
        child: Stack(
          children: [
            AppBar(
              backgroundColor: widget.rectanglecolor,
              shadowColor: Colors.transparent,
              leading: IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25 + (23 / 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 63, 0, 0),
              child: Text('Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 92,
            width: double.infinity,
            color: widget.rectanglecolor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(39, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    widget.body,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: 31,
                color: widget.rectanglecolor,
              ),
              Center(
                child: SizedBox(
                  width: 262,
                  height: 70,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Entrance',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  _gatestatusEntrance,
                                  style: TextStyle(
                                    color: Color(0xFF606060),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                    fontSize: 24,
                                  ),
                                ),
                                // WidgetGateStatusText(status: _gatestatus),
                              ],
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Exit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    _gatestatusExit,
                                    style: TextStyle(
                                      color: Color(0xFF606060),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      fontSize: 24,
                                    ),
                                  ),
                                  // WidgetGateStatusText(status: _gatestatus),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                            endIndent: 9,
                            indent: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 83,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 17),
                        child: Text(
                          'Entrance Gate',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                var response = await http.put(
                                    Uri.parse( "https://myreds.ar-mechatronics.com/v2/api.php/records/places/${widget.placeid}"), body: {'gate_entrance': '1'});
                                print('Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');
                                // if(_gatestatus==Gatestatusmode.Wait){
                                //
                                // }
                                if(response.statusCode==200){
                                  setState(() {
                                    _gatestatusEntrance='Open ';
                                  });
                                }else{
                                  _gatestatusEntrance='...';
                                }
                              },
                            child: Container(
                              width: 142,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF00FF38),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('Tap to Open'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var response = await http.put(
                                  Uri.parse( "https://myreds.ar-mechatronics.com/v2/api.php/records/places/${widget.placeid}"), body: {'gate_entrance': '0'});
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              // if(response.statusCode==200){
                              //   _gatestatus= 'Close';
                              // }
                              if(response.statusCode==200){
                                setState(() {
                                  _gatestatusEntrance='Close';
                                });
                              }else{
                                _gatestatusEntrance='...';
                              }
                            },
                            child: Container(
                              width: 142,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF0000),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('Tap to Close'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 83,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 17),
                        child: Text(
                          'Exit Gate',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var response = await http.put(
                                  Uri.parse( "https://myreds.ar-mechatronics.com/v2/api.php/records/places/${widget.placeid}"), body: {'gate_exit': '1'});
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              // if(response.statusCode==200){
                              //   _gatestatus= 'Open';
                              // }
                              if(response.statusCode==200){
                                setState(() {
                                  _gatestatusExit='Open ';
                                });
                              }else{
                                _gatestatusExit='...';
                              }
                            },
                            child: Container(
                              width: 142,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF00FF38),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('Tap to Open'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var response = await http.put(
                                  Uri.parse( "https://myreds.ar-mechatronics.com/v2/api.php/records/places/${widget.placeid}"), body: {'gate_exit': '0'});
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              // if(response.statusCode==200){
                              //   _gatestatus= 'Close';
                              // }
                              if(response.statusCode==200){
                                setState(() {
                                  _gatestatusExit='Close';
                                });
                              }else{
                                _gatestatusExit='...';
                              }
                            },
                            child: Container(
                              width: 142,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF0000),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('Tap to Close'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class WidgetGateStatusText extends StatelessWidget {
//   final Gatestatusmode status;
//   const WidgetGateStatusText({
//     Key? key, required this.status,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // String? stat;
//     // switch (status){
//     //   case Gatestatusmode.Wait:
//     //     stat = '...';
//     //     break;
//     //   case Gatestatusmode.Close:
//     //     stat = 'Close';
//     //     break;
//     //   case Gatestatusmode.Open:
//     //     stat = 'Open';
//     //     break;
//     // }
//
//     return Text(
//       stat,
//       style: TextStyle(
//         color: Color(0xFF606060),
//         fontWeight: FontWeight.w400,
//         fontFamily: 'Roboto',
//         fontSize: 24,
//       ),
//     );
//   }
// }
