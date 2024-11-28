import 'dart:math'; // Import necessário para gerar cores aleatórias
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/side_barMenu.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/models/Usuario_model.dart';
import 'package:feelhope/services/sentimento_service.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/psychoView/RecommendationListScreen.dart';
import 'package:feelhope/views/userView/user_noteScreen.dart';
import 'package:feelhope/views/userView/user_report_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomepage extends StatefulWidget {
  UserHomepage();

  @override
  _UserHomepageState createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int touchedIndex = -1;
  UsuarioService _usuarioService = UsuarioService();
  SentimentoService _sentimentoService = SentimentoService();
  Usuario? usuario;
  Map<String, double> sentimentoPorcentagens = {};
  List<Color> sentimentoCores = [];

  @override
  void initState() {
    super.initState();
    fetchUsuarioData();
  }

  Future<void> fetchUsuarioData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      try {
        final userData = await _usuarioService.getByToken(token);
        setState(() {
          usuario = userData;
        });
        if (usuario != null) {
          await fetchSentimentos(token, usuario!.id!); // Carrega os sentimentos com o token e o usuarioId
        }
      } catch (e) {
        print("Erro ao carregar usuário: $e");
      }
    }
  }

  Future<void> fetchSentimentos(String token, int usuarioId) async {
  try {
    final sentimentos = await _sentimentoService.getSentimentosByUsuario(token, usuarioId); // Obtém sentimentos

    // Calcula a soma total dos níveis
    final double totalNiveis = sentimentos.fold(0, (sum, item) => sum + item.nivel!.toDouble());

    setState(() {
      // Calcula a porcentagem para cada sentimento
      sentimentoPorcentagens = {
        for (var sentimento in sentimentos)
          sentimento.titulo!: (sentimento.nivel!.toDouble() / totalNiveis) * 100
      };

      // Gera uma cor aleatória para cada sentimento
      final random = Random();
      sentimentoCores = List.generate(sentimentoPorcentagens.length, (index) {
        return Color.fromARGB(
          255,
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        ).withOpacity(0.8);
      });
    });
  } catch (e) {
    print("Erro ao carregar sentimentos: $e");
  }
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
      drawer: SideBarMenu(
        nomeUsuario: usuario?.nome,
        emailUsuario: usuario?.email,
        avatarUrl: usuario?.foto,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
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
                _buildPieChart(),
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
            builder: (context) => RecommendationListScreen()
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
                'Recomendações\nAqui você encontrará recomendações feitas pelo seu profissional para você',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
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
          sections: _generateChartSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateChartSections() {
    return List.generate(sentimentoPorcentagens.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final sentimentoNome = sentimentoPorcentagens.keys.elementAt(i);
      return PieChartSectionData(
        color: sentimentoCores[i],
        value: sentimentoPorcentagens[sentimentoNome],
        title: '${sentimentoPorcentagens[sentimentoNome]!.toStringAsFixed(0)}%',
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
      children: List.generate(sentimentoPorcentagens.length, (index) {
        final sentimentoNome = sentimentoPorcentagens.keys.elementAt(index);
        return buildLegendItem(sentimentoCores[index], sentimentoNome);
      }),
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
              colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
            ),
            textColor: Colors.white,
          ),
          Divider(),
          GradienteButton(
            text: "Meus relatórios",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserReportScreen()));
            },
            gradient: LinearGradient(
              colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
            ),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
