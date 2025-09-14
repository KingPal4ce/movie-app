import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/core/presentation/app_router.dart';

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const <PageRouteInfo>[
        HomeRoute(),
        MoviesRoute(),
        SearchRoute(),
        SettingsRoute(),
      ],
      builder: (BuildContext context, Widget child) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);

        return SafeArea(
          child: Scaffold(
            body: child,
            bottomNavigationBar: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: GNav(
                  tabBackgroundColor: Theme.of(context).colorScheme.surface,
                  gap: 8,
                  padding: const EdgeInsets.all(16),
                  selectedIndex: tabsRouter.activeIndex,
                  onTabChange: tabsRouter.setActiveIndex,
                  color: Colors.grey.shade400,
                  textStyle: GoogleFonts.poppins(color: Theme.of(context).colorScheme.inversePrimary),
                  tabs: <GButton>[
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    GButton(
                      icon: Icons.movie,
                      text: 'Movies',
                      iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                      iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'Settings',
                      iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
