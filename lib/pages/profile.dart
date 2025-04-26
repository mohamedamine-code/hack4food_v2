import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour le formatage des dates

class DonorProfileScreen extends StatelessWidget {
  final List<Donation> donations = [
    Donation(
      id: '1',
      foodType: 'Fruits et Légumes',
      quantity: '5 kg',
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Collecté',
      association: 'Resto du Cœur',
    ),
    Donation(
      id: '2',
      foodType: 'Produits Secs',
      quantity: '10 boîtes',
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: 'Distribué',
      association: 'Banque Alimentaire',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil Donneur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigation vers les paramètres
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(),
            const SizedBox(height: 24),
            const Text(
              'Mes Dons Récents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDonationsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation vers le formulaire de nouveau don
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildUserInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jean Dupont',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Membre depuis ${DateFormat.yMMM().format(DateTime.now().subtract(const Duration(days: 365)))}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(Icons.fastfood, '${donations.length} Dons'),
                    const SizedBox(width: 8),
                    
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(20),
        color: Colors.green,
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildDonationsList() {
    if (donations.isEmpty) {
      return const Center(
        child: Text('Aucun don enregistré'),
          );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.fastfood, color: Colors.green),
            ),
            title: Text(donation.foodType),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Quantité: ${donation.quantity}'),
                Text('Association: ${donation.association}'),
                Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(donation.date)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: _buildStatusBadge(donation.status),
            onTap: () {
              // Navigation vers les détails du don
            },
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'collecté':
        backgroundColor = Colors.orange[100]!;
        break;
      case 'distribué':
        backgroundColor = Colors.green[100]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Donation {
  final String id;
  final String foodType;
  final String quantity;
  final DateTime date;
  final String status;
  final String association;

  Donation({
    required this.id,
    required this.foodType,
    required this.quantity,
    required this.date,
    required this.status,
    required this.association,
  });
}