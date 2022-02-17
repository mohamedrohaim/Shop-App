import 'package:flutter/material.dart';
import 'package:test1/shared/colors.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  //Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      style: const TextStyle(color: Colors.purple),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      //onChanged: onChange != null? onChange() : null,
      onTap: onTap != null? onTap() : null,
      validator: validate,
      decoration: InputDecoration(
          border:  OutlineInputBorder(
        borderRadius:  BorderRadius.circular(25.0),
      gapPadding: 10.0,
      ),

        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: ()
          {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: ()
        {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
void navigateTo(context,widget)=>Navigator.push(context,
  MaterialPageRoute(builder: (context)=>widget),
);
void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(
        context,
      MaterialPageRoute(
          builder: (context)=>widget
      ),
        (route)
      {

        return false;
      },
);
