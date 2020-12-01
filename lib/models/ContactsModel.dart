import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Contact>> fetchContacts(http.Client client) async {
  final response =
  await client.get('https://picsum.photos/v2/list?limit=10');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseContacts, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Contact> parseContacts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}

class Contact {
  final int id;
  final String name;
  final String number;
  final String thumbnailUrl;

  Contact({this.id, this.name, this.number, this.thumbnailUrl});

  factory Contact.fromJson(Map<String, dynamic> json) {
    int numberN = 380953330000 + json['width'];
    int id = int.parse(json['id']);
    String number = numberN.toString();
    print(numberN);
    return Contact(
      id: id as int,
      name: json['author'] as String,
      number: number as String,
      thumbnailUrl: json['download_url'] as String,
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Contact && other.id == id;
}

class ContactsModel extends ChangeNotifier{
  List<Contact> contacts = [];

  void fullContacts() async{
    contacts = await fetchContacts(http.Client());
  }

  Contact getByPosition(int position){
    return contacts.singleWhere((element) => element.id == position);
  }

  void add(int id, String name,  String number, String url) {
    contacts.add(Contact(id: id, name: name, number: number, thumbnailUrl: url));
    notifyListeners();
  }
}