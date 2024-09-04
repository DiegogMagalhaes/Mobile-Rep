import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _cadastrar = false;
  String _textoBotao = "Logar";

  @override
  Widget build(BuildContext context) {
    _showMsg(String msg) {
      final snack = SnackBar(
        backgroundColor: Colors.black,
        content: Text(msg),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

    _cadastrarUsuario() {
      FirebaseAuth auth = FirebaseAuth.instance;

      String email = _emailController.text;
      String senha = _senhaController.text;

      auth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((firebaseUser) {
        _showMsg("Usuario criado com sucesso");
      }).catchError((onError) {
        _showMsg(onError.toString());
      });
    }

    _logarUsuario() {
      FirebaseAuth auth = FirebaseAuth.instance;

      String email = _emailController.text;
      String senha = _senhaController.text;

      auth
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((firebaseUser) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }).catchError((error) {
        _showMsg(error.toString());
      });
    }

    _validar() {
      if (_senhaController.text.length >= 6 &&
          _emailController.text != "" &&
          _emailController.text.contains("@")) {
        if (_cadastrar == true) {
          _cadastrarUsuario();
        } else {
          _logarUsuario();
        }
      } else {
        _showMsg("Dados invalidos");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Image.asset('assets/images/logo.png'),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  controller: _emailController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    controller: _senhaController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Logar"),
                      Switch(
                          value: _cadastrar,
                          onChanged: (bool valor) {
                            setState(() {
                              _cadastrar = valor;
                              if (_cadastrar == true) {
                                _textoBotao = "Cadatrar";
                              } else {
                                _textoBotao = "Logar";
                              }
                            });
                          }),
                      Text("Cadastrar"),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      _textoBotao,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    _validar();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
