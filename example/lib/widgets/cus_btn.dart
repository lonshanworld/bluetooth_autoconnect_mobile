import 'package:flutter/material.dart';

class CusBtn extends StatelessWidget {

  final String txt;
  final VoidCallback func;
  const CusBtn(this.txt, this.func,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        func();
      },
      child: Text(
        txt,
      ),
    );
  }
}
