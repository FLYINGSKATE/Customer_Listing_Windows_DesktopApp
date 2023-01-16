import 'dart:convert';

import 'package:customer_listing_desktop_app/NetworkServices/AuthenticationHelper.dart';
import 'package:customer_listing_desktop_app/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository{

  final String projectID = 'customerlistingapp';
  final String key = 'AIzaSyBed6jFQKAQ_Dljm-awl3CHqrnHGYLVmPw';


  Future<List?> FetchListOfNotifications() async {

    List? docs;
    final prefs = await SharedPreferences.getInstance();
    String? mailId = await prefs.getString('email');
    print("email");
    print(mailId);
    if(mailId==null){
      return null;
    }
    print("StartQuery");

    final String pathOfDataDocumentOrCollection = "ashrafking@gmail.com/UserDetails";
    final String url = "https://firestore.googleapis.com/v1beta1/projects/${projectID}/databases/(default)/documents/ashrafking@gmail.com/UserDetails:runQuery?key=${key}";
    // Use fetch to request the API information

    var request = http.Request('POST', Uri.parse(url));

    print("Apna Date Time Hai!");
    DateFormat inputFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:SS'Z'");

    //DateTime date = inputFormatter.parse("2018-04-10T04:00:00.000Z");



    var formatter = new DateFormat('yyyy-MM-ddTHH:mm:ss');
    String formattedDate = formatter.format(DateTime.now());
    print("formattedDate");
    print(formattedDate);


    //where("end_date", isLessThanOrEqualTo: new DateTime.now())
    request.body = json.encode({
      "structuredQuery": {
        "where" : {
          "fieldFilter" : {
            "field": {"fieldPath": "end_date"},
            "op":"LESS_THAN_OR_EQUAL",
            "value": {"timestampValue":formattedDate+'Z' }
          }
        },
        "from": [{"collectionId": "customers"}]
      }
    });

    //var request = http.Request('GET', Uri.parse('https://ifsc.razorpay.com/BARB0DBGHTW'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print(result);
      print("Documents Dekho not");
      List valueMap = jsonDecode(result);
      print(valueMap);
      print("Documents Dekho not");
      print(valueMap);
      print(valueMap);
      docs = valueMap;
      print("Documents Dekho not");
      print(docs);
      return docs;
    }
    else {
      print("response.reasonPhrase NOT");
      print("response.reasonPhrase NOT");
      print(response.reasonPhrase);
      return docs;
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

  Future<bool> AddCustomer(
      String address,
      String area,
      String caseID,
      String eggName,
      DateTime endDate,
      DateTime startDate,
      String customerName,
      String remark,
      String unit,
      String ws,
      String customerMobileNumber,
      ) async {

    final prefs = await SharedPreferences.getInstance();
    String? mailId = await prefs.getString('mail_id');
    print("mailId");
    print(mailId);
    if(mailId==null){
      return false;
    }
    //print("Adding"+contact.displayName!);

    var formatter = new DateFormat('yyyy-MM-ddTHH:mm:ss');
    String endDateString = formatter.format(endDate);
    String startDateString = formatter.format(startDate);


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
        "mail_id": {"stringValue": mailId},

        "address":{"stringValue": address},
        "area":{"stringValue": area},
        "case_id":{"stringValue": caseID},
        "customer_name":{"stringValue": customerName},
        "egg_name":{"stringValue": eggName},
        "end_date":{"timestampValue": endDateString+"Z"},
        "mobile_number":{"stringValue": customerMobileNumber},
        "remark":{"stringValue": remark},
        "start_date":{"timestampValue": startDateString+"Z"},
        "unit":{"stringValue": unit},
        "w_s":{"stringValue": ws},
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

    final String pathOfDataDocumentOrCollection = "kentOwner@gmail.com/UserDetails/customers";
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



  Future? callApiForBulkAddition() async {


    String? mailId = "kentOwner@gmail.com";
    print("mailId");
    print(mailId);
    if(mailId==null){
      return false;
    }
    //print("Adding"+contact.displayName!);


    // String endDateString = formatter.format(endDate);
    //String startDateString = formatter.format(startDate);


    var headers = {
      'Content-Type': 'application/json'
      //If U Use Authentication For Secure Access
      //Only Signed User Can Access if
      //'Authorization': "Bearer %s" % id_token
    };



    var request = http.Request('POST', Uri.parse('https://firestore.googleapis.com/v1beta1/projects/customerlistingapp/databases/(default)/documents/$mailId?documentId=UserDetails'));


    var formatter = new DateFormat('yyyy-MM-ddTHH:mm:ss');
    final dateRegEx = RegExp(r'^\d\d/\d\d/\d\d\d\d$');
    dateRegEx.hasMatch('abc123');
    String startDate="";
    String endDate="";

    myList.forEach((element) async {

      if(element["end_date"]==null||element["end_date"]==""){
        element["end_date"]=DateFormat('MM/dd/yyyy').parse(DateTime.now().toString());
      }

      if(dateRegEx.hasMatch(element["start_date"])){
        startDate = formatter.format(DateFormat('MM/dd/yyyy').parse(element["start_date"]));
      }

      if(element.containsKey("end_date")){
        if(dateRegEx.hasMatch(element["end_date"])){
          endDate = formatter.format(DateFormat('MM/dd/yyyy').parse(element["end_date"]));
        }
        else{
          endDate = formatter.format(DateTime.now().add(Duration(days: 90)));
        }
      }
      else{
        endDate = formatter.format(DateTime.now().add(Duration(days: 90)));
      }

      ApiRepository().AddBulkApi(element["address"], element["area"], element["case_id"], element["egg_name"], endDate, startDate, element["customer_name"].toString(), element["remark"], element["unit"], element["w_s"], element["mobile_number"].toString());

    });
  }

  Future<bool> AddBulkApi(
      String address,
      String area,
      String caseID,
      String eggName,
      String endDate,
      String startDate,
      String customerName,
      String remark,
      String unit,
      String ws,
      String customerMobileNumber,
      ) async {

    final prefs = await SharedPreferences.getInstance();
    String? mailId = "kentOwner@gmail.com";
    print("mailId");
    print(mailId);
    if(mailId==null){
      return false;
    }
    //print("Adding"+contact.displayName!);



    var headers = {
      'Content-Type': 'application/json'
      //If U Use Authentication For Secure Access
      //Only Signed User Can Access if
      //'Authorization': "Bearer %s" % id_token
    };



    var request = http.Request('POST', Uri.parse('https://firestore.googleapis.com/v1beta1/projects/customerlistingapp/databases/(default)/documents/$mailId/UserDetails/customers'));
    request.body = json.encode({
      //"documentId": {"stringValue": "Maaki"},
      "fields": {
        "mail_id": {"stringValue": mailId},
        "address":{"stringValue": address},
        "area":{"stringValue": area},
        "case_id":{"stringValue": caseID},
        "customer_name":{"stringValue": customerName},
        "egg_name":{"stringValue": eggName},
        "end_date":{"timestampValue": endDate+"Z"},
        "mobile_number":{"stringValue": customerMobileNumber},
        "remark":{"stringValue": remark},
        "start_date":{"timestampValue": startDate+"Z"},
        "unit":{"stringValue": unit},
        "w_s":{"stringValue": ws},
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



}