import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/constant.dart';
import '../helper/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = 'candidate@deptechdigital.com';
  DateTime birthDate = DateTime.now();
  String gender = 'Male';
  String? photo;
  String photoPath = "";
  bool pickPhoto = false;
  bool photoValidation = true;

  void _pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickPhoto = true;
        File fileTemp = File(image.path);
        Uint8List photoBusinessPlaceBytes = fileTemp.readAsBytesSync();
        photo = base64Encode(photoBusinessPlaceBytes);
        photoPath = image.path;
        photoValidation = true;
        debugPrint("path local =>${image.path}");
      });
    }
  }

  Widget _displayAddedPhoto(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: MyColors.mediumGray, width: 1)
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(Utils.convertBase64Image(photo!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: (){
                setState(() {
                  photo = null;
                  photoPath = "";
                  pickPhoto = false;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                width: 30,
                height: 30,
                child: Image.asset(MyIcons.statusRejected),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _plusIconButton(String title, VoidCallback onClicked,
      {double marginTop = 20, double marginBottom = 20}){
    return InkWell(
      onTap: onClicked,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  MyIcons.addCircleBlue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: MyColors.blueSea,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/agenda');
          },
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              photo == null ?
              _plusIconButton("Upload Photo",
                      ()=>_pickImage()) :
              _displayAddedPhoto(),
              TextFormField(
                initialValue: firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  firstName = value ?? '';
                },
              ),
              TextFormField(
                initialValue: lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  lastName = value ?? '';
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                readOnly: true,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Date'),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      birthDate = selectedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(text: "${birthDate.toLocal()}".split(' ')[0]),
              ),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Update profile logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile Updated')),
                    );
                  }
                },
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
