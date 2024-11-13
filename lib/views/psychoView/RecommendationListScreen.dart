import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/recomendacao_service.dart';
import 'package:feelhope/views/psychoView/AddRecommendationScreen.dart';
import 'package:feelhope/views/psychoView/RecommendationDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationListScreen extends StatefulWidget {
  @override
  _RecommendationListScreenState createState() =>
      _RecommendationListScreenState();
}

class _RecommendationListScreenState extends State<RecommendationListScreen> {
  final RecommendationService _recommendationService = RecommendationService();
  List<Map<String, dynamic>> recommendations = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final usuarioId = prefs.getInt('usuarioId');

    if (token == null || usuarioId == null) {
      setState(() {
        isLoading = false;
        errorMessage = "Token de autenticação ou ID do usuário não encontrado.";
      });
      return;
    }

    try {
      final fetchedRecommendations = await _recommendationService
          .getRecommendationsByUserId(token, usuarioId);
      setState(() {
        recommendations = fetchedRecommendations;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Erro ao carregar recomendações: $e";
      });
    }
  }

  void _navigateToAddRecommendation() async {
    final newRecommendation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRecommendationScreen(),
      ),
    );

    if (newRecommendation != null) {
      setState(() {
        recommendations.add(newRecommendation);
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : recommendations.isEmpty
                  ? Center(child: Text("Nenhuma recomendação encontrada."))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final recommendation = recommendations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecommendationDetailScreen(
                                  title: recommendation["titulo"],
                                  subtitle: recommendation["subtitulo"],
                                  description: recommendation["descricao"],
                                  imageUrl: recommendation["imageUrl"] ?? '',
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
                                Icon(Icons.thumb_up,
                                    color: Colors.white, size: 30),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recommendation["titulo"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        recommendation["subtitulo"],
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
    );
  }
}
