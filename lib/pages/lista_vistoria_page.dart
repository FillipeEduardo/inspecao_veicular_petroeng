import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/models/vistoria.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_vistoria/lista_vistoria_provider.dart';
import 'package:intl/intl.dart';

class ListaVistoriaPage extends ConsumerStatefulWidget {
  const ListaVistoriaPage({super.key});

  @override
  ConsumerState<ListaVistoriaPage> createState() => _ListaVistoriaPageState();
}

class _ListaVistoriaPageState extends ConsumerState<ListaVistoriaPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listaVistoriaProvider.notifier).loadVistorias(statusId: 1);
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(listaVistoriaProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listaVistoriaProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Minhas Vistorias",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.novaVistoriaInicial),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(listaVistoriaProvider.notifier)
                            .changeStatusFilter(1);
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        fixedSize: const WidgetStatePropertyAll(
                          Size.fromHeight(40),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          state.statusId == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        "Em andamento",
                        style: TextStyle(
                          color: state.statusId == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(listaVistoriaProvider.notifier)
                            .changeStatusFilter(2);
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        fixedSize: const WidgetStatePropertyAll(
                          Size.fromHeight(40),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          state.statusId == 2
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        "Concluídas",
                        style: TextStyle(
                          color: state.statusId == 2
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: state.vistorias.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          state.vistorias.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.vistorias.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final vistoria = state.vistorias[index];
                        return _VistoriaCard(vistoria: vistoria);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VistoriaCard extends StatelessWidget {
  final Vistoria vistoria;

  const _VistoriaCard({required this.vistoria});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vistoria.veiculo.modelo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: vistoria.status.id == 1
                          ? Colors.orange.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      vistoria.status.nome,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: vistoria.status.id == 1
                            ? Colors.orange.shade900
                            : Colors.green.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.drive_eta, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    vistoria.veiculo.placa.toUpperCase(),
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${vistoria.veiculo.ano}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(vistoria.data),
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
