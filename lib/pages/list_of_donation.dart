import 'package:flutter/material.dart';
import 'package:hack_for_food/pages/AddDonationScreen.dart';


class Liste extends StatefulWidget {
  const Liste({super.key});

  @override
  State<Liste> createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  // Liste temporaire de dons (à remplacer par votre vraie logique de données)
  final List<Map<String, dynamic>> _donations = [
    {
      'donor': 'Julie de Paris',
      'type': 'Pain',
      'quantity': '2 sacs',
      'image': null,
    },
    {
      'donor': 'Boulangerie du coin',
      'type': 'Pâtisseries',
      'quantity': '10 pièces',
      'image': null,
    },
    {
      'donor': 'Restaurant Chez Paul',
      'type': 'Repas',
      'quantity': '15 portions',
      'image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des dons'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              // TODO: Implémenter la fonctionnalité de filtre
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _donations.length,
        itemBuilder: (context, index) {
          return _buildDonationCard(_donations[index]);
        },
      ),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Icon(Icons.fastfood, color: Colors.green),
        ),
        title: Text(
          donation['type'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(donation['donor']),
            SizedBox(height: 4),
            Text('Quantité: ${donation['quantity']}'),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Naviguer vers les détails du don
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filtrer les dons'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ajoutez vos options de filtre ici
              ListTile(
                title: Text('Tous les dons'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Nourriture fraîche'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Produits secs'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}