import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Formulario(),
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  String _resultado = "";

  void _calcula(){
    double? precoAlcool = double.tryParse(_alcoolController.text);
    double? precoGasolina = double.tryParse(_gasolinaController.text);

    if (precoAlcool == null || precoGasolina == null) {
      setState(() {
        _resultado = 'Preencha os valores corretamente';
      });
    } else {
      double proporcao = precoAlcool / precoGasolina;

      if (proporcao <= 0.7) {
        setState(() {
          _resultado = 'Abasteça com Álcool';
        });
      } else {
        setState(() {
          _resultado = 'Abasteça com Gasolina';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alcool Ou Gasolina", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16,bottom: 64),
                child: Image.asset("assets/images/logo.png"),
              ),
              const Text("Saiba qual a melhor opção para abastecimento do seu carro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              TextField(
                controller: _alcoolController,
                decoration: const InputDecoration(labelText: 'Preço do Álcool'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _gasolinaController,
                decoration: const InputDecoration(labelText: 'Preço da Gasolina'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                  onPressed: (){
                      _calcula();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Calcular")),
              Text(_resultado)
            ]),
      ),
    );
  }
}
