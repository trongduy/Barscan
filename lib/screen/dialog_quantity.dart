import 'package:flutter/material.dart';

import '../widgets/quantity_input.dart';
import '../widgets/widget.dart';

class DialogQuantity{
  BuildContext? context;
  DialogQuantity({this.context});

  Function? dialogQuantity(ValueChanged<String> quantity) {
    var quantityController =TextEditingController();
    Dialog dialog = Dialog(
      child: Container(

        padding: const EdgeInsets.only(left: 10,top: 15,right: 10,bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            text('Nhập số lượng'),
            const SizedBox(height: 15,),
            QuantityInput(hintText: '',textController: quantityController,action: TextInputAction.done),
            const SizedBox(height: 15,),

            InkWell(child: button(Text('OK', style: const TextStyle(fontSize: 15, color: Colors.white))),
              onTap: (){
                String amount =quantityController.text.trim();
                if(amount.isNotEmpty){
                  print('quantity 2: $amount');
                  quantity(amount);
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