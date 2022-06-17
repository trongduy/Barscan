import 'package:flutter/material.dart';

import '../widgets/custom_password_textfeild.dart';
import '../widgets/widget.dart';

class DialogPassWord{
  BuildContext? context;
  DialogPassWord({this.context});

  Function? dialogPassword(ValueChanged<String> password) {
    var passController =TextEditingController();
    Dialog dialog = Dialog(
      child: Container(

        padding: const EdgeInsets.only(left: 10,top: 15,right: 10,bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            text('Xác thực mật khẩu'),
            const SizedBox(height: 15,),
            PasswordInput(hintText: '',textController: passController,action: TextInputAction.done),
            // TextField(
            //   controller: passController,
            //   decoration: decorationWhitePass(_obscureText, () {
            //     callback();
            //   }),
            //   autofocus: true,
            //   textInputAction: TextInputAction.done,
            //   onSubmitted: (value) {
            //     String pass =value.trim();
            //     if(pass.isNotEmpty){
            //       password(pass);
            //       Navigator.of(context!).pop();
            //     }
            //   },
            //   obscureText: _obscureText,
            // ),
            const SizedBox(height: 15,),

            InkWell(child: button(Text('OK', style: const TextStyle(fontSize: 15, color: Colors.white))),
              onTap: (){
              String pass =passController.text.trim();
              if(pass.isNotEmpty){
                print('pass 2: $pass');
                password(pass);
                Navigator.of(context!).pop();
              }
              },
            )

          ],
        ),
      ),
    );
    showDialog(
      // barrierDismissible: false,// touch outside dismiss
        context: context!,
        builder: (BuildContext context) => dialog);
  }
}