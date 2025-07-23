import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro_bootcamp_project/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_intro_bootcamp_project/features/movie/presentation/screens/movies_screen.dart';
import 'package:flutter_intro_bootcamp_project/features/search/presentation/screens/search_screen.dart';
import 'package:flutter_intro_bootcamp_project/features/settings/presentation/screens/settings_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

@RoutePage()
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() => _selectedIndex = index);
  }

  final List<Widget> _screens = <Widget>[HomeScreen(), MoviesScreen(), SearchScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              tabBackgroundColor: Theme.of(context).colorScheme.surface,
              gap: 8,
              padding: EdgeInsets.all(16),
              onTabChange: _navigateBottomBar,
              color: Colors.white,
              tabs: const <GButton>[
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.movie, text: 'Movies'),
                GButton(icon: Icons.search, text: 'Search'),
                GButton(icon: Icons.settings, text: 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
