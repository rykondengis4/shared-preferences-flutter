import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form.dart';
import 'dart:convert';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // List<String> nama = ["Rykondengis", "Raflin Dehi", "Indri rais"];
  // List<String> nim = ["21501038", "21501039", "21501033"];

  var data = [];

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      data = json.decode(
        sp.getString("mahasiswa") ?? '[]',
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text("HOME"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyForm(
                      index: null,
                      value: null,
                    ),
                  ),
                ).then((value) => getData());
              },
              icon: Icon(Icons.add_outlined)),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${i + 1}'),
            ),
            title: Text('${data[i]['nama']}'),
            subtitle: Text('${data[i]['nim']}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyForm(
                            index: i,
                            value: data[i],
                          ))).then((value) => getData());
            },
          );
        },
      ),
    );
  }
}
