
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:learning/shared/compnents/constants.dart';


Widget defaultTextFormFeild({
  @required TextEditingController controller,
  @required IconData pre,
  @required String HintText,
  Function validate,
  var onChange,
  IconData suff,
  var suffixWidget,
  bool isObscure = false,
  @required var KeyType,
  Function suffPress,
  var submit,
}) =>
    TextFormField(

      keyboardType: KeyType,
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      maxLines: 1,
      onFieldSubmitted: submit,
      decoration: InputDecoration(
        prefixIcon: Icon(pre),
        suffix: suffixWidget,
        suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: HintText,
      ),
      validator: validate,
    );

  defaultButton({
  @required onPress,
  @required String text,
  double fontSize = 18,
    Color defaultFontColor = Colors.white,

})
  =>  Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: MaterialButton(

      onPressed: onPress,
      color: HexColor('#29A68D'),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: defaultFontColor , fontWeight: FontWeight.w700 , fontSize: fontSize),
      ),
    ),
  );

snackBar(context , {@required text , color = Colors.green}  )
{
  var snackBar = SnackBar(content: Text(text),backgroundColor: color,);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

 navigateTo(context , screen)
{
  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
navigateAnd(context , screen)
{
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> screen), (route) => false);
}

