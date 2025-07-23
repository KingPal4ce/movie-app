import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/widgets/my_button.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: Column(
          children: <Widget>[
            Text('Author', style: GoogleFonts.bebasNeue(fontSize: 50)),
            ClipOval(child: Image.asset('assets/images/profile/profile.jpg', height: 180, width: 180, fit: BoxFit.cover)),
            const SizedBox(height: 15),
            Text('Ricketson Palacio', style: GoogleFonts.poppins(fontSize: 16)),
            Text('Mobile Developer Intern - Flutter', style: GoogleFonts.poppins(fontSize: 16)),
            Spacer(),
            MyButton(onTap: () => context.read<AuthBloc>().logout(), text: 'Logout'),
          ],
        ),
      ),
    );
  }
}
