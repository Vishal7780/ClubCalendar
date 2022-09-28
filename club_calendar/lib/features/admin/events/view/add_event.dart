import 'dart:io';

import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:club_calendar/features/admin/events/view/widgets/image_input.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import '../../../../styles.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);
  static const routeName = "addEvent";
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
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
                decoration: InputDecoration(label: Text("Event ID")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Event Name")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Event Location")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Event Description")),
              ),
              //TODO : MAKE THIS A DROPDOWN MAYBE
              TextFormField(
                decoration: InputDecoration(label: Text("Event Duration")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Event Resources")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Speakers")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Prizes")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Total Prize Money")),
              ),
              DateTimeField(
                decoration: InputDecoration(label: Text("Start Date and Time")),
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
                            DateTimeField(
                decoration: InputDecoration(label: Text("End Date and Time")),
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
              ImageInput(onSelectImage: _selectImage )
            ]),
          ),
        ),
      ),
    );
  }
}
