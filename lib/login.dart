import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'registo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login bem-sucedido! Bem-vindo, ${userData['name']}')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyGymApp()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário não encontrado no banco de dados.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erro ao fazer login')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Manter a altura original do AppBar
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Login",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Bem-vindo/a!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[100] : Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Insira um endereço de email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _loginUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.red[900],
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        'Não tem uma conta? Registe-se',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.red[900],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
