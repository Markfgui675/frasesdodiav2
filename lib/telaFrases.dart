import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class TelaFrases extends StatefulWidget {

  List? frases;

  TelaFrases(this.frases);

  @override
  State<TelaFrases> createState() => _TelaFrasesState();
}

class _TelaFrasesState extends State<TelaFrases> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de Frases'),
        backgroundColor: Colors.red,
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(child:
                ListView.builder(
                  itemCount: widget.frases?.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(widget.frases![index]),
                      );
                    },
                )
            )
          ],
        ),
      ),
    );
  }
}

