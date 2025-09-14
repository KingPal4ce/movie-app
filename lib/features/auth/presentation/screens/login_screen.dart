import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/core/presentation/widgets/my_button.dart';
import 'package:movie_app/core/presentation/widgets/my_loading_indicator.dart';
import 'package:movie_app/features/auth/data/models/app_user.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_bloc.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_states.dart';
import 'package:movie_app/features/auth/presentation/widgets/google_button.dart';
import 'package:movie_app/features/auth/presentation/widgets/my_divider.dart';
import 'package:movie_app/features/auth/presentation/widgets/my_text_field.dart';
import 'package:movie_app/features/auth/presentation/widgets/toggle_screens.dart';

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

  late AuthBloc authBloc;

  @override
  void initState() {
    // auth bloc
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

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

    FocusScope.of(context).unfocus();

    try {
      authBloc.login(_emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(listener: (BuildContext context, AuthStates state) {
      state.maybeWhen(
        authenticated: (AppUser? user) => context.router.replace(const NavigationRoute()),
        error: (String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))),
        orElse: () {},
      );
    }, builder: (BuildContext context, AuthStates state) {
      return SafeArea(
        child: Scaffold(
          body: state.maybeWhen(
            loading: () => MyLoadingIndicator(),
            orElse: () => Center(
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

                        Text('WELCOME!', style: GoogleFonts.bebasNeue(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 45)),

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
                        MyDivider(),

                        const SizedBox(height: 25),

                        // GOOGLE LOGIN BUTTON
                        GoogleButton(
                          onTap: () {
                            try {
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
          ),
          // BOTTOM NAV BAR
          bottomNavigationBar: ToggleScreens(onTap: widget.togglePages, text: 'Not a member? ', toggleText: 'Sign Up'),
        ),
      );
    });
  }
}
