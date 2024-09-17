import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({super.key});

  @override
  State<NovoAnuncio> createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = [];

  List<DropdownMenuItem<String>> _listaDropDownEstados = [];
  List<DropdownMenuItem<String>> _listaDropDownCategoria = [];

  late String _itemSelecionadoEstado = "MG";
  late String _itemSelecionadoCategoria = "automoveis";

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
  }

  _carregarItensDropdown() {
    for (var estado in Estados.listaEstadosSigla) {
      _listaDropDownEstados
          .add(DropdownMenuItem(child: Text(estado), value: estado));
    }

    _listaDropDownCategoria
        .add(DropdownMenuItem(child: Text("Automóveis"), value: "automoveis"));
    _listaDropDownCategoria
        .add(DropdownMenuItem(child: Text("Móveis"), value: "moveis"));
    _listaDropDownCategoria
        .add(DropdownMenuItem(child: Text("Moda"), value: "moda"));
    _listaDropDownCategoria
        .add(DropdownMenuItem(child: Text("Esportes"), value: "esportes"));
  }

  _selectionarImagemGaleria() async {
    XFile? imagemSelecionada =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(File(imagemSelecionada!.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens!.length == 0) {
                      return "Necessário selecionar uma imagens";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _listaImagens.length + 1,
                              itemBuilder: (contex, indice) {
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectionarImagemGaleria();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo,
                                              size: 40,
                                              color: Colors.grey[100],
                                            ),
                                            Text(
                                              "Adicionar",
                                              style: TextStyle(
                                                  color: Colors.grey[100]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (_listaImagens.length > 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (contex) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.file(_listaImagens[
                                                          indice]),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _listaImagens
                                                                  .removeAt(
                                                                      indice);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child: Text("Excluir",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red)))
                                                    ],
                                                  ),
                                                ));
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(
                                            _listaImagens[indice] as File),
                                        child: Container(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.4),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(8),
                              child: DropdownButtonFormField(
                                  value: _itemSelecionadoEstado,
                                  hint: Text("Estados"),
                                  items: _listaDropDownEstados,
                                  onChanged: (valor) {
                                    setState(() {
                                      _itemSelecionadoEstado = valor.toString();
                                    });
                                  }),
                            )),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(8),
                              child: DropdownButtonFormField(
                                  value: _itemSelecionadoCategoria,
                                  hint: Text("Estados"),
                                  items: _listaDropDownCategoria,
                                  onChanged: (valor) {
                                    setState(() {
                                      _itemSelecionadoCategoria =
                                          valor.toString();
                                    });
                                  }),
                            ))
                          ],
                        ),
                        ElevatedButton(
                          child: const Text(
                            "Adicionar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.orange),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                      ],
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
