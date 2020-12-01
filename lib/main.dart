import 'package:flutter/material.dart';
import 'package:lab4_3/pages/CloseFriendsPage.dart';
import 'package:lab4_3/pages/ContactsPage.dart';
import 'package:provider/provider.dart';
import 'package:lab4_3/models/ContactsModel.dart';
import 'package:lab4_3/models/CloseFriendsModel.dart';
//import 'package:lab4_3/AddContact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => ContactsModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<ContactsModel, CloseFriendsModel>(
          create: (context) => CloseFriendsModel(),
          update: (context, contacts, closeFriends) {
            closeFriends.contacts = contacts;
            return closeFriends;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        //theme: appTheme,
        initialRoute: '/contacts',
        routes: {
          '/contacts': (context) => MyContacts(),
          '/closeFriends': (context) => MyCloseFriends(),
          //'/addContact': (context) => AddContact(),
        },
      ),
    );
  }
}