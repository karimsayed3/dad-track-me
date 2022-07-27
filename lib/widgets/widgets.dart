import 'package:flutter/material.dart';

textForm (
  {
     TextEditingController? controller,
    required String hintText,
    required String errorMessage,
  }
){
  return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Color(0xffF5591F),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(0xffF5591F),
                    ),
                    hintText: hintText,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return errorMessage;
                    }
                    return null;
                  },
                ),
              );
}