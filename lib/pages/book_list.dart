import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:borrow_book/widgets/book_grid.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow Book'),
      ),
      body: BookGrid(),
    );
  }
}
