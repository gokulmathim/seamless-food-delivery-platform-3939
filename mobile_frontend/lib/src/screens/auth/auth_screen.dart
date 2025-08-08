import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

// PUBLIC_INTERFACE
/// Authentication screen for login and registration.
class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _name = "";
  bool _loading = false;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _loading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = false;

    if (_isLogin) {
      success = await authProvider.login(_email, _password);
    } else {
      success = await authProvider.register(_name, _email, _password);
    }

    setState(() {
      _loading = false;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Auth failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use consistent theming for orange throughout
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      _isLogin ? "Login" : "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('name'),
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: (v) => (v == null || v.isEmpty) ? "Enter your name" : null,
                        onSaved: (val) => _name = val ?? "",
                      ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('email'),
                      decoration: const InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || !v.contains('@')) ? "Invalid email" : null,
                      onSaved: (val) => _email = val ?? "",
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (v) => (v == null || v.length < 6) ? "Min 6 chars" : null,
                      onSaved: (val) => _password = val ?? "",
                    ),
                    const SizedBox(height: 24),
                    _loading
                        ? const CircularProgressIndicator(
                            color: Color(0xFFFFA500),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              child: Text(_isLogin ? "Login" : "Register"),
                            ),
                          ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _toggleForm,
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: Text(_isLogin
                          ? "Don't have an account? Sign Up"
                          : "Already registered? Login"),
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
}
