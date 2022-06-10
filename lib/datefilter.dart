// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:med/orderrenameclass.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({Key? key}) : super(key: key);

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  String sell = datelist[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr.Diala"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      value: sell,
                      items: datelist.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (item) {
                        setState(() {
                          sell = item.toString();
                          getdateorder(item.toString());
                        });
                      }),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          filterdate = filterdate.reversed.toList();
                        });
                      },
                      icon: Icon(Icons.format_line_spacing_rounded))
                ],
              ),
            ),
            SingleChildScrollView(
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
                        onTap: () {},
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
                          child:
                              Center(child: Text(getpercenteg(getallprices()))),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filterdate.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shadowColor: Colors.purpleAccent,
                          margin: EdgeInsets.all(20),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.purpleAccent, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      filterdate[index].orderdate,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filterdate[index].pharmecyname,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    filterdate[index].pharmecyplace,
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
                                    itemCount:
                                        filterdate[index].selectedorder.length,
                                    itemBuilder: ((context, indes) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                filterdate[index]
                                                        .selectedorder[indes]
                                                    ['name'],
                                                style: TextStyle(fontSize: 20)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                '' 'x' ' ' +
                                                    filterdate[index]
                                                        .selectedorder[indes]
                                                            ['count']
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("youe percenteg:",
                                          style: TextStyle(fontSize: 20)),
                                      Text(
                                          getpercenteg(
                                              gettotalpriceoforder(index)),
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
          ],
        ),
      ),
    );
  }

  getallprices() {
    int total = 0;
    int stotal = 0;
    for (int x = 0; x < filterdate.length; x++) {
      for (int y = 0; y < filterdate[x].selectedorder.length; y++) {
        int mul = filterdate[x].selectedorder[y]['count'] *
            filterdate[x].selectedorder[y]['price'];
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

  getprice(int ind, int ins) {
    int x = filterdate[ind].selectedorder[ins]['count'] *
        filterdate[ind].selectedorder[ins]['price'];
    return x.toString();
  }

  gettotalpriceoforder(int index) {
    int total = 0;

    for (int x = 0; x < filterdate[index].selectedorder.length; x++) {
      int mul = filterdate[index].selectedorder[x]['count'] *
          filterdate[index].selectedorder[x]['price'];
      total = total + mul;
    }
    return total.toString();
  }
}

getdateorder(String date) {
  filterdate.clear();
  for (int x = 0; x < orderlist.length; x++) {
    if (orderlist[x].orderdate.substring(0, 7) == date) {
      filterdate.add(orderlist[x]);
    }
  }
}
