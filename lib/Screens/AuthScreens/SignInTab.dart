import 'package:customer_listing_desktop_app/utils/utility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../NetworkServices/AuthenticationHelper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;

  String? emailErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return // Generated code for this Column Widget...
      Container(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 400,
              padding: EdgeInsets.only(top: 20,bottom:10 ),
              child: TextFormField(
                controller: emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  errorText: emailErrorText,
                  labelText: 'Email Address',
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Enter your email...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
              ),
            ),
            Container(
              width: 400,
              padding: EdgeInsets.only(top: 10,bottom:20 ),
              child: TextFormField(
                maxLines: 1,
                controller: passwordController,
                obscureText: !passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: passwordErrorText,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Enter your password...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,

                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      passwordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xFF57636C),
                      size: 20,
                    ),
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              width:200 ,
              height: 50,
              //padding: EdgeInsets.only(top: 20,bottom:0 ),
              child: ElevatedButton(
                onPressed: () async {

                  //Check Validation

                  ///Show Loader here
                  ///Call Api
                  ///Hide Loader
                  ///Navigate if Success
                  if(emailAddressController.text.isEmpty){
                    emailErrorText = "Email cannot be empty";
                    setState(() {});
                    return;
                  }

                  //Check If Valid Email Address
                  if(!EmailValidator.validate(emailAddressController.text)){
                    emailErrorText = "Invalid Email Address";
                    setState(() {});
                    return;
                  }

                  if(passwordController.text.isEmpty){
                    emailErrorText = null;
                    passwordErrorText = "password cannot be empty";
                    setState(() {});
                    return;
                  }

                  if(emailAddressController.text.isNotEmpty){
                    if(passwordController.text.isNotEmpty){
                      //Show Loader
                      Utility().PleaseWaitLoaderShow(context);
                      bool isSignInSuccessful = await AuthenticationHelper().signIn(emailAddressController.text,passwordController.text);
                      Loader.hide();
                      //Show Dialog Notification
                      if(isSignInSuccessful){
                        Utility().showCustomDialogBox(isSignInSuccessful,"Success","Sign In Success",context);
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.pushReplacementNamed(context, "HomeScreen");
                      }
                      else{
                        Utility().showCustomDialogBox(isSignInSuccessful,"Error","Sign In Unsuccessful",context);
                      }


                    }
                  }
                  else{
                    return;
                  }
                },
                child: Text('Sign In'),

              ),
            ),
            /*Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: ElevatedButton(
                onPressed: () async {

                  //Show Loader
                  PleaseWaitLoaderShow();
                  bool googleLoggedInSuccessful = await AuthenticationHelper().handleGoogleSignIn();
                  Loader.hide();
                  //Show Dialog Notification
                  if(googleLoggedInSuccessful){
                    showCustomDialogBox(googleLoggedInSuccessful,"Success","Google Sign In Success",context);

                  }
                  else{
                    showCustomDialogBox(googleLoggedInSuccessful,"Error","Google Sign In Unsuccessful",context);
                  }

                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushReplacementNamed(context, "HomeScreen");

                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.google),
                    SizedBox(width: 10,),
                    Text('Use Gmail')
                  ],
                ),

              ),
            ),*/
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: TextButton(
                  onPressed: () {
                    print('Button-ForgotPassword pressed ...');
                  },
                  child:Text('Forgot Password?',style: TextStyle(color: Theme.of(context).backgroundColor),)
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
              child: Text(
                'Developed by 3CosInnovative Pvt Ltd.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Lexend Deca',
                  color: Color(0x98FFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
  }


}
