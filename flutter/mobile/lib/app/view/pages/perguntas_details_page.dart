import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controllers/cubits/service/question_cubit.dart';
import '../controllers/cubits/service/question_state.dart';

class AskDetails extends StatefulWidget {
  final int itemId;
  const AskDetails({super.key, required this.itemId});

  @override
  State<AskDetails> createState() => _AskDetailsState();
}

class _AskDetailsState extends State<AskDetails> {
  final PerguntasCubit cubit = PerguntasCubit();
  @override
  void initState() {
    // Inicia a busca pelos detalhes e respostas da pergunta assim que a tela é carregada
    context.read<PerguntasCubit>().fetchQuestionWithResponses(widget.itemId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta #${widget.itemId}'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Usa pop para voltar para a tela anterior
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<PerguntasCubit, PerguntasState>(
        builder: (context, state) {
          // --- ESTADOS DE CARREGAMENTO E ERRO ---
          if (state is PerguntasLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PerguntasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                    const SizedBox(height: 10),
                    Text('Erro ao carregar detalhes: ${state.message}', textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Tenta recarregar os dados
                        context.read<PerguntasCubit>().fetchQuestionWithResponses(widget.itemId);
                      },
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          } 
          // --- ESTADO DE SUCESSO ---
          else if (state is PerguntasWithRespostasLoaded) {
            final data = cubit.perguntasWithRespostas;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DETALHES DA PERGUNTA
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         data!.pergunta.title ?? 'Título Desconhecido',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.pergunta.description ?? 'Sem descrição',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'ID: ${data.pergunta.id}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // LISTA DE RESPOSTAS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Respostas (${data.respostas?.length ?? 0})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Botão para adicionar nova resposta (futura feature)
                      // IconButton(
                      //   icon: const Icon(Icons.add_comment, color: Colors.green),
                      //   onPressed: () {
                      //     // Implementar navegação para o formulário de resposta
                      //   },
                      // ),
                    ],
                  ),
                  const Divider(height: 10, thickness: 2),

                  if (data.respostas == null || data.respostas!.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text('Nenhuma resposta ainda. Seja o primeiro a responder!', style: TextStyle(fontStyle: FontStyle.italic)),
                      ),
                    )
                  else
                    ...data.respostas!.map((resposta) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: const Icon(Icons.reply_all, color: Colors.green),
                          title: Text(resposta.description ?? 'Resposta sem conteúdo', style: const TextStyle(fontSize: 15)),
                          subtitle: Text('ID da Resposta: ${resposta.id}', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                        ),
                      ),
                    )),
                ],
              ),
            );
          }

          // Estado inicial ou qualquer outro estado não mapeado
          return Center(
            child: Text('Carregando informações da pergunta ${widget.itemId}...'),
          );
        },
      ),
    );
  }
}