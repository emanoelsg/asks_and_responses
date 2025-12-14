// app/view/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/cubits/service/question_cubit.dart';
import '../controllers/cubits/service/question_state.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas e Respostas'),
      ),
      body: BlocBuilder<PerguntasCubit, PerguntasState>(
        builder: (context, state) {
          if (state is PerguntasLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PerguntasLoaded) {
            final questions = state.perguntas;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return ListTile(
                  title: Text(question.title!),
                  subtitle: Text(question.description!),
                );
              },
            );
          } else if (state is PerguntasError) {
            return Center(child: Text('Erro: ${state.message}'));
          }
          return const Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
