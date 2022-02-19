import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void navigateTo(context,widget)=>Navigator.push(context,
    MaterialPageRoute(builder: (context)=>widget)
);
void navigateAndFinished(context,widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context)=>widget) ,
        (route) => false);
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
    //  style:const TextStyle( color: Colors.greenAccent) ,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      //onChanged: onChange != null? onChange() : null,
      onTap: onTap != null? onTap() : null,
      validator: validate,
      decoration: InputDecoration(
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
        border:  OutlineInputBorder(
          gapPadding: 10,
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
// Widget defaultButton({
//   double width = double.infinity,
//   Color background = Colors.blue,
//   bool isUpperCase = true,
//   double radius = 3.0,
//   required Function function,
//   required String text,
// }) =>
//     Container(
//       width: width,
//       height: 50.0,
//       child: MaterialButton(
//         onPressed: function(),
//         child: Text(
//           isUpperCase ? text.toUpperCase() : text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           radius,
//         ),
//         color: background,
//       ),
//     );
Widget defaultButton({
  double width = double.infinity,
 // Color background = Colors.blue,
  bool isUpperCase = true,

  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,



      // foregroundDecoration:  BoxDecoration(
      //   borderRadius: BorderRadius.circular(20)
      // ),
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
        borderRadius: BorderRadius.circular(20),
       gradient:  const LinearGradient(
         begin: Alignment.bottomLeft,
           end: Alignment(0.8, 0.0),
           colors: [
             Colors.deepPurple,
             Colors.purple,
           ],
           //tileMode: TileMode.repeated

       )
      ),
    );
void showToast({required String text,required ToastStates states})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:choseToastColor(states),
    textColor: Colors.black,
    fontSize: 16.0
);
//enum
enum ToastStates{SUCCESS,ERROR,WARNING}
Color choseToastColor(ToastStates states)
{
  Color color;
 switch(states)
{
  case ToastStates.SUCCESS:
    color= Colors.green;
    break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
      case ToastStates.WARNING:
        color=Colors.amber;
        break;
}
return color;
}