// app/view/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/domain/entities/question_model.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_state.dart';
import '../widget/pergunta_card.dart';

class PerguntasScreen extends StatefulWidget {
  const PerguntasScreen({super.key});

  @override
  State<PerguntasScreen> createState() => _PerguntasScreenState();
}

class _PerguntasScreenState extends State<PerguntasScreen> {
  late final PerguntasCubit cubit;
  @override
  void initState() {
    super.initState();
    context.read<PerguntasCubit>().fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
     List<Pergunta> questions;
   
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas e Respostas Anônimas'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<PerguntasCubit, PerguntasState>(
        builder: (context, state) {
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
                    Text('Erro ao carregar perguntas: ${state.message}', textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PerguntasCubit>().fetchQuestions();
                      },
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PerguntasLoaded) {
            questions = state.perguntas;
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return AskCard(question: question);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            );
          }
          return const Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
