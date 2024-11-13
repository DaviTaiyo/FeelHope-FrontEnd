import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';

class RecommendationDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String? imageUrl;

  const RecommendationDetailScreen({
    required this.title,
    required this.subtitle,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [ThemeSwitch()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe a imagem apenas se o URL for válido
            if (imageUrl != null && (imageUrl!.startsWith("http") || imageUrl!.startsWith("https")))
              Image.network(imageUrl!),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
