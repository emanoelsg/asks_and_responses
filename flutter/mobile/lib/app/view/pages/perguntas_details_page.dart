import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/cubits/service/question_cubit.dart';

class AskDetails extends StatefulWidget {
  final int itemId;
  const AskDetails({super.key,required this.itemId});

  @override
  State<AskDetails> createState() => __AskDetailsState();
}

class __AskDetailsState extends State<AskDetails> {


@override
  void initState() {
    context.read<PerguntasCubit>().fetchQuestionWithResponses(widget.itemId);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
