import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final data = [
    'Bangalore',
    'jaipur',
    'jodhpur',
    'chennai',
    'punjab',
    'ladakh',
    'karnataka',
    'tamil nadu',
    'odisha',
    'gujarat',
  ];
  final recentData = ['Bangalore', 'chennai', 'punjab', 'ladakh'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on right side of appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result on based of selection
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.cyanAccent,
          shape: BeveledRectangleBorder(),
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone search something

    final suggestionList = query.isEmpty
        ? recentData
        : data
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, int index) => ListTile(
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
      ),
    );
  }
}
