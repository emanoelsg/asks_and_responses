// app/view/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/question_model.dart';
import '../controllers/cubits/service/question_cubit.dart';
import '../controllers/cubits/service/question_state.dart';

class PerguntasScreen extends StatefulWidget {
  const PerguntasScreen({super.key});

  @override
  State<PerguntasScreen> createState() => _PerguntasScreenState();
}

class _PerguntasScreenState extends State<PerguntasScreen> {

  @override
  void initState() {
    super.initState();
    // 1. Dispara a ação de buscar perguntas imediatamente ao iniciar a tela.
    context.read<PerguntasCubit>().fetchQuestions();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Asks & Responses'),
      centerTitle: true,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 4,
    );
  }

  // Widget para construir o card de cada pergunta
  Widget _buildQuestionCard(Pergunta pergunta) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // card-body (Conteúdo da Pergunta)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    pergunta.title ?? 'Título não informado',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descrição (resumo)
                  Text(
                    pergunta.description ?? 'Descrição não informada',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // card-footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ${pergunta.id}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                // Botão Responder
                TextButton.icon(
                  onPressed: () {
                    // TODO: Implementar navegação para a tela de resposta/detalhe
                    debugPrint('Abrir pergunta ID: ${pergunta.id}');
                  },
                  icon: const Icon(Icons.reply, size: 18),
                  label: const Text('Responder'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 2. Usando BlocBuilder para reconstruir a UI com base no estado do Cubit.
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
              child: Text(
                'Perguntas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            
            // Botão Perguntar
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  // TODO: Implementar navegação para a tela de fazer pergunta
                  debugPrint('Navegar para tela de perguntar');
                  // Exemplo de como postar uma pergunta (usando o mock)
                  // await context.read<PerguntasCubit>().postQuestion(
                  //   title: 'Nova Pergunta de Teste', 
                  //   description: 'Esta é uma pergunta postada via UI.',
                  // );
                },
                icon: const Icon(Icons.add_comment),
                label: const Text('Perguntar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const Divider(),

            // 3. Onde o BlocBuilder entra em ação para gerenciar o estado
            Expanded(
              child: BlocBuilder<PerguntasCubit, PerguntasState>(
                builder: (context, state) {
                  if (state is PerguntasLoading) {
                    // Estado de Carregamento
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PerguntasError) {
                    // Estado de Erro
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Erro ao carregar dados: ${state.message}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 10),
                            // Botão para tentar recarregar os dados
                            ElevatedButton(
                              onPressed: () {
                                context.read<PerguntasCubit>().fetchQuestions();
                              },
                              child: const Text('Tentar Novamente'),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is PerguntasLoaded) {
                    // Estado de Sucesso
                    final perguntas = state.perguntas;

                    if (perguntas.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma pergunta encontrada. Seja o primeiro a perguntar!'),
                      );
                    }

                    // Exibe a lista de perguntas
                    return ListView.builder(
                      itemCount: perguntas.length,
                      itemBuilder: (context, index) {
                        return _buildQuestionCard(perguntas[index]);
                      },
                    );
                  }
                  
                  // Estado inicial ou outro estado não tratado
                  return const Center(child: Text('Pronto para carregar...'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}