import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';

class InspecaoCard extends StatelessWidget {
  final Inspecao inspecao;
  const InspecaoCard({super.key, required this.inspecao});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: .center,
          spacing: 15,
          children: [
            Icon(
              Icons.fact_check,
              color: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inspecao.item.nome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Status: ${inspecao.status.nome}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
