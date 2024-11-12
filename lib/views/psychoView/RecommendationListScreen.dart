import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/views/psychoView/AddRecommendationScreen.dart';
import 'package:feelhope/views/userView/Recomemendation_detail_screen.dart';
import 'package:flutter/material.dart';

class RecommendationListScreen extends StatefulWidget {
  @override
  _RecommendationListScreenState createState() => _RecommendationListScreenState();
}

class _RecommendationListScreenState extends State<RecommendationListScreen> {
  final List<Map<String, String>> mockRecommendations = [
    {
      "title": "Pratique a Gratidão",
      "subtitle": "Comece o dia pensando em algo positivo.",
      "description":
          "Reservar um tempo para pensar nas coisas boas que aconteceram no seu dia pode melhorar significativamente o seu humor.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "title": "Faça uma Pausa",
      "subtitle": "Intervalos regulares ajudam a reduzir o estresse.",
      "description":
          "Mesmo alguns minutos longe da rotina pode aliviar o estresse. Tente uma respiração profunda e relaxe.",
      // "imageUrl" está ausente para tornar opcional
    },
  ];

  void _navigateToAddRecommendation() async {
    // Abre a tela de adição e aguarda o retorno da nova recomendação
    final newRecommendation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRecommendationScreen(),
      ),
    );

    if (newRecommendation != null) {
      setState(() {
        mockRecommendations.add(newRecommendation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recomendações"),
        actions: [ThemeSwitch()],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockRecommendations.length,
        itemBuilder: (context, index) {
          final recommendation = mockRecommendations[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecommendationDetailScreen(
                    title: recommendation["title"]!,
                    subtitle: recommendation["subtitle"]!,
                    description: recommendation["description"]!,
                    imageUrl: recommendation["imageUrl"] ?? '', // Corrigido: passa string vazia se `imageUrl` for null
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation["title"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          recommendation["subtitle"]!,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddRecommendation,
        backgroundColor: Color(0xFF9A4DFF),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
