import 'package:fitness_admin_project/ui/views/deshbord_screen.dart';
import 'package:fitness_admin_project/ui/views/quiz_category_screen.dart';
import 'package:fitness_admin_project/ui/views/quiz_data.dart';
import 'package:fitness_admin_project/ui/views/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List currentScreen = [
    const DashboardScreen(),
    QuizCategoryScreen(),
     UsersScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFFFCFCFC),
        title: Row(
          children: const [
            Icon(Icons.dashboard, color: Colors.black),
            SizedBox(width: 6),
            Text(
              "Fitness Admin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:70.0),
            child: Center(
              child: NavigationRail(
                selectedIndex: _selectedIndex,
               // extended: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.white,
                destinations: const <NavigationRailDestination>[
                  // navigation destinations
                  NavigationRailDestination(
                    icon: Icon(Icons.add_home),
                    // selectedIcon: Icon(Icons.favorite),
                    label: Text('Add New Item'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    // selectedIcon: Icon(Icons.quiz),
                    label: Text('Quiz'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people),
                    // selectedIcon: Icon(Icons.quiz),
                    label: Text('All Users'),
                  ),
                ],
                selectedIconTheme: const IconThemeData(color: Colors.black),
                unselectedIconTheme: const IconThemeData(color: Colors.black54),
                selectedLabelTextStyle: const TextStyle(color: Colors.black),
                unselectedLabelTextStyle: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
          Expanded(child: currentScreen[_selectedIndex])
        ],
      ),
    );
  }
}
