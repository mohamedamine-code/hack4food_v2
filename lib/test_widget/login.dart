import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack_for_food/pages/SignUp.dart';
import 'package:hack_for_food/pages/routes_pages.dart';

class LoginScreen_01 extends StatefulWidget {
  final String userType; // 'donor' ou 'association'

  const LoginScreen_01({super.key, required this.userType});

  @override
  State<LoginScreen_01> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen_01> {
  bool isAssociation = false; // ou false
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (widget.userType == 'association') {
        Navigator.pushReplacementNamed(context, '/association-dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/donor-dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light eco green
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, size: 80, color: Colors.green.shade800),
                const SizedBox(height: 20),
                Text(
                  widget.userType == 'association'
                      ? 'Connexion Association'
                      : 'Connexion Donneur',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildLoginForm(),
                const SizedBox(height: 30),
                _buildSignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.userType == 'association')
            _buildTextField(
              controller: _organizationController,
              label: "Nom de l'association",
              icon: Icons.business,
              validatorMsg: "Veuillez entrer le nom de l'association",
            ),
          if (widget.userType == 'association') const SizedBox(height: 20),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            validatorMsg: 'Veuillez entrer un email valide',
            isEmail: true,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Mot de passe',
            icon: Icons.lock_outline,
            isPassword: true,
            validatorMsg: 'Mot de passe minimum 6 caractères',
          ),
          const SizedBox(height: 30),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String validatorMsg,
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
        suffixIcon:
            isPassword
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
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        if (isEmail &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        if (isPassword && value.length < 6) {
          return 'Mot de passe minimum 6 caractères';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            _isLoading
                ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                : GestureDetector(
                  onTap: (){
                    if (widget.userType == 'association'){
                      isAssociation=true;
                    }else{
                      isAssociation=false;
                    }
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> RoutesPages(
                      userType: isAssociation ? 'association' : 'donor',
                      
                    )));
                  },
                  child: const Text(
                    'SE CONNECTER',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
      ),
    );
  }

  Widget _buildSignUpText() {
    return Text.rich(
      TextSpan(
        text: 'Pas de compte ? ',
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: 'S\'inscrire',
            style: TextStyle(
              color: Colors.green.shade900,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    if (widget.userType == 'association'){
                      isAssociation=true;
                    }else{
                      isAssociation=false;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SignUp(
                              userType: isAssociation ? 'association' : 'donor',
                            ),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
