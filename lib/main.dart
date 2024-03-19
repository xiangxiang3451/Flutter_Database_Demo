import 'package:database_demo/core/spl_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainAPP extends StatefulWidget {
  const MainAPP({super.key});

  @override
  State<MainAPP> createState() => _MainAPPState();
}

class _MainAPPState extends State<MainAPP> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController deleteIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
                onPressed: () async {
                  _databaseHelper.insertData(_controller.text);
                  List<Map<String, dynamic>> dataList =
                      await _databaseHelper.getData();
                  print(dataList);
                },
                child: const Text('Save data')),
            TextField(controller: deleteIdController),
            ElevatedButton(
                onPressed: () async {
                  int id = int.tryParse(deleteIdController.text) ?? 0;
                  await _databaseHelper.deleteDataById(id);
                  List<Map<String, dynamic>> dataList =
                      await _databaseHelper.getData();
                  print(dataList);
                },
                child: const Text('Delete')),
          ],
        )),
      ),
    );
  }
}

void main() {
  runApp(const MainAPP());
}
