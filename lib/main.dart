// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med/datefilter.dart';
import 'package:med/lg.dart';
import 'package:med/order_page.dart';
import 'package:med/orderrenameclass.dart';
import 'package:med/pharmecyfiltter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getdata();
    getalldate();
    getallpharmecyname();
    datecontroller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        datecontroller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  int x = 0;
  bool editing = false;
  List mes = [
    {'name': 'Azitrhro', 'price': 2870, 'count': 0},
    {'name': 'Ultraflam', 'price': 2507, 'count': 0},
    {'name': 'Cafamol', 'price': 3001, 'count': 0},
    {'name': 'Aman grip', 'price': 1862, 'count': 0},
    {'name': 'Cam gesic', 'price': 2355, 'count': 0},
    {'name': 'Sopexol 0.18', 'price': 13951, 'count': 0},
    {'name': 'Sapexol 0.7', 'price': 27902, 'count': 0},
    {'name': 'Azaram', 'price': 27105, 'count': 0},
    {'name': 'Bevicom', 'price': 14350, 'count': 0},
    {'name': 'Lact 1', 'price': 8779, 'count': 0},
    {'name': 'Lact 2', 'price': 8779, 'count': 0},
    {'name': 'Lact 3', 'price': 9000, 'count': 0},
    {'name': 'Lact 4', 'price': 19000, 'count': 0},
    {'name': 'Dithrecol', 'price': 22320, 'count': 0},
    {'name': 'Vibalmin', 'price': 9580, 'count': 0},
    {'name': 'ميلادرم بيج', 'price': 34700, 'count': 0},
    {'name': 'ميلاديرم شفاف', 'price': 34700, 'count': 0},
    {'name': 'Aziderm wash', 'price': 14900, 'count': 0},
    {'name': 'Aziderm gel', 'price': 19800, 'count': 0},
    {'name': 'ديكاديرم', 'price': 7500, 'count': 0},
    {'name': 'كريم ليلي', 'price': 34700, 'count': 0},
    {'name': 'كريم نهاري', 'price': 34700, 'count': 0},
    {'name': 'BOTOX', 'price': 69200, 'count': 0},
    {'name': 'Eye cream', 'price': 39600, 'count': 0},
    {'name': 'صابون كركم', 'price': 7500, 'count': 0},
    {'name': 'كاكو', 'price': 7500, 'count': 0},
    {'name': 'صابون كبريت', 'price': 8000, 'count': 0},
    {'name': 'حب الشباب', 'price': 8000, 'count': 0},
    {'name': 'بياض البيض', 'price': 8000, 'count': 0},
    {'name': 'كافيار', 'price': 8300, 'count': 0},
    {'name': 'رمان', 'price': 7500, 'count': 0},
    {'name': 'Ninolac AC', 'price': 25933, 'count': 0},
    {'name': 'Ninolac AR', 'price': 25933, 'count': 0},
  ];
  final numcontroller = TextEditingController();
  final pharmname = TextEditingController();
  final pharmplace = TextEditingController();
  final datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Dr.Diala"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onDoubleTap: () {
                orderlist.removeAt(0);
              },
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderPage()));
              },
              child: Icon(Icons.article_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              x == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Name Of The Pharmecy:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: pharmname,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Pharmecy Name',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Place Of The Pharmecy:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: pharmplace,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Pharmecy Place',
                          ),
                        ),
                        Text(
                          "Date Of Order:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          controller: datecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      height: 500,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: mes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return AlertDialog(
                                          title:
                                              Text('add number of mid order'),
                                          content: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: numcontroller,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Enter med num',
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  _dismissDialog();
                                                },
                                                child: Text('Close')),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (numcontroller.text !=
                                                      "") {
                                                    mes[index]['count'] =
                                                        int.parse(
                                                            numcontroller.text);
                                                    numcontroller.clear();
                                                  }

                                                  _dismissDialog();
                                                });
                                              },
                                              child: Text('add couantity to ' +
                                                  ' ' +
                                                  mes[index]['name']),
                                            )
                                          ],
                                        );
                                      }));
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LGradient(
                                  high: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,
                                              width: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  mes[index]['name'],
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${mes[index]['price']} sp',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          mes[index]['count'].toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: 300,
                  height: 100,
                  child: OutlinedButton(
                      onPressed: () {
                        List tempmes = [];

                        if (x == 1) {
                          for (int y = 0; y < mes.length; y++) {
                            if (mes[y]['count'] > 0) {
                              tempmes.add({
                                'name': mes[y]['name'],
                                'price': mes[y]['price'],
                                'count': mes[y]['count']
                              });
                              mes[y]['count'] = 0;
                            }
                          }
                          orderlist.add(OrderDet(pharmname.text,
                              pharmplace.text, tempmes, datecontroller.text));
                          String json = jsonEncode(orderlist);
                          savedata(json);
                        }
                        setState(() {
                          if (x == 0) {
                            x = 1;
                          } else {
                            x = 0;
                            numcontroller.clear();
                            pharmname.clear();
                            pharmplace.clear();
                          }
                        });
                      },
                      child: Text(
                        "add order",
                        style: TextStyle(fontSize: 30),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }

  _dismissDialog() {
    Navigator.pop(context);
    setState(() {});
  }

  Future<void> getdata() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    String? rejson = prefs.getString("orderlist");
    var derejson = jsonDecode(rejson!.toString());
    for (int x = 0; x < (derejson as List<dynamic>).length; x++) {
      List tempo = [];

      for (int y = 0;
          y < (derejson[x]['selectedorder'] as List<dynamic>).length;
          y++) {
        tempo.add({
          'name': derejson[x]['selectedorder'][y]['name'],
          'price': derejson[x]['selectedorder'][y]['price'],
          'count': derejson[x]['selectedorder'][y]['count']
        });
      }
      orderlist.add(OrderDet(derejson[x]['pharmecyname'],
          derejson[x]['pharmecyplace'], tempo, derejson[x]['orderdate']));
    }
    print(orderlist[0].selectedorder[0]['count']);
  }
}

Future<void> savedata(String json) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setString("orderlist", json);
  String? rejson = prefs.getString("orderlist");
  print(jsonDecode(rejson.toString()));
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.person,
                      size: 150,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: ListTile(
                  onTap: () {
                    getalldate();
                    getallpharmecyname();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DateFilter()));
                  },
                  leading: Icon(Icons.date_range_outlined),
                  title: Text("order by date"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: ListTile(
                  onTap: () {
                    getalldate();
                    getallpharmecyname();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmecyFillter()));
                  },
                  leading: Icon(Icons.date_range_outlined),
                  title: Text("order by pharmecy"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
