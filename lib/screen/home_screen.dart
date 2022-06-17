import 'dart:io';

import 'package:barcode_scander/screen/general_screen.dart';
import 'package:barcode_scander/screen/system_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helper/requestPermission.dart';

import '../helper/singleton_storage.dart';
import '../widgets/widget.dart';
import 'dialog_password.dart';
import 'new_scan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends GeneralScreen<HomeScreen> {

  bool? permission = false;
  String url='';
  String configName='';
  String descriptionName='';
  bool _obscureText=true;

  @override
  void initState() {
    _init();
    super.initState();
    _checkPermission();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),centerTitle: true,
      ),
      body: Center(
        child: _viewContent(),
      ),
    );
  }
  _init() async {
    await SingletonStorage.getInstance();
    await SingletonStorage.getURL().then((value) => {
      if (value != null)
        {
          setState(() {
            url = value;

          }),
          setUrl(url)
        }
    });
    await SingletonStorage.getConfigName().then((value) => {
      if (value != null)
        {
          setState(() {
            configName = value;
          }),
        }
    });
    await SingletonStorage.getDescriptionName().then((value) => {
      if (value != null)
        {
          setState(() {
            descriptionName = value;
          }),
        }
    });

  }
  Widget _viewContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _viewNewScan(),
        const SizedBox(
          height: 20,
        ),
        _viewUpload()
      ],
    );
  }

  Widget _viewNewScan() {
    return InkWell(
      child: button(
        const Text(
          'Scan Hàng',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      onTap: () {
        if(url.isEmpty||configName.isEmpty){
          showMessage('Bạn chưa thiết lập hệ thống');
          return;
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewScanScreen()));
      },
    );
  }

  Widget _viewUpload() {
    return Column(
      children: [
        InkWell(
          child: button(
            const Text(
              'Hệ Thống',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          onTap: () {
            DialogPassWord(context: context).dialogPassword((pass){
              _checkPassword(pass);
            },);

          },
        ),
        const SizedBox(height: 20,),
        text(url.isEmpty?'bạn chưa thiết lập hệ thống':url),
        const SizedBox(height: 10,),
        descriptionName.isNotEmpty?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text('Nơi lưu trữ: '),
            textBold(descriptionName)
          ],
        ):Container(),
        
      ],
    );
  }

  _checkPermission() async {
    await PermissionApp.requestPermission(Permission.storage).then((value) => {
          setState(() {
            permission = value;
          }),
          // _showMessage( 'Permission is $permission')
        });
  }

  _checkPassword(String pass)async{
    // todo pass default: 12512032018
    if(url.isEmpty){
      if(pass.compareTo('12512032018')==0){
        openScreenSystem();

      }
      else{
        showMessage('Mật khẩu không đúng');
      }
    }
    else{

     await client!.checkPassword(pass).then((value) =>{

        if(value!=null){
          if(value.status==1){
            openScreenSystem()
          }else{
            showMessage(value.message!)
          }
        }else{
          showMessage('Có lỗi xẫy ra, vui lòng thử lại')
        }
      });

    }
  }
  openScreenSystem()async{
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  SysTemScreen(callback: (){
            _init();
          },)
          ));
    });

  }
}
