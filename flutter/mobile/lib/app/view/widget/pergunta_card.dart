import 'package:flutter/material.dart';
import 'package:mobile/app/domain/entities/question_model.dart';

class AskCard extends StatelessWidget {
  const AskCard({super.key, required this.question});
  final Pergunta question;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(question.title!),
      ),
    );
  }
}
