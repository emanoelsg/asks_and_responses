// view/pages/perguntar_page.dart
// import 'package:flutter/material.dart';

// import '../../data/service/connection.dart';

// class PerguntarScreen extends StatefulWidget {
//   const PerguntarScreen({super.key});

//   @override
//   State<PerguntarScreen> createState() => _PerguntarScreenState();
// }

// class _PerguntarScreenState extends State<PerguntarScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final _dataSource = PerguntaCreationDataSource();
//   bool _isSending = false;

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitPergunta() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() { _isSending = true; });

//       try {
//         final title = _titleController.text;
//         final description = _descriptionController.text;

//         await _dataSource.postPergunta(title, description);
        
//         // Limpa os campos após o sucesso
//         _titleController.clear();
//         _descriptionController.clear();
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Pergunta enviada com sucesso!')),
//         );
        
//         // Opcional: Voltar para a tela anterior após submeter (se estiver usando navegação)
//         Navigator.of(context).pop(); 
        
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erro ao enviar pergunta: ${e.toString()}')),
//         );
//       } finally {
//         setState(() { _isSending = false; });
//       }
//     }
//   }

//   // Formulário de Criação de Pergunta (Equivalente ao <form>)
//   Widget _buildCreationForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Label e Input Título
//           const Text('Título', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: _titleController,
//             decoration: const InputDecoration(
//               hintText: 'Digite o título da sua pergunta',
//               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//               contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'O título não pode ser vazio.';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),

//           // Label e Input Descrição
//           const Text('Descrição', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: _descriptionController,
//             decoration: const InputDecoration(
//               hintText: 'Descreva sua pergunta aqui',
//               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//               alignLabelWithHint: true,
//             ),
//             maxLines: 6,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'A descrição não pode ser vazia.';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 30),

//           // Botão de Submissão (Equivalente ao <button class="btn btn-primary">)
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _isSending ? null : _submitPergunta,
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
//                   : const Text('Perguntar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Equivalente ao <%- include partials/navbar.ejs %> e <%- include partials/header.ejs %>
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Realizar Pergunta'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       // Equivalente ao <div class="container"> com o card
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Card( // Equivalente ao <div class="card" id="formulario-pergunta">
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Equivalente ao <div class="card-header"> <h3>Realizar pergunta</h3>
//                 const Text(
//                   'Faça Sua Pergunta', 
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
//                 ),
//                 const Divider(height: 30, thickness: 1.5),

//                 // Formulário
//                 _buildCreationForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }