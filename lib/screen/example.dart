import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {

  String? _content;

  // TextField controller
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example file'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            ElevatedButton(
              child: const Text('Save to file'),
              onPressed: (){
                writeFile(_textController.text);
              },
            ),
            const SizedBox(
              height: 150,
            ),
            Text(_content ?? 'Press the button to load your name',
                style: const TextStyle(fontSize: 24, color: Colors.pink)),
            ElevatedButton(
              child: const Text('Read my name from the file'),
              onPressed: _readData,
            )
          ],
        ),
      ),
    );
  }
  // Find the Documents path
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  // This function is triggered when the "Read" button is pressed
  Future<void> _readData() async {
    final dirPath = await _getDirPath();
    final myFile = File('$dirPath/scander.txt');
    final data = await myFile.readAsString(encoding: utf8);
    setState(() {
      _content = data;
    });
  }
// This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData() async {
    final _dirPath = await _getDirPath();

    final _myFile = File('$_dirPath/scander.txt');
    // If data.txt doesn't exist, it will be created automatically

    await _myFile.writeAsString(_textController.text);
    _textController.clear();
  }



  Future<void> writeFile(String text) async {// todo add
    final _dirPath = await _getDirPath();
    final file = File('$_dirPath/scander.txt');

    IOSink sink = file.openWrite(mode: FileMode.append);
    sink.add(utf8.encode('$text\n\n')); //Use newline as the delimiter
    await sink.flush();
    await sink.close();
    _textController.clear();
  }
}
