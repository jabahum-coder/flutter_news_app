import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final PageController controller;
  const BottomNavigationBarWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: 0,
      fixedColor: Theme.of(context).primaryColorLight,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Theme.of(context).primaryColor,
      onTap: (pageIndex) {
        // bloc.setSelectedPage = pageIndex;
        controller.animateToPage(pageIndex,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Home')),
      ],
      elevation: 5,
    );
  }
}
