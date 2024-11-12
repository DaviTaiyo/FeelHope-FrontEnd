import 'package:feelhope/components/psy_side_barMenu.dart';
import 'package:feelhope/components/report_card.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/presentation/views/psychoView/RecommendationListScreen.dart';
import 'package:flutter/material.dart';

class HomePagePsyco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Menu Principal',
        ),
        actions: [ThemeSwitch()],
      ),
      drawer: PsySideBarMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecommendationListScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Recomendações\nClique para ver sugestões de bem-estar.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ReportCard(period: "24 Horas"),
            SizedBox(height: 10),
            Spacer(),
            Center(
              child: Text(
                "A saúde mental é fundamental para o bem-estar geral,\ne o papel do psicólogo é essencial na promoção e manutenção desse bem-estar.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
