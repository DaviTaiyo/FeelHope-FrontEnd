import 'package:flutter/material.dart';

class PacientesPage extends StatefulWidget {
  @override
  _PacientesPageState createState() => _PacientesPageState();
}

class _PacientesPageState extends State<PacientesPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> pacientes = ["Guilherme Mendes", "Maria Julia", "Lucas Augusto"];
  List<String> _filteredPacientes = [];

  @override
  void initState() {
    super.initState();
    _filteredPacientes = pacientes;
    _searchController.addListener(_filterPacientes);
  }

  void _filterPacientes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPacientes = pacientes.where((paciente) {
        return paciente.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPacientes);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pacientes"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Procure por paciente",
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7F7FFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9A4DFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: Icon(Icons.search, color: Color(0xFF9A4DFF)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPacientes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFE8EAF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        _filteredPacientes[index],
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PacienteDetailPage(nome: _filteredPacientes[index])),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemoverPacientePage(pacientes: pacientes)),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF9A4DFF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
              child: Text("Remover algum paciente?"),
            ),
          ],
        ),
      ),
    );
  }
}

class PacienteDetailPage extends StatelessWidget {
  final String nome;

  PacienteDetailPage({required this.nome});

  @override
  Widget build(BuildContext context) {
    final pacienteInfo = {
      "Guilherme Mendes": {
        "Idade": "22",
        "Contato": "(55)9999-9999",
        "Total de Relatórios": "15",
        "Média de Relatórios": "1 por semana",
        "Tristeza": "20%",
        "Felicidade": "80%",
      },
      "Maria Julia": {
        "Idade": "15",
        "Contato": "(55)7777-6666",
        "Total de Relatórios": "10",
        "Média de Relatórios": "2 por semana",
        "Tristeza": "30%",
        "Felicidade": "70%",
      },
      "Lucas Augusto": {
        "Idade": "55",
        "Contato": "(55)1234-5678",
        "Total de Relatórios": "30",
        "Média de Relatórios": "2 por semana",
        "Tristeza": "60%",
        "Felicidade": "40%",
      },
    };

    final info = pacienteInfo[nome] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Paciente"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "${entry.key}: ${entry.value}",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class RemoverPacientePage extends StatelessWidget {
  final List<String> pacientes;

  RemoverPacientePage({required this.pacientes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remover Pacientes"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Color(0xFF7F7FFF)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7F7FFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9A4DFF)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: Icon(Icons.search, color: Color(0xFF9A4DFF)),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFE8EAF6), // Tom claro para contraste
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        pacientes[index],
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelecionarMotivoRemoverPage(paciente: pacientes[index])),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelecionarMotivoRemoverPage extends StatefulWidget {
  final String paciente;

  SelecionarMotivoRemoverPage({required this.paciente});

  @override
  _SelecionarMotivoRemoverPageState createState() => _SelecionarMotivoRemoverPageState();
}

class _SelecionarMotivoRemoverPageState extends State<SelecionarMotivoRemoverPage> {
  bool _naoConsulta = false;
  bool _estaMelhor = false;
  bool _outrosMotivos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remover ${widget.paciente}"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text("Não consulta mais", style: TextStyle(color: Colors.black87)),
              value: _naoConsulta,
              activeColor: Color(0xFF7F7FFF),
              onChanged: (value) {
                setState(() {
                  _naoConsulta = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Outros motivos", style: TextStyle(color: Colors.black87)),
              value: _outrosMotivos,
              activeColor: Color(0xFF7F7FFF),
              onChanged: (value) {
                setState(() {
                  _outrosMotivos = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Está melhor", style: TextStyle(color: Colors.black87)),
              value: _estaMelhor,
              activeColor: Color(0xFF7F7FFF),
              onChanged: (value) {
                setState(() {
                  _estaMelhor = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${widget.paciente} removido com sucesso!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9A4DFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }
}
