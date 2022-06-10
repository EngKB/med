// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med/main.dart';
import 'package:med/orderrenameclass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    orderlist = orderlist.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("Dr.Diala Orders"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(color: Colors.purpleAccent)),
                  child: Center(child: Text(getallprices())),
                ),
                GestureDetector(
                  onTap: () {
                    getalldate();
                    getallpharmecyname();
                  },
                  child: Container(
                    width: 150,
                    height: 80,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(color: Colors.purpleAccent)),
                    child: Center(child: Text(getpercenteg(getallprices()))),
                  ),
                )
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orderlist.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shadowColor: Colors.purpleAccent,
                    margin: EdgeInsets.all(20),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.purpleAccent, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                orderlist[index].orderdate,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                orderlist[index].pharmecyname,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text:
                                                'pharmecy ${orderlist[index].pharmecyname} ${orderlist[index].pharmecyplace} \n ' +
                                                    getAllOrder(index)));
                                      },
                                      icon: Icon(Icons.copy_all,
                                          color: Colors.black)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          orderlist.removeAt(index);
                                          String json = jsonEncode(orderlist);
                                          savedata(json);
                                        });
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red)),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderlist[index].pharmecyplace,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            'Orders:',
                            style: TextStyle(fontSize: 20),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: orderlist[index].selectedorder.length,
                              itemBuilder: ((context, indes) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          orderlist[index].selectedorder[indes]
                                              ['name'],
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          '' 'x' ' ' +
                                              orderlist[index]
                                                  .selectedorder[indes]['count']
                                                  .toString(),
                                          style: TextStyle(fontSize: 20)),
                                      Text(getprice(index, indes),
                                          style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                );
                              })),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Order Price:",
                                    style: TextStyle(fontSize: 20)),
                                Text(gettotalpriceoforder(index),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("youe percenteg:",
                                    style: TextStyle(fontSize: 20)),
                                Text(getpercenteg(gettotalpriceoforder(index)),
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  getprice(int ind, int ins) {
    int x = orderlist[ind].selectedorder[ins]['count'] *
        orderlist[ind].selectedorder[ins]['price'];
    return x.toString();
  }

  gettotalpriceoforder(int index) {
    int total = 0;

    for (int x = 0; x < orderlist[index].selectedorder.length; x++) {
      int mul = orderlist[index].selectedorder[x]['count'] *
          orderlist[index].selectedorder[x]['price'];
      total = total + mul;
    }
    return total.toString();
  }

  String getAllOrder(int index) {
    String mul = '';
    for (int x = 0; x < orderlist[index].selectedorder.length; x++) {
      mul = mul +
          ' ' +
          orderlist[index].selectedorder[x]['name'] +
          ' ' +
          'X' +
          ' ' +
          orderlist[index].selectedorder[x]['count'].toString() +
          '\n';
    }
    return mul;
  }

  getallprices() {
    int total = 0;
    int stotal = 0;
    for (int x = 0; x < orderlist.length; x++) {
      for (int y = 0; y < orderlist[x].selectedorder.length; y++) {
        int mul = orderlist[x].selectedorder[y]['count'] *
            orderlist[x].selectedorder[y]['price'];
        stotal = stotal + mul;
      }

      total = total + stotal;
      stotal = 0;
    }
    return total.toString();
  }

  getpercenteg(String price) {
    double x = (1.5 * int.parse(price)) / 100;
    return x.toString();
  }

  Future<String> loaddata() async {
    final SharedPreferences prefs = await _prefs;

    String? json = prefs.getString("orderlist");

    return jsonDecode(json.toString());
  }
}

getalldate() {
  datelist.clear();
  for (int x = 0; x < orderlist.length; x++) {
    datelist.add(orderlist[x].orderdate.substring(0, 7));
  }
  datelist = datelist.toSet().toList();
  print(datelist);
}

getallpharmecyname() {
  pharmecylist.clear();
  for (int x = 0; x < orderlist.length; x++) {
    pharmecylist.add(orderlist[x].pharmecyname.toString());
  }
  pharmecylist = pharmecylist.toSet().toList();
  print(pharmecylist);
}
