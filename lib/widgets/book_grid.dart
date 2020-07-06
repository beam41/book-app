import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:borrow_book/pages/book_info.dart';

class _BookGridState extends State<BookGrid> {
  Future<dynamic> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<dynamic> fetchData() async {
    final response = await http.get(
      DotEnv().env['API_URL'],
      headers: {
        'x-rapidapi-host': DotEnv().env['RAPID_HOST'],
        'x-rapidapi-key': DotEnv().env['RAPID_KEY'],
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> bookList = [];
          for (var item in snapshot.data['items']) {
            bookList.add(
              Card(
                child: InkWell(
                  splashColor: Colors.green[100],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookInfo(
                          item,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          item['volumeInfo']['imageLinks']['thumbnail'],
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                item['volumeInfo']['title'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: bookList,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}

class BookGrid extends StatefulWidget {
  @override
  _BookGridState createState() => _BookGridState();
}
