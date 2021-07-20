import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Character {
   final String displayname;
   final String imageurl;

   Character({
     required this.displayname,
     required this.imageurl,
   });

   factory Character.fromJson(Map<String, dynamic> json) {
     return Character(
       displayname: json['displayname'],
       imageurl: json['imageurl'],
     );
   }
}

class WebService {

  Future<List<Character>> fetch() async {
    String urlStr = "https://dl.dropboxusercontent.com/s/vuwyehc5ogutvfw/characters.json";
    var url = Uri.parse(urlStr);
    final response = await http.get(url);
    var statusCode = response.statusCode;
    if (statusCode == 200) {
      List<Character> list = [];
      final jsons = jsonDecode(response.body);
      print(jsons.length);
      for (int i = 0; i < jsons.length; i++) {
          Map<String, dynamic> map = jsons[i];
          list.add(Character.fromJson(map));
      }
      return list;
    }
    return [];
  }
}

class Person with ChangeNotifier {
    
  Person({required this.name, required this.age});
  
  final String name;
  int age;
  
  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}

class MainViewModel with ChangeNotifier {

    List<Character> characters = [];
    var webserivce = WebService();
    var person = Person(name: "rex", age: 23);
    void request() async {
      characters = await webserivce.fetch();
      print(characters.length);
      notifyListeners();
    }
    void echo() {
        person.removeListener(() { });
        person.addListener(() {
          print("change {$person.age}");
        });
        person.increaseAge();
    }

    int count() {
      return characters.length;
    }

    String getImageUrl(int index) {
       print(characters[index].imageurl);
       return characters[index].imageurl;
    }
}