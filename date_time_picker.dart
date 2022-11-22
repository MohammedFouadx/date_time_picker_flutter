


import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
   DateTimePicker({Key? key}) : super(key: key);

   DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Time Picker"),
        centerTitle: true,
        backgroundColor: Colors.purple[700],

      ),
      body: StatefulBuilder(
        builder: (context , mySetState){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                  "Pick time and date",
                  style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700]
                  ),
              ),
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async{
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        // locale: Locale("ar"),
                        initialDate: _dateTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100)
                    );
                    if(_dateTime == null) return;

                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      builder: (context , child){
                        return MediaQuery(
                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false ),
                            child: child!
                        );
                      },
                      initialTime: TimeOfDay(
                        hour: _dateTime.hour,
                        minute: _dateTime.minute
                      )
                    );
                    if(newTime == null) return;

                    final newDateTime = DateTime(
                      newDate!.year,
                      newDate.month,
                      newDate.day,
                      newTime.hour,
                      newTime.minute
                    );

                    mySetState((){
                      _dateTime = newDateTime;
                    });


                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    child: Text(
                      _dateTime!= null
                          ?"${_dateTime.day}/${_dateTime.month}/${_dateTime.year} - ${_dateTime.hour}:${_dateTime.minute}"
                          :"Select time and date",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
