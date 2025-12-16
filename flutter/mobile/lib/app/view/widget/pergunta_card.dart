// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/domain/entities/question_model.dart';

class AskCard extends StatelessWidget {
  const AskCard({super.key, required this.question});
  final Pergunta question;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
       context.push('/details/${question.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(question.title!),
      ),
    );
  }
}
