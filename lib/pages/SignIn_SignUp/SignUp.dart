import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final String userType; // 'donor' ou 'association'

  const SignUp({super.key, required this.userType});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _responsibleNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _organizationController.dispose();
    _responsibleNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text(widget.userType == 'association' ? 'Inscription Association' : 'Inscription Donneur'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Icon(Icons.eco, size: 100, color: Colors.green.shade800),
              const SizedBox(height: 20),
              Text(
                    widget.userType == 'association'
                        ? 'Enregistrement Association'
                        : 'Enregistrement Donneur',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
              _buildFormFields(),
              const SizedBox(height: 30),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    if (widget.userType == 'association') {
      // Form for Association
      return Column(
        children: [
          _buildTextField(controller: _organizationController, label: "Nom de l'association", icon: Icons.business),
          const SizedBox(height: 20),
          _buildTextField(controller: _responsibleNameController, label: "Nom du Responsable", icon: Icons.person),
          const SizedBox(height: 20),
          _buildTextField(controller: _emailController, label: "Email", icon: Icons.email, isEmail: true),
          const SizedBox(height: 20),
          _buildTextField(controller: _passwordController, label: "Mot de passe", icon: Icons.lock, isPassword: true),
        ],
      );
    } else {
      // Form for Donor
      return Column(
        children: [
          _buildTextField(controller: _firstNameController, label: "Prénom", icon: Icons.person_outline),
          const SizedBox(height: 20),
          _buildTextField(controller: _lastNameController, label: "Nom", icon: Icons.person),
          const SizedBox(height: 20),
          _buildTextField(controller: _emailController, label: "Email", icon: Icons.email, isEmail: true),
          const SizedBox(height: 20),
          _buildTextField(controller: _passwordController, label: "Mot de passe", icon: Icons.lock, isPassword: true),
        ],
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green.shade700),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.green.shade700,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez remplir ce champ';
        }
        if (isEmail && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        if (isPassword && value.length < 6) {
          return 'Mot de passe minimum 6 caractères';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // You can handle the signup process here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inscription réussie')),
            );
            Navigator.pop(context); // or navigate to dashboard
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'S\'INSCRIRE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
