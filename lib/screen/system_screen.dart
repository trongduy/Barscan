import 'dart:async';
import 'dart:io';

import 'package:barcode_scander/helper/constans.dart';
import 'package:barcode_scander/models/config_model.dart';
import 'package:barcode_scander/screen/general_screen.dart';
import 'package:flutter/material.dart';

import '../helper/singleton_storage.dart';
import '../helper/constans.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

class SysTemScreen extends StatefulWidget {
  final VoidCallback? callback;

  const SysTemScreen({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  State<SysTemScreen> createState() => _SysTemScreenState();
}

class _SysTemScreenState extends GeneralScreen<SysTemScreen> {
  final pathController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
       DropdownMenuItem(
          child: Text(Constants.url_1),
          value: Constants.url_1),
       DropdownMenuItem(
          child: Text(Constants.url_2),
          value: Constants.url_2),
    ];
    return menuItems;
  }

  List<ConfigModel> listConfig = <ConfigModel>[];

  List<DropdownMenuItem<ConfigModel>> dropdownConfig = <DropdownMenuItem<ConfigModel>>[];
  ConfigModel? config ;
  String fptDescriptionName='';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hệ Thống'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text('Đường dẫn'),
              //_viewSelect(),
              _viewInput(),
              const SizedBox(
                height:15,
              ),
              const Divider(height: 1,),
              const SizedBox(
                height:15,
              ),
              text('Thiết lập Ftp'),

              _viewSelectFtp(),
              const SizedBox(
                height: 20,
              ),
            _viewSave()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _init();
  }
Widget _viewInput(){
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 5,right: 20,bottom: 0),
      child: TextField(
        controller: pathController,
        decoration: decoration(),
        autofocus: false,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          //_getDataFromTextField();
        },
      ),
    );
}
  Widget _viewSelect() {
    return DropdownButton(
      value: currentUrl.isEmpty ? null : currentUrl,
      items: dropdownItems,
      hint: Text(currentUrl.isEmpty ? 'Chọn đường dẫn' : currentUrl),
      style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: (String? newValue) {
        setState(() {
          currentUrl = newValue!;
          SingletonStorage.setURL(currentUrl);
          widget.callback!();
        });

        showMessage('Đã lưu');
      },
    );
  }
  // 12512032018
  Widget _viewSelectFtp() {
    return DropdownButton<ConfigModel>(
        hint:  Text(fptDescriptionName),
        value: config,
        onChanged: (ConfigModel? value) {
          setState(() {
            config  = value;
          });
          setConfigFtp(value!);
        },
        items: dropdownConfig
    );
    // return dropdownConfig.isNotEmpty?DropdownButton<ConfigModel>(
    //   value: configModel==null?null:configModel,
    //  // value: configModel,
    //   hint: Text(configModel==null ? 'Chọn Ftp' : configModel!.descriptionName!),
    //   items:dropdownConfig,
    //   style: const TextStyle(color: Colors.black, fontSize: 16),
    //   onChanged: (ConfigModel?newValue) {
    //     setState(() {
    //       configModel =newValue!;
    //       SingletonStorage.setConfigName(configModel!.configName!);
    //       SingletonStorage.setDescriptionName(configModel!.descriptionName!);
    //
    //     });
    //   },
    // ):Container();
    //   return DropdownButton(){
    //
    // }
    //  return dropdownConfig.isNotEmpty?DropdownButton<ConfigModel>(
    //    value:  config1,
    //    items: dropdownConfig,
    //    onChanged:
    //      (ConfigModel? value) {
    //            setState(() {
    //              // config =value!;
    //              // SingletonStorage.setConfigName(config!.configName!);
    //              // SingletonStorage.setDescriptionName(config!.descriptionName!);
    //
    //            });
    //      },
    //  ):Container();

  }

  Widget _viewSave() {
    return InkWell(
      child: button(const Text(
        ' Lưu ',
        style: TextStyle(fontSize: 15, color: Colors.white),
      )),
      onTap: () {
        _checkURL();
      },
    );
  }

  _init() async {

    await SingletonStorage.getInstance();
    await SingletonStorage.getURL().then((value) => {
          if (value != null)
            {
              setState(() {
                currentUrl = value;
              }),

            }else{
            setState(() {
              currentUrl = Constants.url_2;
            })
          }
        });
    setUrl(currentUrl);
    setState(() {
      pathController.text = currentUrl;
    });

    // await SingletonStorage.getConfigName().then((value) => {
    //   if (value != null)
    //     {
    //
    //       setState(() {
    //         configModel.configName =fptConfigName;
    //       }),
    //     }
    // });
    await SingletonStorage.getDescriptionName().then((value) => {
      if (value != null)
        {

          setState(() {
           fptDescriptionName=value;

          }),
        }else{
        setState(() {
          fptDescriptionName='Chọn Ftp';
        })
      }
    });
    await _getConfig();

  }

  _getConfig() async {
    await client?.getConfig("android").then((value) => {
          if (value.isNotEmpty)
            {
              setState(() {
                listConfig = value;
              }),
              if (listConfig.isNotEmpty)
                {
                  for (ConfigModel item in listConfig)
                    {
                      setState(() {
                        dropdownConfig.add(DropdownMenuItem(
                            child: Text(item.descriptionName!), value: item));
                      }),

                    }
                }
            }
        });
  }

  _checkURL() async {
    String url = pathController.text.trim();
    if (url.isEmpty) {
      showMessage('Url không hợp lệ');
      return;
    }
    try {
      final path = Uri.parse(url);
      http.Response response = await http.get(path);
      if (response.statusCode == 200) {
        showMessage('Đã lưu');
        widget.callback!();
        setState(() {
          currentUrl = url;
        });
        SingletonStorage.setURL(url);
      } else {
        showMessage('url không tồn tại');
      }
    } on TimeoutException catch (e) {
      showMessage('url không tồn tại');
    } on SocketException catch (e) {
      showMessage('url không tồn hợp lệ');
    } on Error catch (e) {
      showMessage('url không tồn hợp lệ');
    } catch (e) {
      showMessage('url không tồn hợp lệ:');
    }
  }
}
