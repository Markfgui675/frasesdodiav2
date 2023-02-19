import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frasesdodia/telaFrases.dart';
import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _novaFrase = TextEditingController();

  List _frases = [];

  var _fraseGerada = 'Clique no botão para gerar uma frase';
  void _gerarFrase(){
    int tamanhoLista = _frases.length;
    if (tamanhoLista == 0){
      _fraseGerada = 'Não há nenhuma frase';
    }
    var randomNumber = Random().nextInt(_frases.length);
    _fraseGerada = _frases[randomNumber];
    setState(() {
      _fraseGerada = _fraseGerada;
    });
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    print(diretorio.path.toString());
    return File('${diretorio.path}/frases.json');
  }

  _salvarTarefa() async {
    String novaFraseDigitada = _novaFrase.text;

    setState(() {
      _frases.add(novaFraseDigitada);
    });
    salvarArquivo();

    _novaFrase.text = '';
  }

  salvarArquivo() async {
    var arquivo = await _getFile();
    print(arquivo.toString());

    String frases = json.encode(_frases);
    arquivo.writeAsString(frases);
  }

  _lerArquivo() async {
    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch(e){
      return null;
    }
  }

  @override
  void initState() {
    _lerArquivo().then((frases){
      setState(() {
        frases = json.decode(frases);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    print('itens: '+_frases.toString());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Frases do Dia'),
        backgroundColor: Colors.red,
      ),




      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(_fraseGerada, style: TextStyle( fontSize: 25),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: _gerarFrase,
                        child: Text('Gerar Frase'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),





      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showDialog(context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('Adicionar Frase'),
                    content: TextField(
                      decoration: InputDecoration(labelText: 'Nova Frase'),
                      controller: _novaFrase,
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: (){
                            _salvarTarefa();
                            print(_frases.toString());
                            Navigator.pop(context);
                          },
                          child: Text('Adicionar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                          ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                        ),
                      ),
                    ],
                  );
                }
            );
          },
          label: Text('Adicionar Frase'),
          icon: Icon(Icons.add),
          elevation: 10,
          backgroundColor: Colors.red,
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaFrases(_frases)));
            },
                icon: Icon(Icons.menu, color: Colors.black,))
          ],
        )
      ),
    );
  }
}
