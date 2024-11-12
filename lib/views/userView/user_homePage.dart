import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/side_barMenu.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/views/userView/Recomemendation_detail_screen.dart';
import 'package:feelhope/views/userView/user_noteScreen.dart';
import 'package:feelhope/views/userView/user_report_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomepage extends StatefulWidget {
  UserHomepage();

  @override
  _UserHomepageState createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int touchedIndex = -1;
  late Map<String, double> sentimentoPorcentagens = {
  "Tristeza e Angústia": 40,
  "Felicidade e Motivação": 30,
  "Neutro": 20,
  "Estresse": 10,
};


  @override
void initState() {
  super.initState();
  
  // Inicializando sentimentoPorcentagens com dados mockados no initState
  sentimentoPorcentagens = {
    "Tristeza e Angústia": 40,
    "Felicidade e Motivação": 30,
    "Neutro": 20,
    "Estresse": 10,
  };
}


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        actions: [
          ThemeSwitch(),
        ],
      ),
      drawer: SideBarMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecomendacaoSection(),
                SizedBox(height: 20),
                Text(
                  'Gráfico referente a como você se sentiu essa semana',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                _buildPieChart(sentimentoPorcentagens),
                _buildLegenda(),
                _buildBotoesAcoes(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecomendacaoSection() {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendationDetailScreen(
            title: 'Recomendações',
            subtitle: 'Recomendações diárias para seu bem-estar',
            description: 'Aqui você encontrará recomendações para ajudar no seu dia a dia e melhorar sua qualidade de vida.',
            imageUrl: 'https://via.placeholder.com/150', // URL de exemplo para a imagem
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Color(0xFF9A4DFF).withOpacity(0.8),
            Color(0xFF7F7FFF).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.recommend, size: 40, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Recomendações\nLorem Ipsum has been the industry\'s standard dummy text.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildPieChart(Map<String, double> sentimentoPorcentagens) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                touchedIndex = pieTouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
              });
            },
          ),
          sections: _generateChartSections(sentimentoPorcentagens),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateChartSections(Map<String, double> sentimentoPorcentagens) {
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];
    final sentimentos = [
      "Tristeza e Angústia",
      "Felicidade e Motivação",
      "Neutro",
      "Estresse",
    ];
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        color: colors[i],
        value: sentimentoPorcentagens[sentimentos[i]] ?? 0,
        title: '${(sentimentoPorcentagens[sentimentos[i]] ?? 0).toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Widget _buildLegenda() {
    return Column(
      children: [
        buildLegendItem(Colors.blue, 'Tristeza e Angústia'),
        buildLegendItem(Colors.green, 'Felicidade e Motivação'),
        buildLegendItem(Colors.orange, 'Neutro'),
        buildLegendItem(Colors.red, 'Estresse'),
      ],
    );
  }

  Widget buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildBotoesAcoes() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GradienteButton(
              text: "Relatar meu dia",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserNoteScreen()));
              },
              gradient: LinearGradient(
                  colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
              textColor: Colors.white),
          Divider(),
          GradienteButton(
              text: "Meus relatórios",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserReportScreen()));
              },
              gradient: LinearGradient(
                  colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)]),
              textColor: Colors.white),
        ],
      ),
    );
  }
}
