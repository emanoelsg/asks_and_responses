import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_states.dart';



class AskDetails extends StatefulWidget {
  final int itemId;
  const AskDetails({super.key, required this.itemId});

  @override
  State<AskDetails> createState() => _AskDetailsState();
}

class _AskDetailsState extends State<AskDetails> {
  @override
  void initState() {
    // Inicia a busca pelos detalhes e respostas da pergunta assim que a tela é carregada
    context.read<DetailsCubit>().fetchQuestionWithResponses(widget.itemId);
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
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DetailsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<DetailsCubit>().fetchQuestionWithResponses(widget.itemId),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is DetailsLoaded) {
            final data = state.perguntaWithRespostas;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card da Pergunta
                  Card(
                    color: Colors.indigo.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.pergunta.title ?? 'Sem Título',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                          const SizedBox(height: 8),
                          Text(data.pergunta.description ?? 'Sem descrição'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Respostas (${data.respostas?.length ?? 0})',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  if (data.respostas == null || data.respostas!.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text('Nenhuma resposta ainda.')),
                    )
                  else
                    ...data.respostas!.map((resp) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.comment, color: Colors.blue),
                            title: Text(resp.description ?? ''),
                            subtitle: Text('ID: ${resp.id}', style: const TextStyle(fontSize: 10)),
                          ),
                        )),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
