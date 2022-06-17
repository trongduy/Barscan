import 'dart:async';
import 'dart:io';

import 'package:barcode_scander/helper/singleton_storage.dart';
import 'package:barcode_scander/items/item_barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';
import '../helper/file/file_manager.dart';
import '../models/bar_code_model.dart';
import '../network/request/post_model.dart';
import '../widgets/widget.dart';
import 'general_screen.dart';

class NewScanScreen extends StatefulWidget {
  const NewScanScreen();

  @override
  State<NewScanScreen> createState() => _NewScanScreenState();
}

class _NewScanScreenState extends GeneralScreen<NewScanScreen> {
  List<BarCodeModel> list = <BarCodeModel>[];
  List<PostModel> listPost = <PostModel>[];

//  List<DataPost> data = <DataPost>[];
  DataPost data = DataPost();
  BarCodeModel? newScan;
  String? nameFile = '';

  bool isUpload = false;

  FileManager fileManager = FileManager();
  final ScrollController _scrollController = ScrollController();

  final codeController = TextEditingController();
  final codeFocusNode = InputWithKeyboardControlFocusNode();

  final serialController = TextEditingController();

  final serialFocusNode = InputWithKeyboardControlFocusNode();

  final nameFileController = TextEditingController();
  
  String configName='';
  bool keyboardShowing =false;
  late StreamSubscription<bool> keyboardSubscription;
  @override
  void initState() {
    super.initState();
    _checkingKeybord();
    _getConfigName();
    _resetView();
    _listener();

  }
  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
  _checkingKeybord(){
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    log('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      log('Keyboard visibility update. Is visible: $visible');
      setState(() {
        keyboardShowing =visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          if (codeController.text.isEmpty) {
            codeFocusNode.unfocus();
            codeFocusNode.requestFocus();
          } else if (serialController.text.isEmpty) {
            serialFocusNode.unfocus();
            serialFocusNode.requestFocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hàng quét'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        _viewInput(),
                        const SizedBox(
                          height: 10,
                        ),
                        _listData()
                      ],
                    ),
                  ),
                  _bottom(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewInput() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Row(
            children: [
              text('Mã hàng: '),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: InputWithKeyboardControl(
                    focusNode: codeFocusNode,
                    onSubmitted: (value) {
                      if(value.isNotEmpty){
                        focusSerial();
                      }

                    },
                    autofocus: true,
                    controller: codeController,
                    width: 250,
                    startShowKeyboard: false,
                    buttonColorEnabled: Colors.blue,
                    buttonColorDisabled: Colors.black,
                    underlineColor: Colors.black,
                    showUnderline: true,
                    showButton: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              text('Serial:  '),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: InputWithKeyboardControl(
                    focusNode: serialFocusNode,
                    onSubmitted: (value) {
                      //_getDataFromTextField();
                      if(value.isNotEmpty){
                        _checkList();
                      }

                    },
                    autofocus: true,
                    controller: serialController,
                    width: 250,
                    startShowKeyboard: false,
                    buttonColorEnabled: Colors.blue,
                    buttonColorDisabled: Colors.black,
                    underlineColor: Colors.black,
                    showUnderline: true,
                    showButton: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _listData() {
    return list.isEmpty
        ? Container()
        : Flexible(
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 1,
              ),
              physics: const ClampingScrollPhysics(),
              //ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ItemBarCode(
                  item: list[index],
                  onRemove: () {
                    setState(() {
                      list.removeAt(index);
                      list;
                    });
                  },
                );
              },
            ),
          );
  }

  Widget _bottom() {
    return list.isEmpty
        ? Container()
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.grey.shade200,
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                      color: Colors.black)
                ]),
            child: Column(
              children: [
                const Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, top: 10, right: 40, bottom: 10),
                  child: Row(
                    children: [
                      text('Tên file:  '),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: TextField(
                          controller: nameFileController,
                          decoration: decorationWhite(),
                         // enabled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _clearAll();
                        },
                        child: button(const Text(
                          'Xóa',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          _save();
                        },
                        child: button(const Text(
                          'Lưu',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
  _listener() async{
    codeController.addListener(() {
      log('keyboardShowing $keyboardShowing');

      if(!keyboardShowing){
        if(codeController.text.isNotEmpty){
          focusSerial();
        }
      }
    });
    serialController.addListener(() {
      log('keyboardShowing $keyboardShowing');
      if(!keyboardShowing){
        if(serialController.text.isNotEmpty){
          _checkList();
        }
      }
    });
  }

  _checkList(){
    showLoading(true);
    String code = codeController.text;
    String serial = serialController.text;
    if(code.compareTo(serial)==0){
      showMessage('Mã hàng và Serial trùng nhau');
      focusSerial();
      playSoundError();
      showLoading(false);
      return;
    }
    newScan!.customerCode = code;
    newScan!.serial = serial;
    for (var item in list) {
      if(code.compareTo(item.customerCode!)==0&&serial.compareTo(item.serial!)==0){
        showMessage('Mã tồn tại');
        focusSerial();
        playSoundError();
        showLoading(false);
        return;
      }
    }
    _updateList();
  }
  _updateList() async{
      setState(() {
      list.add(BarCodeModel(
          stt: list.length + 1,
          customerCode: newScan!.customerCode!,
          serial: newScan!.serial!));
    });
      showLoading(false);
    await _resetView();
    await _scrollToBottom();

  }
  _getConfigName()async{
    await SingletonStorage.getInstance();
     await SingletonStorage.getConfigName().then((value) => {
      if(value!=null){
        setState((){
          configName =value;
        }),
      }
    });
  }

  _resetView() async{
    setState(() {
      newScan = BarCodeModel(customerCode: '', serial: '');
      nameFileController.text = '';
      _newScan();
    });
  }
  focusCode()async{
    codeController.text = '';
    codeFocusNode.requestFocus();
    // await Future.delayed(const Duration(milliseconds: 1300), () {
    //   codeFocusNode.requestFocus();
    // });
  }
  focusSerial()async{
    serialController.text='';
    await  _unSerial();
    await Future.delayed(const Duration(milliseconds: 300), () {
    //  serialFocusNode.requestFocus();
      FocusScope.of(context).requestFocus(serialFocusNode);
    });
  }
  _unSerial()async{
    if(serialFocusNode.hasFocus){
      serialFocusNode.unfocus();
    }
  }
  _newScan()async{
    codeController.text='';
      codeFocusNode.unfocus();
    serialController.text = '';
    serialFocusNode.unfocus();
    await Future.delayed(const Duration(seconds: 1), () {
      codeFocusNode.requestFocus();
    });
  }
  _resetList() {
    setState(() {
      nameFile = '';
      list.clear();
      if (data.dataPost != null) {
        data.dataPost!.clear();
      }
    });
  }

  _hideKeyBoard() async {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  _save() async {
    if (list.isNotEmpty &&
        nameFileController.text.trimLeft().trimRight().isNotEmpty) {
      setState(() {
        nameFile = nameFileController.text.trimLeft().trimRight();
      });
      fileManager.writeFile(nameFile!, list);
      _resetView();
      _setListFileToJson();
    }
    ;
  }
  _setListFileToJson() async {
    for (var item in list) {
      listPost
          .add(PostModel(productId: item.customerCode, serial: item.serial));
    }

    if (listPost.isNotEmpty) {
      data.dataPost = listPost;
      //print('data ${data.toString()}');
      upload();
    }
  }

  upload() async {
    await _hideKeyBoard();
    setState(() {
      isUpload = true;
    });
    await client!.postFile(data, nameFile!,configName).then((value) => {
          if (mounted)
            {
              if (value)
                {
                  showMessage('upload file Success'),
                  _resetList(),
                  _resetView(),
                }
              else
                {
                  showMessage('upload file Fail'),
                }
            }
        });
    setState(() {
      isUpload = false;
    });
  }

  _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 300));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }


  Widget loadingCenter() {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Bạn có muốn thoát màng hình Scan không ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Thoát'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> _clearAll() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Bạn có chắc xóa dữ liệu hiện tại không ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(true),
                  _resetView(),
                  _resetList()
                },
                child: const Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
