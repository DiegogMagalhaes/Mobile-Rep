import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login.dart';
import 'package:firebase_project/meus_anuncios.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itensMenu = [];

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    if( usuarioLogado == null ){
      itensMenu = [
        "Entrar / Cadastrar"
      ];
    }else{
      itensMenu = [
        "Meus anúncios", "Deslogar"
      ];
    }
  }

  _deslogarUsuario() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MeusAnuncios()));
        break;
      case "Entrar / Cadastrar":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Anuncios Online",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  //Map
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
