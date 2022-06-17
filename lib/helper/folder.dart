import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppUtil{

  static Future<String> createFolderInAppDocDir(String folderName) async {

    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/$folderName/');

    if(await _appDocDirFolder.exists()){ //if folder already exists return path
      print('_appDocDirFolder ${_appDocDirFolder.path}');
      return _appDocDirFolder.path;
    }else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      print('_appDocDirFolder ${_appDocDirFolder.path}');
      return _appDocDirNewFolder.path;
    }
  }

}// /data/user/0/vht.com.barcode/app_flutter/BarCodeScander/