import 'package:feelhope/components/report_card.dart';
import 'package:feelhope/components/side_barMenu.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/models/Usuario_model.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/psychoView/RecommendationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePagePsyco extends StatefulWidget {
  @override
  _HomePagePsycoState createState() => _HomePagePsycoState();
}

class _HomePagePsycoState extends State<HomePagePsyco> {
  final UsuarioService _usuarioService = UsuarioService();
  Usuario? usuario; // Alterado para tipo Usuario
  bool isLoading = true;

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
          usuario =
              userData; // Agora atribuimos userData ao usuario do tipo Usuario
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Erro ao carregar usuário: $e");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("Token de autenticação não encontrado.");
    }
  }

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
      drawer: SideBarMenu(
        nomeUsuario: usuario?.nome ??
            "Carregando...", // Usamos as propriedades do objeto Usuario
        emailUsuario: usuario?.email ?? "Carregando...",
        avatarUrl: usuario?.foto,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                  ReportCard(),
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
