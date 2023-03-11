import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/launch.dart';
import '../services/apicall.dart';


class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}
List<Launch> finals=[];
List<bool> addedToStore=[];
bool showResult=false;
class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showResult==false?
        ElevatedButton(
          onPressed: () async
          {
            finals= await API.getAll();
            log(finals.toString());
            for(int i=0;i<finals.length;i++)
              {
               addedToStore.add(false);
              }
            setState(() {
              showResult=!showResult;
            });
          },
          child: Text('Click Here'),
        ):
        ListView.separated(
            itemBuilder: (BuildContext context, int index)
            {
              return ListTile(
                title: Text(finals[index].missionName!),
                subtitle: Text(finals[index].launchYear!),
                leading: Text(finals[index].rocketName!),
                trailing: addedToStore[index]==true?
                Icon(Icons.save):
                ElevatedButton(

                    onPressed:()
                    {
                       addedToStore[index]=!addedToStore[index];
                       CollectionReference collectionRef=
                       FirebaseFirestore.instance.collection('watchLater');

                       final data = {
                         "launchTime": finals[index].launchTime!,
                         "launchYear": finals[index].launchYear!,
                          "rocketName":finals[index].rocketName!,
                         "missionName":finals[index].missionName!,
                       };
                      collectionRef.add(data).then((documentSnapshot) =>
                           log("Added Data with ID: ${documentSnapshot.id}"));
                       setState(() {

                       });
                    },
                    child: Text('Watch Later')

                )
                ,

              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: finals.length
        )
      ),
    );
  }
}
