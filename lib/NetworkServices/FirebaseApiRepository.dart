import 'dart:convert';

import 'package:customer_listing_desktop_app/NetworkServices/AuthenticationHelper.dart';
import 'package:customer_listing_desktop_app/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository{

  final String projectID = 'customerlistingapp';
  final String key = 'AIzaSyBed6jFQKAQ_Dljm-awl3CHqrnHGYLVmPw';


  FetchListOfNotifications() async {

    final String pathOfDataDocumentOrCollection = "funkaaratoons@gmail.com/UserDetails/customers";
    final String url = "https://firestore.googleapis.com/v1beta1/projects/${projectID}/databases/(default)/documents/${pathOfDataDocumentOrCollection}?key=${key}";
    // Use fetch to request the API information

    var request = http.Request('GET', Uri.parse(url));
    //var request = http.Request('GET', Uri.parse('https://ifsc.razorpay.com/BARB0DBGHTW'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print(result);
      return result;
    }
    else {
      print(response.reasonPhrase);
      return "Not Found";
    }

  }

  /*
  // Union field value_type can be only one of the following:
  "nullValue": null,
  "booleanValue": boolean,
  "integerValue": string,
  "doubleValue": number,
  "timestampValue": string,
  "stringValue": string,
  "bytesValue": string,
  "referenceValue": string,
  "geoPointValue": {
    object (LatLng)
  },
  "arrayValue": {
    object (ArrayValue)
  },
  "mapValue": {
    object (MapValue)
  }
  * */

  Future<bool> AddUser(String? mailId,String? password) async {


    //Sign Up the User
    bool isUserSignedUpSuccessfully = await AuthenticationHelper().signUp(mailId, password);
    //Save his ID Token
    //Use Id Token To Add

    if(!isUserSignedUpSuccessfully){
      return false;
    }



    var headers = {
      'Content-Type': 'application/json'
      //If U Use Authentication For Secure Access
      //Only Signed User Can Access if
      //'Authorization': "Bearer %s" % id_token
    };

    var request = http.Request('POST', Uri.parse('https://firestore.googleapis.com/v1beta1/projects/customerlistingapp/databases/(default)/documents/$mailId?documentId=UserDetails'));
    request.body = json.encode({
      //"documentId": {"stringValue": "Maaki"},
      "fields": {
        "mail_id": {"stringValue": mailId}
      }
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

  AddCustomer(String text, String text2, String text3, String text4, DateTime dateTime, DateTime dateTime2, String text5, String text6, String text7, String text8, String text9) {}

  Future<List?> FetchListOfCustomers() async {
    List? docs;
    final prefs = await SharedPreferences.getInstance();
    String? mailId = await prefs.getString('email');
    print("email");
    print(mailId);
    if(mailId==null){
      return null;
    }
    //print("Adding"+contact.displayName!);
    bool isCustomerAddedSuccessfully = false;

    final String pathOfDataDocumentOrCollection = "ashrafking@gmail.com/UserDetails/customers";
    final String url = "https://firestore.googleapis.com/v1beta1/projects/${projectID}/databases/(default)/documents/${pathOfDataDocumentOrCollection}?key=${key}";
    // Use fetch to request the API information

    var request = http.Request('GET', Uri.parse(url));
    //var request = http.Request('GET', Uri.parse('https://ifsc.razorpay.com/BARB0DBGHTW'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print(result);
      Map valueMap = jsonDecode(result);
      print(valueMap);
      print(valueMap);
      print(valueMap.keys);
      docs = valueMap["documents"];
      print("Documents Dekho");
      print(docs);
      return docs;
    }
    else {
      print(response.reasonPhrase);
      return docs;
    }
  }

  
}