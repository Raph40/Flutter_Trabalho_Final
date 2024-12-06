import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String uid = userCredential.user!.uid;

        DocumentSnapshot lastMemberDoc = await FirebaseFirestore.instance.collection('members').doc('last_member').get();

        int numSocio = 4;
        if (lastMemberDoc.exists) {
          numSocio = lastMemberDoc['num_socio'] + 1;
        }

        await FirebaseFirestore.instance.collection('members').doc('last_member').set({
          'num_socio': numSocio,
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': _emailController.text,
          'name': _nameController.text,
          'num_socio': numSocio,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Utilizador registado com sucesso! Número de sócio: $numSocio')));

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
              "Registar",
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
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Crie sua conta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Registar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[100] : Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
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
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.red[900],
                      ),
                      child: Text(
                        'Registar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Já tem uma conta? Faça login',
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
    _nameController.dispose();
    super.dispose();
  }
}
