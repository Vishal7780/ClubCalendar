import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:club_calendar/features/admin/events/view/widgets/image_input.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';
import '../../../../styles.dart';




class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);
  static const routeName = "addEvent";
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  TextEditingController sampledata1= TextEditingController();
  TextEditingController sampledata2=TextEditingController();
  TextEditingController sampledata3=TextEditingController();
  TextEditingController sampledata4=TextEditingController();
  TextEditingController sampledata5=TextEditingController();
  TextEditingController sampledata6=TextEditingController();
  TextEditingController sampledata7=TextEditingController();
  TextEditingController sampledata8=TextEditingController();
  TextEditingController sampledata9=TextEditingController();
  TextEditingController sampledata10=TextEditingController();
  TextEditingController sampledata11=TextEditingController();
  TextEditingController sampledata12=TextEditingController();




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
              if (kDebugMode) {
                print("clicked");
              }
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
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ImageInput(onSelectImage: _selectImage),
              SizedBox(height: 10,),
              TextFormField(
                controller: sampledata1,
                decoration: InputDecoration(
                    labelText: 'Event ID',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      Icons.event_rounded,
                      size: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),

              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata2,
                decoration: InputDecoration(labelText:'Event Name',
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.event_note,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,

                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    ),

                ),
              ),


              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata3,
                decoration: InputDecoration(label:const Text("Event Location"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.location_on_sharp,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata4,
                decoration: InputDecoration(
                    labelText:'Event Description',
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.description,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),




              //TODO : MAKE THIS A DROPDOWN MAYBE
              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata5,
                decoration: InputDecoration(
                    labelText:'Event Duration',
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.av_timer_outlined,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),

              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata6,
                decoration: InputDecoration(
                    label:const Text("Event Resources"),
                    labelStyle:const TextStyle(
                    fontSize:14,
                    fontWeight:FontWeight.w400
                ),
                  prefixIcon:const Icon( Icons.contacts,size: 18,),
                  enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  floatingLabelStyle:const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata7,
                decoration: InputDecoration(
                    label:const Text("Speakers"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.speaker,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )

                ),
              ),

              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata8,
                decoration: InputDecoration(label: const Text("Prizes"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.military_tech_outlined,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),




              const SizedBox(height: 15,),
              TextFormField(
                controller: sampledata9,
                decoration: InputDecoration(label:const Text("Total Prize Money"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon: const Icon( Icons.attach_money,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),






              const SizedBox(height: 15,),
              DateTimeField(
                controller: sampledata12,
                decoration: InputDecoration(label:const Text("Start Date and Time"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.date_range,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
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




              const SizedBox(height: 15,),
              DateTimeField(
                controller: sampledata11,
                decoration: InputDecoration(label: const Text("End Date and Time"),
                    labelStyle:const TextStyle(
                        fontSize:14,
                        fontWeight:FontWeight.w400
                    ),
                    prefixIcon:const Icon( Icons.date_range,size: 18,),
                    enabledBorder:OutlineInputBorder(
                      borderSide:BorderSide(color:Colors.grey.shade200,width:2,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    floatingLabelStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.5,),
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

              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Styles.buttonColor)),

                onPressed: (){
                  // print(sampledata11.text);
                  // print(sampledata12.text);
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImages=referenceRoot.child('');
                  Reference referenceImageToUpload=referenceDirImages.child('${sampledata1.text}.jpg');
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
                    "eventStartDate":Timestamp.fromDate(DateTime.parse(sampledata11.text)),
                    "eventEndDate":Timestamp.fromDate(DateTime.parse(sampledata12.text)),
                  };
                 FirebaseFirestore.instance.collection("events").doc(sampledata1.text).set(data);
                },
                child:const Text('Post event',style: TextStyle(color:Colors.white,fontSize: 16 ),
                ),


              )


            ]),
          ),
        ),
      ),
    );
  }
}
