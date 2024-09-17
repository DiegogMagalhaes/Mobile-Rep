import 'dart:math';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> frases = [
    "Acredite em si mesmo e você será imparável",
    "A persistência leva ao sucesso",
    "A jornada mais longa começa com um único passo",
    "Encare cada desafio como uma chance de crescimento",
    "Mude seus pensamentos e você mudará seu mundo",
  ];

  int _counter = 0;

  _gerarAleatorio(){
    setState(() {
      _counter = _counter+1 <5 ? _counter+1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frases do dia', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,32,8,16),
              child: Text(
                frases[_counter],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              _gerarAleatorio();
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text("Clique aqui", style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}