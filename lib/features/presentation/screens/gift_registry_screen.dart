import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/providers/gift_provider.dart';
import 'package:provider/provider.dart';

class GiftRegistryScreen extends StatefulWidget {
  static const routeName = "/giftRegistry";
  @override
  _GiftRegistryScreenState createState() => _GiftRegistryScreenState();
}

class _GiftRegistryScreenState extends State<GiftRegistryScreen> {
  TextStyle style = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey[700],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Gift Registry'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                Provider.of<GiftProvider>(context, listen: false)
                    .clearAllGifts();
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GiftProvider>(context, listen: false).fetchGifts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return AlertDialog(
                title: Text('An Error Occured !'),
                content: Text('Something went Wrong!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'),
                  ),
                ],
              );
            } else {
              return Consumer<GiftProvider>(
                builder: (ctx, data, child) => data.items.length == 0
                    ? Center(
                        child: Text(
                        'No gifts Available',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    : ListView.builder(
                        itemCount: data.items.length,
                        itemBuilder: (ctx, index) => Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  '${data.items[index].title}',
                                  style: style,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                '${data.items[index].desc}',
                                style: style,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  '\u{20B9}${data.items[index].price}',
                                  style: style,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.share),
                                  FlatButton(
                                    child: Text('share via email'),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Icon(Icons
                                                    .supervised_user_circle),
                                                content: Text(
                                                  'Successfully Shared!!',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Okay'))
                                                ],
                                              ));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              );
            }
          }
        },
      ),
    );
  }
}
