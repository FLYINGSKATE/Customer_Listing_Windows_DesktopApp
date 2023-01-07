
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:customer_listing_desktop_app/NetworkServices/FirebaseApiRepository.dart';
import 'package:customer_listing_desktop_app/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List?> myCustomerSnapshotFuture;

  List<Map>? seacrhSpecificCustomers;
  List<Map>? originalData;

  TextEditingController searchTextEditingController = TextEditingController();
  Size preferredSizeForThisWindow = Size(1080, 720);

  @override
  void initState() {
    // TODO: implement initState
    appWindow.minSize = preferredSizeForThisWindow;
    appWindow.size = preferredSizeForThisWindow;
    myCustomerSnapshotFuture = getCustomersList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FloatingActionButton pressed ...');
          Navigator.pushNamed(context,'AddCustomerScreen');
        },
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 8,
        label: Text("Add Customer",style: TextStyle(color: Theme.of(context).primaryColor),),
        icon: Icon(
          Icons.person_add_alt_1_rounded,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
      ),


      body: Column(
        children: [
          WindowTitleBarBox(
            child: Container(
              color:Theme.of(context).primaryColor,
              child: Row(
                children: [Expanded(child: MoveWindow()), const WindowButtons()],
              ),
            ),
          ),
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            actions: [

              FutureBuilder(
                builder: (ctx, snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data as List?;

                      int count = 0;
                      //"end_date", isLessThanOrEqualTo: new DateTime.now()
                      data?.forEach((element) {

                        print("Element Dekho");
                        print(element);
                        print(element["fields"]["end_date"]);
                        print(element["fields"]["end_date"]["timestampValue"].runtimeType);

                        DateFormat inputFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:SS'Z'");

                        //DateTime date = inputFormatter.parse("2018-04-10T04:00:00.000Z");
                        DateTime date = inputFormatter.parse(element["fields"]["end_date"]["timestampValue"]);

                        print("date dekh bc");
                        print(date);


                        if(DateTime.now().isBefore(inputFormatter.parse(element["fields"]["end_date"]["timestampValue"])) || DateTime.now().isAtSameMomentAs(inputFormatter.parse(element["fields"]["end_date"]["timestampValue"]))){
                          count++;
                        }
                      });

                      return (count==0)?InkWell(
                        onTap: () {
                          print('IconButton pressed ...');
                          Navigator.pushNamed(context, 'NotificationScreen');
                        },
                        child: Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.notifications_paused,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                                Navigator.pushNamed(context, 'NotificationScreen');
                              },
                            ),
                            Padding(padding:EdgeInsets.only(top: 5,left: 5) ,child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Center(child: Text(count.toString(),style: TextStyle(fontSize: 12),),),
                            ),)

                          ],
                        ),
                      ):IconButton(
                        icon: Icon(
                          Icons.notifications_paused,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                          Navigator.pushNamed(context, 'NotificationScreen');
                        },
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return IconButton(
                    icon: Icon(
                      Icons.notifications_paused,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                      Navigator.pushNamed(context, 'NotificationScreen');
                    },
                  );
                },

                // Future that needs to be resolved
                // inorder to display something on the Canvas
                future: myCustomerSnapshotFuture,
              ),


            ],
            centerTitle: false,
            elevation: 2,
          ),
          SearchButton(),
          //NewlyAddedCustomer(),
          ListOfCustomer(),
        ],
      ),
    );
  }

  SearchButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              autofocus: true,
              controller: searchTextEditingController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Search Customers',
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).dialogBackgroundColor,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: null,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).cardColor,
                size: 24,
              ),
              onPressed: () {

                seacrhSpecificCustomers = List.from(originalData!);
                if(searchTextEditingController.text.length>0){
                  seacrhSpecificCustomers?.removeWhere( (element) => !(element["fields"]["customer_name"]["stringValue"].toString().contains(searchTextEditingController.text)));
                  print(seacrhSpecificCustomers?.toList());
                }

                setState(() {});
                print('IconButton pressed ...');
              },
            ),
          ),
        ],
      ),
    );
  }

  ListOfCustomer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text(
            'Customers',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff101213)
            ),
          ),
        ),

        //Future Builder
        FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              print("Connection established");
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data as List?;



                if(searchTextEditingController.text.length<1){
                  seacrhSpecificCustomers = List.from(data!);
                }
                originalData = List.from(data!);

                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: seacrhSpecificCustomers!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomerTileWidget(seacrhSpecificCustomers![index]["fields"]["customer_name"]["stringValue"],seacrhSpecificCustomers![index]["fields"]["case_id"]["stringValue"],seacrhSpecificCustomers![index]["fields"]["address"]["stringValue"],seacrhSpecificCustomers![index]["fields"]);
                      },
                    ),
                  ),
                );
              }
            }
            print("Connection Notestablished");
            // Displaying LoadingSpinner to indicate waiting state
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                SizedBox(
                  width: 90.0,
                  height: 90.0,
                  child:CircularProgressIndicator(
                      strokeWidth: 10.0,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 20,),
                Text("Please Wait",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    )
                ),
              ],));
          },

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future:myCustomerSnapshotFuture,
        ),


      ],
    );
  }

  NewlyAddedCustomer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text(
            'Newly Added Customer',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff101213)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 20),
          child: Container(
            height: MediaQuery.of(context).size.height*0.2,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 56,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (c,i){
                return SizedBox(width: 6,);
              },
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
                  child: Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x34090F13),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'UserName',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Remove',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  CustomerTileWidget(String customerName,String caseID,String address,Map profileData) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(profileData: profileData)),
          );
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x32000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            caseID,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).backgroundColor),
                          ),),
                        Expanded(
                          flex: 1,
                          child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: VerticalDivider(color: Theme.of(context).backgroundColor,thickness: 1,)),),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customerName,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).backgroundColor,fontSize: 18,fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  address,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).backgroundColor,fontSize: 12),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List?> getCustomersList() async {
    return await ApiRepository().FetchListOfCustomers();
  }



}
