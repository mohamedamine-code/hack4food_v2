import 'package:flutter/material.dart';

class AboutFoodWasteWidget extends StatelessWidget {
  const AboutFoodWasteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos de notre projet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lutter contre le gaspillage alimentaire',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Chaque année, des tonnes de nourriture sont gaspillées à travers le monde. '
              'Notre application a pour but de sensibiliser, informer et proposer des solutions '
              'pour réduire ce gaspillage et promouvoir un mode de consommation plus responsable.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Icon(Icons.inventory_sharp,size: 30,)
              ),
            
            SizedBox(height: 24),
            Text(
              'Ensemble, nous pouvons faire la différence 🌍✨',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.green[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
