import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/side_barMenu.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomepage extends StatefulWidget {
  @override
  _UserHomepageState createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int touchedIndex = -1;

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
                Container(
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
                SizedBox(height: 20),
                Text(
                  'Gráfico referente a como você se sentiu essa semana',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse != null &&
                                  pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              } else {
                                touchedIndex = -1;
                              }
                            });
                          },
                        ),
                        sections: _showingSections(),
                      ),
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Duração da animação
                      swapAnimationCurve: Curves.easeInOut, // Curva da animação
                    ),
                  ),
                ),
                buildLegendItem(Colors.blue, 'Tristeza e Angústia'),
                buildLegendItem(Colors.green, 'Felicidade e Motivação'),
                buildLegendItem(Colors.orange, 'Neutro'),
                buildLegendItem(Colors.red, 'Estresse'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GradienteButton(
                          text: "Relatar meu dia",
                          onPressed: () {
                            Navigator.pushNamed(context, "user-notes");
                          },
                          gradient: LinearGradient(
                              colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                          textColor: Colors.white),
                      Divider(),
                      GradienteButton(
                          text: "Meus relatorios",
                          onPressed: () {},
                          gradient: LinearGradient(
                              colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)]),
                          textColor: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange,
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Error();
      }
    });
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
}
