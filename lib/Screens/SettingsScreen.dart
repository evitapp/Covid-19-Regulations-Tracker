import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:theme_example/widget/change_theme_button_widget.dart';

bool vaccinated = false;

class SettingsScreen extends StatefulWidget {
  static var themeMode;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String valueChoose = 'English';
  List listItems = ['English', '-'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      //alignment: Alignment.topRight,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      children: [
        const SizedBox(height: 46),
        const Text(
          "Settings",
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 26),
        Divider(color: Colors.white),
        const SizedBox(height: 26),
        Row(children: [
          Text('Language    '),
          DropdownButton(
            icon: Icon(Icons.arrow_drop_down),
            value: valueChoose,
            onChanged: (newValue) {
              setState(() {
                valueChoose = newValue;
              });
            },
            items: listItems.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
        ]),
        const SizedBox(height: 26),
        Row(children: [
          Text('Theme'),
          ChangeThemeButtonWidget(),
        ]),
        const SizedBox(height: 26),
        Container(
            child: Row(children: [
          Text('Vaccinated'),
          Switch(
            value: vaccinated,
            onChanged: (value) {
              setState(() {
                vaccinated = value;
              });
            },
          )
        ]))
      ],
    )
        //*child: ChangeThemeButtonWidget(),

        //final themeProvider = Provider.of<ThemeProvider>(context);
        );
  }
}
/*
class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: false, //themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
 */ 
