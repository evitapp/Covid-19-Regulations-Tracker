import 'package:flutter/material.dart';
import 'package:theme_example/helpers/country.dart';
import 'package:theme_example/helpers/utils.dart';
import 'SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    /*final text =
        SettingsScreen.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? 'DarkTheme'
            : 'LightTheme';*/

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 10, left: 20),
            child: Text(
              'Regions',
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        opendialog(
                          categories[index].region,
                          categories[index].country,
                          categories[index].restrictions,
                        );
                      },
                      title: Text(
                          '${categories[index].region}, ${categories[index].country}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'lib/assets/flags/${categories[index].imgName}.png'),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future opendialog(region, country, restrictions) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text('${region}, ${country}'),
            content: Text('Restrictions: \n - ${restrictions.join("\n - ")}'),
          ));
}
