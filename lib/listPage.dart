import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List currencies = [];
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();
    getCurrenties().then((response) {
      setState(() {
        currencies = response;
      });
    });
  }

  Future<List> getCurrenties() async {
    String cryptoUrl = "http://jsonplaceholder.typicode.com/users";
    http.Response response = await http.get(cryptoUrl);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUi(currency, color);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(currency['email']),
    );
  }

  Widget _getSubtitleText(String email) {
    TextSpan emailTextWidget =
        new TextSpan(text: "$email", style: new TextStyle(color: Colors.black));

    return new RichText(
      text: new TextSpan(children: [emailTextWidget]),
    );
  }
}
