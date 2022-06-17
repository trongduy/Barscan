import 'dart:io';

// import 'package:ftpconnect/ftpconnect.dart';
//
//
// class FtpConnection{
//   FTPConnect? _ftpConnect;
//   FtpConnection.getInstance() {
//     _config();
//   }
//   void _config(){
//     _ftpConnect =FTPConnect('113.161.222.192',port: 2122,
//         user: 'ftpuser', pass: 'Logitem@2020');
//   }
//   Future<bool> uploadFile(File fileToUpload) async {
//     _log('fileToUpload ${fileToUpload.path}');
//     _log('existsSync ${fileToUpload.existsSync()}');
//     try {
//       await _log('Connecting to FTP ...');
//       await _ftpConnect!.connect();
//       await _ftpConnect!.changeDirectory('test');
//       await _log('Uploading ...');
//      //await _ftpConnect!.uploadFileWithRetry(fileToUpload,pRetryCount: 3);
//      await _ftpConnect!.uploadFile(fileToUpload);
//       await _ftpConnect!.disconnect();
//       return true;
//     }
//     // on SocketException catch (e) {
//     //   _log('ERRORE_SocketException: ${e.message}');
//     //   return false;
//     // }
//     catch (e) {
//       await _log('Error upload: ${e.toString()}');
//       return false;
//     }
//   }
//   Future<void> upload(File file)async{
//     ///_log('file ${file.existsSync()}');
//     bool? res;
//     try {
//       await _log('Connecting to FTP .1..');
//        bool connect = await _ftpConnect!.connect();
//       await _log('connect FTP is $connect');
//       await _log('Uploading ...');
//       await _ftpConnect!.changeDirectory('test');
//      // await _ftpConnect!.changeDirectory('File_Scan');
//       // res = await _ftpConnect!.uploadFileWithRetry(file,pRetryCount: 2);
//     await _ftpConnect!.uploadFile(file,);
//       await _log('file uploaded sucessfully');
//       await _ftpConnect!.disconnect();
//
//     } catch (e) {
//     //  res =false;
//       print('Error FTP : ${e.toString()}');
//     }
//     //return res;
//   }
//   Future<void> _log(String log) async {
//     print(log);
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   createDirectory()async{
//     await _ftpConnect!.connect();
//     _ftpConnect!.createFolderIfNotExist('Upload');
//   }
//
// }
//
//


// todo https://stackoverflow.com/questions/51136512/flutter-reading-a-file-as-a-stream