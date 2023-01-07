import 'dart:convert';

import 'package:customer_listing_desktop_app/utils/globals.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class AuthenticationHelper {


  //SIGN UP METHOD
  Future<bool> signUp(String? email, String? password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$webApiKeyFirebase'));
    request.body = json.encode({
      "email": "$email",
      "password": "$password",
      "returnSecureToken": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  //SIGN IN METHOD
  Future<bool> signIn(String? email, String? password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$webApiKeyFirebase'));
    request.body = json.encode({
      "email": "$email",
      "password": "$password",
      "returnSecureToken": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    print('signout');
  }

}