// view/pages/perguntas_page.dart
// import 'package:flutter/material.dart';

// import '../../data/service/connection.dart';
// import '../../domain/entities/perguntas_model.dart';
// import '../../domain/entities/respostas_model.dart';
// class PerguntaDetailScreen extends StatefulWidget {
//   final int perguntaId;

//   const PerguntaDetailScreen({super.key, required this.perguntaId});

//   @override
//   State<PerguntaDetailScreen> createState() => _PerguntaDetailScreenState();
// }

// class _PerguntaDetailScreenState extends State<PerguntaDetailScreen> {
//   late Future<PerguntaDetail> _perguntaDetailFuture;
//   final _dataSource = PerguntaDetailRemoteDataSource();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _respostaController = TextEditingController();
//   bool _isSending = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPergunta();
//   }

//   void _fetchPergunta() {
//     setState(() {
//       _perguntaDetailFuture = _dataSource.getPerguntaDetail(widget.perguntaId);
//     });
//   }

//   Future<void> _submitResposta() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() { _isSending = true; });

//       try {
//         final corpo = _respostaController.text;
//         await _dataSource.postResposta(widget.perguntaId, corpo);
        
//         // Limpa o campo e recarrega a página para mostrar a nova resposta
//         _respostaController.clear();
//         _fetchPergunta(); 
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Resposta enviada com sucesso!')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erro ao enviar resposta: ${e.toString()}')),
//         );
//       } finally {
//         setState(() { _isSending = false; });
//       }
//     }
//   }

//   // Formulário de Resposta (Equivalente ao <form method="POST" action="/responder">)
//   Widget _buildResponseForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Responda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           // Equivalente ao <textarea>
//           TextFormField(
//             controller: _respostaController,
//             decoration: const InputDecoration(
//               labelText: 'Sua Resposta',
//               hintText: 'Digite sua resposta aqui',
//               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//               alignLabelWithHint: true,
//             ),
//             maxLines: 4,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'A resposta não pode ser vazia.';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 15),
//           // Equivalente ao <button type="submit" class="btn btn-primary">
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _isSending ? null : _submitResposta,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.indigo,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: _isSending
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                     )
//                   : const Text('Responder', style: TextStyle(fontSize: 16)),
//             ),
//           ),
//           const Divider(height: 30),
//         ],
//       ),
//     );
//   }

//   // Card de Resposta (Equivalente ao loop <% respostas.forEach(...) %>)
//   Widget _buildRespostaCard(Resposta resposta) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Text(
//           resposta.body, // Seu <%= resposta.corpo %>
//           style: const TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // O AppBar seria incluído pelo `partials/navbar.ejs` e `header.ejs`
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detalhes da Pergunta'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       // O FutureBuilder carrega os dados da API antes de construir o corpo principal
//       body: FutureBuilder<PerguntaDetail>(
//         future: _perguntaDetailFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erro ao carregar pergunta: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return const Center(child: Text('Pergunta não encontrada.'));
//           }
          
//           final pergunta = snapshot.data!;
          
//           // Equivalente ao <div class="container"> com todo o conteúdo
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Detalhes da Pergunta (<h1> e <p>)
//                 const Divider(height: 10),
//                 Text(
//                   pergunta.title, // Seu <%= pergunta.titulo %>
//                   style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.indigo),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   pergunta.description, // Seu <%= pergunta.descricao %>
//                   style: const TextStyle(fontSize: 16, color: Colors.black87),
//                 ),
//                 const Divider(height: 30),

//                 // Formulário de Resposta
//                 _buildResponseForm(),

//                 // Título das Respostas (<h3> Respostas)
//                 const Text('Respostas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const Divider(),
                
//                 // Lista de Respostas (Loop de Respostas)
//                 if (pergunta.answers.isEmpty)
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text('Seja o primeiro a responder esta pergunta!', style: TextStyle(fontStyle: FontStyle.italic)),
//                   )
//                 else
//                   ...pergunta.answers.map(_buildRespostaCard).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }