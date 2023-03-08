import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:club_calendar/features/admin/events/view/widgets/image_input.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../styles.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);
  static const routeName = "addEvent";
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  TextEditingController sampledata1=new TextEditingController();
  TextEditingController sampledata2=new TextEditingController();
  TextEditingController sampledata3=new TextEditingController();
  TextEditingController sampledata4=new TextEditingController();
  TextEditingController sampledata5=new TextEditingController();
  TextEditingController sampledata6=new TextEditingController();
  TextEditingController sampledata7=new TextEditingController();
  TextEditingController sampledata8=new TextEditingController();
  TextEditingController sampledata9=new TextEditingController();


  Styles styles = Styles();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              print("clicked");
              _scaffoldKey.currentState!.openDrawer();
            }),
        backgroundColor: Styles.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Add event",
          style: styles.headingStyle(),
        ),
      ),
      drawer: adminDrawer(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                controller: sampledata1,
                decoration: InputDecoration(
                    labelText:'Event ID',
                    labelStyle:TextStyle(
                      fontSize:14,
                      fontWeight:FontWeight.w400
                    ),
                  prefixIcon: Icon( Icons.event_rounded,size: 18,),
                  enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),



              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata2,
                decoration: InputDecoration(labelText:'Event Name',
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.event_note,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    ),

                ),
              ),


              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata3,
                decoration: InputDecoration(label: Text("Event Location"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.location_on_sharp,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),



              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata4,
                decoration: InputDecoration(
                    labelText:'Event Description',
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.description,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),




              //TODO : MAKE THIS A DROPDOWN MAYBE
              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata5,
                decoration: InputDecoration(
                    labelText:'Event Duration',
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.av_timer_outlined,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),



              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata6,
                decoration: InputDecoration(
                    label: Text("Event Resources"),
                    labelStyle:TextStyle(
                    fontSize:14,
                    fontWeight:FontWeight.w400
                ),
                  prefixIcon: Icon( Icons.contacts,size: 18,),
                  enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),





              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata7,
                decoration: InputDecoration(
                    label: Text("Speakers"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.speaker,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )

                ),
              ),




              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata8,
                decoration: InputDecoration(label: Text("Prizes"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.military_tech_outlined,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),






              SizedBox(height: 15,),
              TextFormField(
                controller: sampledata9,
                decoration: InputDecoration(label: Text("Total Prize Money"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.attach_money,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),






              SizedBox(height: 15,),
              DateTimeField(

                decoration: InputDecoration(label: Text("Start Date and Time"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.date_range,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )),
                format: DateFormat("yyyy-MM-dd HH:mm"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),




                            SizedBox(height: 15,),
              DateTimeField(

                decoration: InputDecoration(label: Text("End Date and Time"),
                    labelStyle:TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: Icon( Icons.date_range,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )

                ),
                format: DateFormat("yyyy-MM-dd HH:mm"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              ImageInput(onSelectImage: _selectImage ),
              RawMaterialButton(

                fillColor: Color(0x2196F3FF),

                onPressed: (){
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImages=referenceRoot.child('./');
                  Reference referenceImageToUpload=referenceDirImages.child("EventId");
                  referenceImageToUpload.putFile(File(_pickedImage!.path));
                  Map<String,dynamic>data={"eventId":sampledata1.text,
                    "eventName":sampledata2.text,
                    "eventLocation":sampledata3.text,
                    "eventDescription":sampledata4.text,
                    "eventDuration":sampledata5.text,
                    "eventRecordings":sampledata6.text,
                    "eventSpeakers":sampledata7.text,
                    "eventPrizes":sampledata8.text,
                    "eventPrizeMoney":sampledata9.text,
                    "eventStartDate":Timestamp.now(),
                    "eventEndDate":Timestamp.now(),




                  };
                 FirebaseFirestore.instance.collection("events").add(data);
                },
                child: Text('Post event',style: TextStyle(color:Colors.white,fontSize: 16 ),
                ),

                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              )


            ]),
          ),
        ),
      ),
    );
  }
}
