import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_provider.dart';

class RegistroFotograficoPage extends ConsumerStatefulWidget {
  final num evidenciaId;
  const RegistroFotograficoPage({super.key, required this.evidenciaId});

  @override
  ConsumerState<RegistroFotograficoPage> createState() =>
      _RegistroFotograficoPageState();
}

class _RegistroFotograficoPageState
    extends ConsumerState<RegistroFotograficoPage> {
  XFile? imagem;
  Foto? foto;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final novaVistoriaState = ref.read(novaVistoriaProvider).value;
      if (novaVistoriaState?.fotos?.isNotEmpty == true) {
        foto = novaVistoriaState!.fotos!.firstWhere(
          (f) => f.evidencia.id == widget.evidenciaId,
        );
      }
    });
    super.initState();
  }

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

  void _onSubmit() {
    if (imagem != null && foto != null) {
      ref.read(novaVistoriaProvider.notifier).atualizar((novaVistoria) {
        final fotos = novaVistoria.fotos!;
        fotos.removeWhere((x) => x.evidencia.id == widget.evidenciaId);
        fotos.add(
          Foto(
            extensao: path.extension(imagem!.name),
            evidencia: foto!.evidencia,
            file: imagem,
          ),
        );
        return novaVistoria.copyWith(fotos: fotos);
      });
      final novaVistoriaState = ref.read(novaVistoriaProvider).value!;
      if (novaVistoriaState.fotos!.any((x) => x.extensao.isEmpty)) {
        final fotoPendente = novaVistoriaState.fotos!.firstWhere(
          (x) => x.extensao.isEmpty,
        );
        context.push(
          AppRoutes.registroFotografico,
          extra: fotoPendente.evidencia.id,
        );
      } else {
        context.go(AppRoutes.conclusaoVistoria);
      }
    }
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: alturaSafe * 0.9,
          width: .infinity,
          child: Column(
            spacing: 100,
            children: [
              SizedBox(height: alturaSafe * 0.02),
              Text(
                foto?.evidencia.nome ?? "",
                textAlign: .center,
                style: TextStyle(
                  fontWeight: .bold,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Form(
                child: Column(
                  spacing: 30,
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
                          borderRadius: .circular(10),
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
                            : Column(
                                mainAxisAlignment: .center,
                                crossAxisAlignment: .center,
                                spacing: 5,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  Text(
                                    "Adicionar Foto",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: .infinity,
                      decoration: BoxDecoration(
                        color: imagem != null
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: imagem != null ? _onSubmit : null,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          shadowColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          fixedSize: WidgetStatePropertyAll(
                            Size.fromHeight(50),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: .center,
                          mainAxisAlignment: .center,
                          spacing: 5,
                          children: [
                            Text(
                              "Continuar Inspeção",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: .bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
