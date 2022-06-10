// ignore_for_file: prefer_initializing_formals

class OrderDet {
  late String pharmecyname;
  late String pharmecyplace;
  late List selectedorder;
  late String orderdate;
  OrderDet(String pharmecyname, String pharmecyplace, List selectedorder,
      String orderdate) {
    this.pharmecyname = pharmecyname;
    this.pharmecyplace = pharmecyplace;
    this.selectedorder = selectedorder;
    this.orderdate = orderdate;
  }
  Map<String, dynamic> toJson() {
    return {
      'pharmecyname': pharmecyname,
      'pharmecyplace': pharmecyplace,
      'selectedorder': selectedorder,
      'orderdate': orderdate
    };
  }

  OrderDet.fromJson(Map<String, dynamic> json) {
    pharmecyname = json['pharmecyname'];
    pharmecyplace = json['pharmecyplace'];
    selectedorder = json['selectedorder'];
    orderdate = json['orderdate'];
  }
}

late List<OrderDet> orderlist = [];
late List<OrderDet> localorder = [];
late List<String> datelist = [];
late List<OrderDet> filterdate = [];
late List<String> pharmecylist = [];
late List<OrderDet> pharmecydate = [];
