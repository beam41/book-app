import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget _textGen(head, body) => Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
                text: head + ": ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: body),
          ],
        ),
      ),
    );

List<Widget> _ratingBuilder(rating, votingNum) {
  if (rating == null) {
    return <Widget>[
      for (var i = 0; i < 5; ++i)
        const Icon(
          Icons.star,
          color: Colors.grey,
          size: 12,
        ),
      const Text(
        ' no rating',
        style: const TextStyle(
          fontSize: 10,
          height: 1.2,
        ),
      )
    ];
  } else {
    return <Widget>[
      for (var i = 0; i < rating; ++i)
        const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 12,
        ),
      for (var i = rating; i < 5; ++i)
        const Icon(
          Icons.star,
          color: Colors.grey,
          size: 12,
        ),
      Text(
        ' ($votingNum)',
        style: const TextStyle(
          fontSize: 10,
          height: 1.2,
        ),
      )
    ];
  }
}

Widget _ratingGen(rating, votingNum) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _ratingBuilder(rating, votingNum),
      ),
    );

class BookInfo extends StatelessWidget {
  final dynamic _data;

  BookInfo(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_data['volumeInfo']['title']),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
            _data['volumeInfo']['imageLinks']['thumbnail'],
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    _data['volumeInfo']['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    _data['volumeInfo']['authors'][0] +
                        (_data['volumeInfo']['authors'].length > 1
                            ? ' and ${_data['volumeInfo']['authors'].length - 1} more'
                            : ''),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                _ratingGen(
                  _data['volumeInfo']['averageRating'],
                  _data['volumeInfo']['ratingsCount'],
                ),
                _textGen(
                  'Page count',
                  _data['volumeInfo']['pageCount'].toString(),
                ),
                _textGen(
                  'Categories',
                  _data['volumeInfo']['categories'].join(", "),
                ),
                _textGen(
                  'Language',
                  _data['volumeInfo']['language'],
                ),
                _textGen(
                  'Description',
                  _data['volumeInfo']['description'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
