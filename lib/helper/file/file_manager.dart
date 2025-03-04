import 'dart:convert';
import 'dart:io';

import '../../models/bar_code_model.dart';

class FileManager{
  FileManager? file;

  Future<String> getFolders()async{
 Directory newDirectory = await Directory("/sdcard/BarCodeScander").create(recursive: true);
  // Directory newDirectory = await Directory("/sdcard/Download").create(recursive: true);
    return newDirectory.path;
  }
  Future <File> localFile(fileName) async {
    final path = await getFolders();
    return File('$path/$fileName.txt');
   // return File('$path/$fileName.png');
  }
  Future<int> deleteFile() async {

    try {
      final path = await getFolders();
      final dir = Directory(path);
      dir.deleteSync(recursive: true);
      return 1;
    } catch (e) {
      return 0;
    }

  }

  Future<void> writeFile(String filename,List<BarCodeModel> list) async {// todo add
    final file = await localFile(filename) ;

    IOSink sink = file.openWrite(mode: FileMode.append);
    // sink.add(utf8.encode(' STT\t Code \n\n'));
    for (var element in list) {
      //sink.add(utf8.encode(' ${element.stt}\t ${element.customerCode}\n\n'));
      sink.add(utf8.encode('${element.customerCode}\t\t${element.serial}\n\n')); //Use newline as the delimiter
    }
    await sink.flush();
    await sink.close();
    //  await upload();
  }
}