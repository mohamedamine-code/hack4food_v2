import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDonationScreen extends StatefulWidget {
  @override
  _AddDonationScreenState createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  File? _image;
  String? _selectedFoodType;
  final TextEditingController _quantityController = TextEditingController();
  DateTime? _expirationDate;

  final List<String> _foodTypes = [
    'Fruits',
    'Légumes',
    'Produits laitiers',
    'Viandes',
    'Pains',
    'Conserves',
    'Surgelés',
    'Autre',
  ];

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: ${e.toString()}')));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null && picked != _expirationDate) {
      setState(() {
        _expirationDate = picked;
      });
    }
  }

  void _publishDonation() {
    if (_validateForm()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Don publié avec succès!')));
      Navigator.pop(context);
    }
  }

  bool _validateForm() {
    if (_image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Veuillez téléverser une image')));
      return false;
    }
    if (_selectedFoodType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un type d\'aliment')),
      );
      return false;
    }
    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Veuillez entrer une quantité')));
      return false;
    }
    if (_expirationDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une date de péremption')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un don')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Upload
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child:
                    _image == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 70),
                            Text(
                              'Téléverser une image 😎',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                        : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),

            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type d\'aliment',
                border: OutlineInputBorder(),
              ),
              value: _selectedFoodType,
              items:
                  _foodTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedFoodType = newValue;
                });
              },
            ),
            SizedBox(height: 20),

            // Quantity
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantité',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Expiration Date
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date de péremption',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _expirationDate == null
                          ? 'Sélectionner une date'
                          : '${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}',
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),

            // Publish Button
            ElevatedButton(
              onPressed: _publishDonation,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Publier le don',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
