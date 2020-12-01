import 'package:flutter/foundation.dart';
import 'package:lab4_3/models/ContactsModel.dart';

class CloseFriendsModel extends ChangeNotifier {

  ContactsModel _contacts;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _closeFriends = [];

  /// The current catalog. Used to construct items from numeric ids.
  ContactsModel get contacts => _contacts;

  set contacts(ContactsModel newContacts) {
    assert(newContacts != null);
    assert(_closeFriends.every((id) => newContacts.getByPosition(id) != null),
    'The catalog $newContacts does not have one of $_closeFriends in it.');
    _contacts = newContacts;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Contact> get closeFriends => _closeFriends.map((id) => _contacts.getByPosition(id)).toList();

  /// The current total price of all items.
  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Contact contact) {
    _closeFriends.add(contact.id);
    print(_contacts);
    notifyListeners();
  }

  void removeAll(){
    _closeFriends.clear();
    notifyListeners();
  }
}
