// view/pages/home_page.dart
// import 'package:flutter/material.dart';

// import '../../data/service/connection.dart';
// import '../../domain/entities/perguntas_model.dart';

// class PerguntasScreen extends StatefulWidget {
//   const PerguntasScreen({super.key});

//   @override
//   State<PerguntasScreen> createState() => _PerguntasScreenState();
// }

// class _PerguntasScreenState extends State<PerguntasScreen> {
//   late Future<List<Pergunta>> _perguntasFuture;
//   final _dataSource = PerguntaRemoteDataSource();

//   @override
//   void initState() {
//     super.initState();
//     // Inicia a busca pelos dados da API Node.js
//     _perguntasFuture = _dataSource.getAllPerguntas();
//   }

//   // Equivalente ao seu parcial/header.ejs + parcial/navbar.ejs
//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Text('Asks & Responses'),
//       centerTitle: true,
//       backgroundColor: Colors.indigo,
//       foregroundColor: Colors.white,
//       elevation: 4,
//     );
//   }

//   // Equivalente ao loop de cards
//   Widget _buildQuestionCard(Pergunta pergunta) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         children: [
//           // card-body
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pergunta.title, // Seu <%= pergunta.titulo %>
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // card-footer
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(12),
//                 bottomRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Equivalente ao <button class="btn btn-primary">Responder</button>
//                 TextButton.icon(
//                   onPressed: () {
//                     // TODO: Implementar navegação para a tela de resposta
//                     debugPrint('Abrir pergunta ID: ${pergunta.id}');
//                   },
//                   icon: const Icon(Icons.reply, size: 18),
//                   label: const Text('Responder'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.indigo,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       // Equivalente ao <div class="container">
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Equivalente a <h1> Perguntas </h1>
//             const Padding(
//               padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
//               child: Text(
//                 'Perguntas',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const Divider(),
            
//             // Equivalente ao <a href="/perguntar" class="btn btn-primary">Perguntar</a>
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // TODO: Implementar navegação para a tela de fazer pergunta
//                   debugPrint('Navegar para tela de perguntar');
//                 },
//                 icon: const Icon(Icons.add_comment),
//                 label: const Text('Perguntar'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const Divider(),

//             // FutureBuilder para carregar a lista de perguntas
//             Expanded(
//               child: FutureBuilder<List<Pergunta>>(
//                 future: _perguntasFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Carregando
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     // Erro (muitas vezes, erro de conexão com a API)
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text('Erro ao carregar dados da API.', style: TextStyle(color: Colors.red)),
//                             Text('Detalhe: ${snapshot.error}', textAlign: TextAlign.center),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _perguntasFuture = _dataSource.getAllPerguntas(); // Tenta recarregar
//                                 });
//                               },
//                               child: const Text('Tentar Novamente'),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     // Lista vazia
//                     return const Center(
//                       child: Text('Nenhuma pergunta encontrada. Seja o primeiro a perguntar!'),
//                     );
//                   } else {
//                     // Dados carregados (Equivalente ao loop <% perguntas.forEach(...) %>)
//                     final perguntas = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: perguntas.length,
//                       itemBuilder: (context, index) {
//                         return _buildQuestionCard(perguntas[index]);
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Não há footer.ejs, então o Scaffold termina aqui.
//     );
//   }
// }