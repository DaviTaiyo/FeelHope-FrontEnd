import 'package:flutter/material.dart';

class PacientesPage extends StatefulWidget {
  @override
  _PacientesPageState createState() => _PacientesPageState();
}

class _PacientesPageState extends State<PacientesPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> pacientes = ["Guilherme Mendes", "Maria Julia", "Lucas Poggers"];
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
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Procure por paciente",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPacientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredPacientes[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PacienteDetailPage(nome: _filteredPacientes[index])),
                      );
                    },
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
      "Lucas Poggers": {
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
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("${entry.key}: ${entry.value}"),
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
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Nome",
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pacientes[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelecionarMotivoRemoverPage(paciente: pacientes[index])),
                      );
                    },
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
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text("Não consulta mais"),
              value: _naoConsulta,
              onChanged: (value) {
                setState(() {
                  _naoConsulta = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Outros motivos"),
              value: _outrosMotivos,
              onChanged: (value) {
                setState(() {
                  _outrosMotivos = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Está melhor"),
              value: _estaMelhor,
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
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }
}