// app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_cubit.dart';

class PerguntasApp extends StatelessWidget {
  const PerguntasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PerguntasCubit(),
      child: MaterialApp(
          title: 'Asks and Responses',
          debugShowCheckedModeBanner: false,
        )
      );}
    
  }
