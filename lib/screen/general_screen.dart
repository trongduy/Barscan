
import 'package:audioplayers/audioplayers.dart';
import 'package:barcode_scander/helper/singleton_storage.dart';
import 'package:barcode_scander/models/config_model.dart';
import 'package:barcode_scander/network/rest_client.dart';
import 'package:barcode_scander/widgets/loading_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class GeneralScreen<T extends StatefulWidget> extends State<T> {

  RestClient? client ;
  LoadingView loadingView =LoadingView();
  String currentUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void initState() {
    init();
    super.initState();

  }
  showLoading(bool show){
    if(show){
      loadingView.show(context);
    }else{
      loadingView.hide();
    }
  }
  init() async {
    await SingletonStorage.getInstance();
    await SingletonStorage.getURL().then((value) => {
      if (value != null)
        {
          setState(() {
            currentUrl = value;
            client =RestClient(this,currentUrl);
          })
        }
    });
  }
  setUrl(String url){
    setState(() {
      currentUrl = url;
      client =RestClient(this,currentUrl);
    });
  }
  setConfigFtp(ConfigModel config)async{
    await SingletonStorage.getInstance();
    SingletonStorage.setConfigName(config.configName!);
    SingletonStorage.setDescriptionName(config.descriptionName!);
  }

  playSoundError() async {
    AudioPlayer audioPlayer = AudioPlayer();
    int result = await audioPlayer.play('http://113.161.222.192:8686/Sound/error2.mp3');
    if (result == 1) {
      // success
    }
  }
  showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        gravity: ToastGravity.TOP,
        fontSize: 16.0);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void dispose() {
    print('GeneralScreen dispose');

    super.dispose();
  }
  void log(String data){
    if (kDebugMode) {
      print(data);
    }
  }
}
