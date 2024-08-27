import 'dart:ffi';

class DashboardModel {
  List<Rows>? rows;
  Grid? grid;
  Grid? graph;

  DashboardModel({this.rows, this.grid, this.graph});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
    grid = json['grid'] != null ? Grid.fromJson(json['grid']) : null;
    graph = json['graph'] != null ? Grid.fromJson(json['graph']) : null;
  }
}

class Rows {
  String? title;
  String? saleAmount;
  String? clickableLink;

  Rows({this.title, this.saleAmount, this.clickableLink});

  Rows.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    saleAmount = json['sale_amount'];
    clickableLink = json['clickable_link'];
  }
}

class Grid {
  String? heading;
  List<Details>? details;

  Grid({this.heading, this.details});

  Grid.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    if (json['details'] != null) {
      details = <Details>[];
      if(json['details'] is List) {
        json['details'].forEach((v) {
          details!.add(Details.fromJson(v));
        });
      } else {
        List<dynamic> jsonArray = json['details'].entries.map((entry) {
          return {
            "category": entry.key,
            "sale_amount": entry.value,
          };
        }).toList();

        // Print the result
        print(jsonArray);
        jsonArray.forEach((v) {
          details!.add(Details.fromJson(v));
        });
      }
    }
  }
}

class Details {
  String? branch;
  String? executive;
  String? category;
  String? saleAmount;
  String? saleQty;

  Details({this.branch, this.saleAmount, this.saleQty});

  Details.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    executive = json["executive"];
    category = json['category'];
    saleAmount = json['sale_amount'] == "" ? "0" : json['sale_amount'].toString();
    saleQty = json['sale_qty'] == "null" ? "0" :  json['sale_qty'].toString();
  }
}
