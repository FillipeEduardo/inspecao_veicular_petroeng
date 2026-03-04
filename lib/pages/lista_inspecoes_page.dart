import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/providers/inspecao_provider.dart';
import 'package:intl/intl.dart';

class ListaInspecoesPage extends ConsumerStatefulWidget {
  const ListaInspecoesPage({super.key});

  @override
  ConsumerState<ListaInspecoesPage> createState() => _ListaInspecoesPageState();
}

class _ListaInspecoesPageState extends ConsumerState<ListaInspecoesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inspecaoProvider.notifier).loadInspecoes(statusId: 1);
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
      ref.read(inspecaoProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inspecaoProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Minhas Inspeções",
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
                            .read(inspecaoProvider.notifier)
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
                            .read(inspecaoProvider.notifier)
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
              child: state.inspecoes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          state.inspecoes.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.inspecoes.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final inspecao = state.inspecoes[index];
                        return _InspecaoCard(inspecao: inspecao);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InspecaoCard extends StatelessWidget {
  final Inspecao inspecao;

  const _InspecaoCard({required this.inspecao});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: Navegar para detalhes da inspeção
        },
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
                    inspecao.veiculo.modelo,
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
                      color: inspecao.statusInspecao.id == 1
                          ? Colors.orange.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      inspecao.statusInspecao.nome,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: inspecao.statusInspecao.id == 1
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
                    inspecao.veiculo.placa.toUpperCase(),
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
                    '${inspecao.veiculo.ano}',
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
                    DateFormat(
                      'dd/MM/yyyy - HH:mm',
                    ).format(inspecao.dataInspecao),
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
