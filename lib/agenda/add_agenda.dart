import 'package:flutter/material.dart';

class AddAgendaPage extends StatefulWidget {
  const AddAgendaPage({super.key});

  @override
  State<AddAgendaPage> createState() => _AddAgendaPageState();
}

class _AddAgendaPageState extends State<AddAgendaPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime agendaDate = DateTime.now();
  bool reminder = false;
  String reminderTime = '1 day before';
  DateTime selectedDateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  title = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      selectedDateNow = selectedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(text: "${selectedDateNow.toLocal()}".split(' ')[0]),
              ),
              SwitchListTile(
                title: const Text('Set Reminder'),
                value: reminder,
                onChanged: (value) {
                  setState(() {
                    reminder = value;
                  });
                },
              ),
              if (reminder)
                DropdownButtonFormField<String>(
                  value: reminderTime,
                  decoration: const InputDecoration(labelText: 'Reminder Time'),
                  items: ['1 day before', '3 hours before', '1 hour before'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      reminderTime = value!;
                    });
                  },
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value ?? '';
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Navigator.pop(context, {
                      'title': title,
                      'description': description,
                      'agendaDate': agendaDate,
                      'reminder': reminder,
                      'reminderTime': reminderTime,
                    });
                  }
                },
                child: const Text('Save Agenda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
