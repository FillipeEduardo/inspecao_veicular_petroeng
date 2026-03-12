import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspecao_veicular_petroeng/models/foto.dart';

class RegistroFotograficoPage extends StatefulWidget {
  final Foto foto;
  const RegistroFotograficoPage({super.key, required this.foto});

  @override
  State<RegistroFotograficoPage> createState() =>
      _RegistroFotograficoPageState();
}

class _RegistroFotograficoPageState extends State<RegistroFotograficoPage> {
  XFile? imagem;

  Future<void> _tirarFoto() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: .camera,
      preferredCameraDevice: .rear,
      imageQuality: 100,
    );
    setState(() {
      imagem = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Registro Fotográfico",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: alturaSafe * 0.9,
            width: .infinity,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              spacing: 100,
              children: [
                Text(
                  widget.foto.evidencia.nome,
                  textAlign: .center,
                  style: TextStyle(
                    fontWeight: .bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _tirarFoto,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: imagem != null
                              ? ClipRRect(
                                  child: Image.file(
                                    File(imagem!.path),
                                    fit: .cover,
                                    width: .infinity,
                                    height: .infinity,
                                  ),
                                )
                              : Text("Anexe uma foto"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
