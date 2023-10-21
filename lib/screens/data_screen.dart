import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _date = TextEditingController();
  File? _img;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Обязательное поле';
                  }
                  final regexText = RegExp(r'^[A-Za-zА-Яа-я]+$');
                  if (!regexText.hasMatch(value!)) {
                    return 'Поле может содержать только буквы';
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Текстовое поле',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Обязательное поле';
                  }
                  final regexPassword = RegExp(r'^[A-Za-z0-9_.-]+$');
                  if (!regexPassword.hasMatch(value!)) {
                    return 'Пароль может содержать только латинские буквы';
                  }
                  final sizePassword = RegExp(r'^.{5,20}$');
                  if (!sizePassword.hasMatch(value)) {
                    return 'Длина должна быть от 5 до 20 символов';
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _date,
                readOnly: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Обязательное поле';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Дата',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2024),
                  );
                  if (date != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(date);
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Обязательное поле';
                  }
                  final regexText = RegExp(r'^[0-9]+$');
                  if (!regexText.hasMatch(value!)) {
                    return 'Поле может содержать только цифры';
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Цифровое поле',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    _pickImgFromGallery();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide.none,
                      )),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(double.maxFinite, 30))),
                  child: const Text('Выбрать изображение')),
              const SizedBox(height: 10),
              _img != null
                  ? Image.file(_img!)
                  : const Text('Выберите изображение'),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {}
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide.none,
                      )),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(double.maxFinite, 30))),
                  child: const Text('Проверить'))
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImgFromGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _img = File(img!.path);
    });
  }
}
