import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_example/Screens/CalendarScreen.dart';
import 'package:theme_example/Screens/HomeScreen.dart';
import 'package:theme_example/Screens/SearchScreen.dart';
import 'package:theme_example/Screens/SettingsScreen.dart';
import 'package:theme_example/main.dart';
import 'package:theme_example/provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage() : super();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final _controller = PageController(
    initialPage: 1,
  );
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
      ),
      // ignore: deprecated_member_use
      title: Text(
        'Search',
      ),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.public,
      ),
      // ignore: deprecated_member_use
      title: Text(
        'Homepage',
      ),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_today,
      ),
      // ignore: deprecated_member_use
      title: Text(
        'Calendar',
      ),
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.format_align_justify,
    //   ),
    //   // ignore: deprecated_member_use
    //   title: Text(
    //     'Settings',
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: SettingsScreen(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(MyApp.title),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          SearchScreen(),
          HomeScreen(),
          myCalendarScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          _controller.animateToPage(index,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }
}

class CalendarScreen {}
