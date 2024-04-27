import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyForm extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? value;

  const MyForm({
    required this.index,
    required this.value,
    super.key,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  late int? index = widget.index;
  late Map<String, dynamic>? value = widget.value;

  var tfNama = TextEditingController();
  var tfNim = TextEditingController();

  Widget hapusData() {
    if (index != null && value != null) {
      return IconButton(
        onPressed: () {
          hapus();
        },
        icon: Icon(Icons.delete_forever),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  void simpanData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString("nama", tfNama.text);
    // sp.setString("nim", tfNim.text);

    var mahasiswa = json.decode(sp.getString("mahasiswa") ?? '[]');

    var data = {
      "nama": tfNama.text,
      "nim": tfNim.text,
    };

    if (index == null) {
      mahasiswa.add(data);
    } else {
      mahasiswa[index] = data;
    }

    sp.setString("mahasiswa", json.encode(mahasiswa));

    Navigator.pop(context);
  }

  void getData() {
    if (index != null && value != null) {
      tfNama.text = value!["nama"];
      tfNim.text = value!["nim"];
    }
  }

  void hapus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var data = json.decode(
      sp.getString("mahasiswa") ?? '[]',
    );
    data.removeAt(index);

    sp.setString("mahasiswa", json.encode(data));

    Navigator.pop(context);
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
        title: Text("FORM"),
        actions: [
          hapusData(),
          IconButton(
              onPressed: () {
                simpanData();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "nama",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Container(
                width: 200,
                height: 50,
                child: TextField(controller: tfNama),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "nim",
                style: TextStyle(fontSize: 17),
              ),
              Container(
                width: 200,
                height: 50,
                child: TextField(controller: tfNim),
              )
            ],
          ),
        ],
      ),
    );
  }
}
