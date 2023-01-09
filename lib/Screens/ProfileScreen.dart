import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {

  final Map profileData;

  const ProfileScreen({Key? key, required this.profileData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    DateFormat inputFormatter = DateFormat("yyyy-MM-ddTHH:mm:ss");
    print("widget.profileData");
    print(widget.profileData);

    String startDate = DateFormat('dd/MM/yyyy').format((inputFormatter.parse(widget.profileData["start_date"]["timestampValue"].toString().replaceAll("Z", ""))));
    String endDate = DateFormat('dd/MM/yyyy').format((inputFormatter.parse(widget.profileData["end_date"]["timestampValue"].toString().replaceAll("Z", ""))));

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              title: Text(
                'Customer Details',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              centerTitle: false,
              elevation: 2,
            ),
            Container(

                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Icon(Icons.calendar_month,color: Theme.of(context).primaryColor,size: 30,),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Date",style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),),
                        Text(startDate,style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                        ),)
                      ],
                    ),
                    SizedBox(width: 10,),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20),
                      child: VerticalDivider(color:Theme.of(context).primaryColor ,thickness: 2,),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.calendar_month,color: Theme.of(context).primaryColor,size: 30,),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("End Date",style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),),
                        Text(endDate,style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                        ),)
                      ],
                    )
                  ],
                ),
                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                height: height*0.1,
                decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20),))

            ),
            Divider(color:Theme.of(context).primaryColor ,thickness: 2,),
            Expanded(

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    SizedBox(height: height*0.02,),
                    Text("Case Id",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["case_id"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Customer Name",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["customer_name"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Address",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["address"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Area",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["area"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("EGG Name",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["egg_name"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Mobile Number",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["mobile_number"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Remark",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["remark"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("Unit",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["unit"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),

                    SizedBox(height: height*0.02,),
                    Text("WS",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),),
                    Text(widget.profileData["w_s"]["stringValue"],style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                    ),),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
