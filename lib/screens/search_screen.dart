import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm'),
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: 'Nhập tên bài hát hoặc nghệ sĩ',
        ),
      ),
    );
  }
}
