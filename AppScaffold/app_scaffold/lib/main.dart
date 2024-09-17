import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App IFNMG'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 100,
              child: const DrawerHeader(

                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                ),
                child: Text(
                    'Drawer Header'),
              ),
            ),
            ListTile(
              title: const Text('Conta'),
              leading: const Icon(Icons.person),
              onTap:
                  () {},
            ),
            ListTile(
              title: const Text('Configurações'),
              leading: const Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Sair'),
              leading: const Icon(Icons.close),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Meu primeiro App:'),
            Text(
              "Ola mundo",
              style: TextStyle(
                fontSize: 25,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.access_time),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:
        BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Conta"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Pedidos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Configuração"),
        ],
      ),
    );
  }
}
