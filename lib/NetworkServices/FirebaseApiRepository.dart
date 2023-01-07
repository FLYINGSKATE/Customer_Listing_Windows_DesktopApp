import 'package:http/http.dart' as http;

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

  AddUser(String text, String text2) {}

  
}