import 'package:barcode_scander/models/bar_code_model.dart';
import 'package:flutter/material.dart';

class ItemBarCode extends StatefulWidget {
  final BarCodeModel? item;
  final VoidCallback? onRemove;
  const ItemBarCode({Key? key,required this.item, required this.onRemove}) : super(key: key);

  @override
  State<ItemBarCode> createState() => _ItemBarCodeState();
}

class _ItemBarCodeState extends State<ItemBarCode> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left:10,top: 10,right: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${widget.item!.stt}',style: const TextStyle(fontSize: 13, color: Colors.black,fontWeight:FontWeight.bold),),
          const SizedBox(width: 15, ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Text('${widget.item!.customerCode}',style: const TextStyle(fontSize: 16, color: Colors.black,fontWeight:FontWeight.bold ),)),
                const SizedBox(width: 20, ),
                Expanded(child: Text('${widget.item!.serial}',style: const TextStyle(fontSize: 16, color: Colors.black,fontWeight:FontWeight.bold ),)),
              ],
            ),
          ),
          InkWell(
            child: const Icon(Icons.close, color: Colors.black, size: 28,),
            onTap: widget.onRemove!
            ,)
        ],
      ),
    );
  }
}
