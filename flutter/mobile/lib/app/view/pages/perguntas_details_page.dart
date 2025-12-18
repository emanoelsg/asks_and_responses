import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_cubit.dart';



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
          onPressed: () {
            // Usa pop para voltar para a tela anterior
            context.pop();
          },
        ),
      ),
    
      
    );
  }
}
