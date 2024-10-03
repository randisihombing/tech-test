import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final List<Map<String, dynamic>> _agendas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.face),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _agendas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_agendas[index]['title']),
            subtitle: Text(_agendas[index]['description']),
            onTap: () {
              Navigator.pushNamed(context, '/agendaDetail', arguments: _agendas[index]);
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _agendas.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addAgenda').then((value) {
            if (value != null) {
              Map<String, dynamic> args = value as Map<String, dynamic>;
              setState(() {
                _agendas.add(args);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
