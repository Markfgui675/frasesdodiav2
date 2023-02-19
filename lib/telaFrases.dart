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

  Widget listaFrases(context, index){

    final item = DateTime.now().microsecondsSinceEpoch.toString();

    return Dismissible(key: Key(item),

        onDismissed: (direction){

          final snackbar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Frase removida'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);


          if(direction == DismissDirection.startToEnd){
            //pegar frase já escrita

            //salvar alteração
          } else if(direction == DismissDirection.endToStart){
            //exluir
            widget.frases!.removeAt(index);
          }

        },
        
        background: Container(
          color: Colors.green,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.edit, color: Colors.white),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.delete, color: Colors.white)
            ],
          ),
        ),

        child: ListTile(
          title: Text(widget.frases![index]),
        )
    );

  }

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
                    itemBuilder: listaFrases,
                )
            )
          ],
        ),
      ),
    );
  }
}

