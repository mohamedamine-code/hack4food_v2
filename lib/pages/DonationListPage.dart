import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  State<AddDonationPage> createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  File? _image;
  final picker = ImagePicker();
  final quantityController = TextEditingController();
  final locationController = TextEditingController();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> classifyAndUpload() async {
    if (_image == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://<YOUR_FLASK_URL>/predict'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    final response = await request.send();
    final resBody = await response.stream.bytesToString();
    final foodType = jsonDecode(resBody)['class'];

    final ref = FirebaseStorage.instance.ref().child('donations/${DateTime.now()}.jpg');
    await ref.putFile(_image!);
    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('donations').add({
      'image': imageUrl,
      'type': foodType,
      'quantity': quantityController.text,
      'location': locationController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نشر التبرع بنجاح!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة تبرع')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
              ? Image.file(_image!, height: 200)
              : const Placeholder(fallbackHeight: 200),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('اختيار صورة'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'الكمية'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'الموقع'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: classifyAndUpload,
              child: const Text('تبرع الآن'),
            ),
          ],
        ),
      ),
    );
  }
}