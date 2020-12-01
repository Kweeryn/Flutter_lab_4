import 'package:flutter/material.dart';
import 'package:lab4_3/models/CloseFriendsModel.dart';
import 'package:provider/provider.dart';
import 'dart:async';


class MyCloseFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Close Friends',),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CloseFriendsList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedDeleteButton(),
    );
  }
}

class _CloseFriendsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var itemNameStyle = Theme.of(context).textTheme.headline6;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var closeFriends = context.watch<CloseFriendsModel>();

    return ListView.builder(
      itemCount: closeFriends.closeFriends.length,
      itemBuilder: (context, index) => ListTile(
        trailing: IconButton(
          icon: Icon(Icons.star),
        ),
        title: Text(
          closeFriends.closeFriends[index].name,
          //style: itemNameStyle,
        ),
      ),
    );
  }
}


class _deleteButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var closeFriends = context.watch<CloseFriendsModel>();

    return FloatingActionButton(
      onPressed: (){
        closeFriends.removeAll();
        Navigator.pop(context);
      },
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.delete_forever),
    );
  }

}

class AnimatedDeleteButton extends StatefulWidget {
  @override
    _AnimatedDeleteButtonState createState() => _AnimatedDeleteButtonState();

}

class _AnimatedDeleteButtonState extends State<AnimatedDeleteButton> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.deepPurple,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var closeFriends = context.watch<CloseFriendsModel>();
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: (){
        animation();
        closeFriends.removeAll();
        Timer(Duration(milliseconds: 500), () {Navigator.pop(context);});
        },
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        progress: _animateIcon,
      ),
    );
  }

}