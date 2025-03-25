import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/presentation/widgets/google_button.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/my_button.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/presentation/widgets/toggle_screens.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.togglePages});

  final void Function()? togglePages;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final bool isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    // auth bloc
    final AuthBloc authBloc = context.read<AuthBloc>();

    FocusScope.of(context).unfocus();

    try {
      authBloc.login(_emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // LOGO
                    Icon(Icons.account_circle_rounded, size: 120, color: Theme.of(context).colorScheme.inversePrimary),

                    SizedBox(height: 30),

                    Text('WELCOME', style: GoogleFonts.bebasNeue(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 45)),

                    Text("Login to Continue", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20)),

                    SizedBox(height: 25),

                    // EMAIL TEXTFIELD
                    MyTextField(
                      textController: _emailController,
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.mail),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      contentType: ContentType.email,
                    ),
                    const SizedBox(height: 10),

                    // PASSWORD TEXTFIELD
                    MyTextField(
                      textController: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      validator: (String? value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      contentType: ContentType.password,
                    ),

                    const SizedBox(height: 10),

                    // SIGN IN BUTTON
                    MyButton(text: 'Sign In', onTap: _submit),

                    const SizedBox(height: 25),

                    // OTHER AUTH DIVIDER
                    Row(
                      children: <Widget>[
                        Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
                        const SizedBox(width: 5),
                        Text('Or Continue with', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        const SizedBox(width: 5),
                        Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // GOOGLE LOGIN BUTTON
                    GoogleButton(
                      onTap: () {
                        try {
                          final AuthBloc authBloc = context.read<AuthBloc>();
                          authBloc.googleLogin();
                        } catch (e) {
                          throw Exception('$e');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // BOTTOM NAV BAR
        bottomNavigationBar: ToggleScreens(onTap: widget.togglePages, text: 'Not a member? ', toggleText: 'Sign Up'),
      ),
    );
  }
}
