import 'package:flutter/material.dart';
import 'dart:async';
import 'package:theme_example/helpers/country.dart';
import 'package:theme_example/helpers/utils.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen() : super();
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Category> categories = [];
  List<Category> filteredcategories = [];
  @override
  // initialize Categories and Filtered Categories
  void initState() {
    super.initState();
    setState(() {
      categories = Utils.getMockedCategories();
      filteredcategories = Utils.getMockedCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 20),
            child: Text(
              'Search',
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: TextField(
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                ),
                hintText: "Search region here",
              ),
              onChanged: (string) {
                setState(() {
                  filteredcategories = categories
                      .where((u) => (u.region
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.country
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            child: Text(
              'Regions',
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredcategories.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        opendialog(
                          filteredcategories[index].region,
                          filteredcategories[index].country,
                          filteredcategories[index].restrictions,
                        );
                      },
                      title: Text('${filteredcategories[index].region}'),
                      subtitle: Text('${filteredcategories[index].country}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'lib/assets/flags/${filteredcategories[index].imgName}.png'),
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
