import 'package:flutter/material.dart';

class User {
  String name = "";
  int age = 0;

//常用于解析json数据
  User.formMap(Map<String, dynamic> map) {
    this.name = map["userName"];
    this.age = map["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["userName"] = this.name;
    map["age"] = this.age;
    return map;
  }
}
