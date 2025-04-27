import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssociationProfileScreen extends StatelessWidget {
  final String associationName = "Resto du Cœur";
  final String location = "Paris, France";
  final String description = "Association d'aide alimentaire depuis 1985";
  final String contactEmail = "contact@restoducoeur.org";
  final String phoneNumber = "01 23 45 67 89";

  final List<Donation> distributedDonations = [
    Donation(
      id: '1',
      foodType: 'Fruits et Légumes',
      quantity: '5 kg',
      date: DateTime.now().subtract(const Duration(days: 2)),
      donorName: 'Jean Dupont',
      status: 'Distribué',
    ),
    Donation(
      id: '2',
      foodType: 'Produits Secs',
      quantity: '10 boîtes',
      date: DateTime.now().subtract(const Duration(days: 7)),
      donorName: 'Marie Martin',
      status: 'Distribué',
    ),
  ];

  AssociationProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Association'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAssociationHeader(),
            const SizedBox(height: 24),
            _buildContactInfo(),
            const SizedBox(height: 24),
            _buildDonationsHeader(),
            const SizedBox(height: 16),
            _buildDonationsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAssociationHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 16),
            Text(
              associationName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              location,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Coordonnées',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildContactItem(Icons.email, contactEmail),
            const SizedBox(height: 12),
            _buildContactItem(Icons.phone, phoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDonationsHeader() {
    return const Text(
      'Dons distribués',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDonationsList() {
    if (distributedDonations.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.fastfood, size: 50, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'Aucun don distribué pour le moment',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: distributedDonations.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildDonationCard(distributedDonations[index]);
      },
    );
  }

  Widget _buildDonationCard(Donation donation) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              donation.foodType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text('Quantité: ${donation.quantity}'),
            Text('Donné par: ${donation.donorName}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(donation.date),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                _buildStatusBadge(donation.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    // Navigation vers l'écran d'édition du profil
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAssociationProfileScreen(), // À implémenter
      ),
    );
  }
}

class Donation {
  final String id;
  final String foodType;
  final String quantity;
  final DateTime date;
  final String donorName;
  final String status;

  Donation({
    required this.id,
    required this.foodType,
    required this.quantity,
    required this.date,
    required this.donorName,
    required this.status,
  });
}

// À implémenter séparément
class EditAssociationProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le profil')),
      body: const Center(child: Text('Écran de modification du profil')),
    );
  }
}