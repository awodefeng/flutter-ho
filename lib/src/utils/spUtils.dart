import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  ///静态实例
  static late SharedPreferences _sharedPreferences;

  ///应用启动时候需要初始化
  static Future<bool> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

//清除数据
  static void remove(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      _sharedPreferences.remove(key);
    }
  }

  //异步保存基本数据类型
  static void save(String key, dynamic value) async {
    if (value is String) {
      _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      _sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      _sharedPreferences.setInt(key, value);
    } else if (value is List<String>) {
      _sharedPreferences.setStringList(key, value);
    }
  }

  //异步读取
  static Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    return _sharedPreferences.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    return _sharedPreferences.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    return _sharedPreferences.getDouble(key);
  }

  static Future<List<String>?> getListString(String key) async {
    return _sharedPreferences.getStringList(key);
  }

  //保存自定义对象
  static Future saveObject(String key, dynamic value) async {
//通过json讲object 对象编译成string保存
    _sharedPreferences.setString(key, json.encode(value));
  }

  //获取自定义对象
//返回的是Map<String, dynamic> 数据类型
  static dynamic? getObject(String key) {
    String? _data = _sharedPreferences.getString(key);
    if (_data == null) {
      return null;
    }
    return (_data.isEmpty) ? null : json.decode(_data);
  }

  //保存列表数据
  static Future<bool> putObjectList(String key, List<Object> list) {
//讲object转为String
    List<String> _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _sharedPreferences.setStringList(key, _dataList);
  }

  //获取对象集合数据
//返回List<Map<String,dynamic>>类型
  static List<Map>? getObjectLost(String key) {
    if (_sharedPreferences == null) return null;
    List<String>? dataList = _sharedPreferences.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }
}
