import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String ?hintText;
  final TextEditingController? textController;
  final TextInputAction? action;
  final VoidCallback? callback;
  const PasswordInput({ required this.hintText, required this.textController, required this.action, this.callback});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility), onPressed:_toggle,padding: EdgeInsets.zero,),
        suffixIconConstraints: BoxConstraints(maxHeight: 16),
        border: InputBorder.none,
        hintText: '',

        //filled: true,
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
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      controller: widget.textController,
      //obscureText: _obscureText,
      obscureText: _obscureText,
      autofocus: true,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black, fontSize: 15),
      validator: (val) {
        return val!.length >= 1 ? null : 'Vui lòng nhập mật khẩu';
      },

      textInputAction: widget.action,
      onFieldSubmitted: (value){
        if(widget.action==TextInputAction.done){
          if(widget.callback!=null){
            widget.callback!();
          }
        }
      },

    );
  }
}
