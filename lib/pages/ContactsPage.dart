import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab4_3/models/CloseFriendsModel.dart';
import 'package:lab4_3/models/ContactsModel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyContacts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () => Navigator.pushNamed(context, '/closeFriends'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/addContact'),
          )
        ],
      ),
//      body: FutureBuilder<List<Contact>>(
//        future: fetchContacts(http.Client()),
//        builder: (context, snapshot) {
//          if (snapshot.hasError) print(snapshot.error);
//
//          return snapshot.hasData ? _MyListItem()
//              : Center(child: CircularProgressIndicator());
//        },
//      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: _MyListItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _AddButton extends StatelessWidget {
  final Contact contact;

  const _AddButton({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCloseFriends = context.select<CloseFriendsModel, bool>(
          (closeFriends) => closeFriends.closeFriends.contains(contact),
    );

    return FlatButton(
      onPressed: isInCloseFriends
          ? null
          : () {
        var closeFriends = context.read<CloseFriendsModel>();
        closeFriends.add(contact);
        print(isInCloseFriends);
      },
      child: isInCloseFriends ? Icon(Icons.star, semanticLabel: 'ADDED') : Icon(Icons.star_border, semanticLabel: 'ADD'),
    );
  }
}

class _MyListItem extends StatelessWidget {
  //final int index;

  //_MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var contacts = context.select<ContactsModel, Contact>(
    // Here, we are only interested in the item at [index]. We don't care
    // about any other change.
    //      (contacts) => contacts.getByPosition(index),
    //);
    var contacts = context.watch<ContactsModel>();
    contacts.fullContacts();
    //var textTheme = Theme.of(context).textTheme.headline6;
    return ListView.separated(
      itemCount: contacts.contacts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.network(contacts.contacts[index].thumbnailUrl),
              height: 48,),
          ),
          ),
          Expanded(child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(contacts.contacts[index].name, style: TextStyle(fontSize: 17),),
                Text(contacts.contacts[index].number, style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15)),
              ]
          ),
            flex: 3,
          ),
          Expanded(child: _AddButton(contact: contacts.contacts[index]),flex: 1,)
        ],
//
      ),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }
}