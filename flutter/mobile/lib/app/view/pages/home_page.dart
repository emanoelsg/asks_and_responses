// app/view/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_cubit.dart';

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
    return Scaffold();
  }
}
