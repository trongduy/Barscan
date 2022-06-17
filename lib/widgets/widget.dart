import 'package:flutter/material.dart';

InputDecoration decoration() {
  return InputDecoration(
    border: InputBorder.none,
    hintText: '',
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 4.0, top: 6.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(5.0),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}
InputDecoration decorationWhite( ) {
  return InputDecoration(
    border: InputBorder.none,
    hintText: '',
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 4.0, top: 6.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(5.0),
    ),

    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}
InputDecoration decorationWhitePass( bool _obscureText,VoidCallback callback) {
  return InputDecoration(
    suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility), onPressed:callback,padding: EdgeInsets.zero,),
    suffixIconConstraints: BoxConstraints(maxHeight: 16),
    border: InputBorder.none,
    hintText: '',
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 4.0, top: 6.0),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(5.0),
    ),

    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}



Container button(Widget widget){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blue,
    ),
    padding: const EdgeInsets.only(
        left: 25, top: 10, right: 25, bottom: 10),
    child: widget,

  );
}
Text text(String text){
  return Text(text,style: const TextStyle(fontSize: 15,color: Colors.black),);
}
Text textBold(String text){
  return Text(text,style: const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),);
}