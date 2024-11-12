// import 'package:feelhope/data/datasources/remote/sentimento_service.dart';
// import 'package:feelhope/data/models/sentimento_model.dart';
// import 'package:flutter/material.dart';

// class SentimentoScreen extends StatefulWidget {
//   final int usuarioId;

//   SentimentoScreen({required this.usuarioId});

//   @override
//   _SentimentoScreenState createState() => _SentimentoScreenState();
// }

// class _SentimentoScreenState extends State<SentimentoScreen> {
//   final SentimentoService _sentimentoService = SentimentoService();
//   List<SentimentoModel> _sentimentos = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSentimentos();
//   }

//   Future<void> _loadSentimentos() async {
//     try {
//       final sentimentos = await _sentimentoService.getSentimentos(widget.usuarioId);
//       setState(() {
//         _sentimentos = sentimentos;
//       });
//     } catch (e) {
//       print('Erro ao carregar sentimentos: $e');
//     }
//   }

//   Future<void> _showFormDialog([SentimentoModel? sentimento]) async {
//     final TextEditingController nomeController = TextEditingController(text: sentimento?.nome ?? '');

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(sentimento == null ? 'Novo Sentimento' : 'Editar Sentimento'),
//           content: TextField(
//             controller: nomeController,
//             decoration: InputDecoration(labelText: 'Nome'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancelar'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 final nome = nomeController.text;
//                 if (sentimento == null) {
//                   await _sentimentoService.createSentimento(SentimentoModel(
//                     usuarioId: widget.usuarioId,
//                     nome: nome,
//                   ));
//                 } else {
//                   await _sentimentoService.updateSentimento(
//                     SentimentoModel(id: sentimento.id, usuarioId: widget.usuarioId, nome: nome),
//                   );
//                 }
//                 _loadSentimentos();
//               },
//               child: Text('Salvar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _deleteSentimento(int id) async {
//     await _sentimentoService.deleteSentimento(id);
//     _loadSentimentos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sentimentos'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () => _showFormDialog(),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _sentimentos.length,
//         itemBuilder: (context, index) {
//           final sentimento = _sentimentos[index];
//           return ListTile(
//             title: Text(sentimento.nome),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _showFormDialog(sentimento),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteSentimento(sentimento.id!),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
