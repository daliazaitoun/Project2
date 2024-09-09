import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project2/pages/home_page.dart';
import 'package:project2/pages/profile.dart';

class NavPage extends StatefulWidget {
   static const String id = 'nav';
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text('Search', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Stack(children: [
              BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '', 
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.import_contacts_outlined),
                    label: '', 
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '', 
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '', 
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false, // Hide selected labels
                showUnselectedLabels: false, // Hide unselected labels
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width / 8 *
                        (2 * _selectedIndex + 1) -
                    15, // Center under the icon,
                child: Center(
                  child: Container(
                    width: 30,
                    height: 3,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
