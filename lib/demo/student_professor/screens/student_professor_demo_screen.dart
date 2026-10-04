import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'student_selection_screen.dart';

class StudentProfessorDemoScreen extends StatefulWidget {
  const StudentProfessorDemoScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfessorDemoScreen> createState() =>
      _StudentProfessorDemoScreenState();
}

class _StudentProfessorDemoScreenState extends State<StudentProfessorDemoScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LamCode Student-Professor Demo'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: _selectedIndex == 0
          ? const StudentSelectionScreen()
          : const ProfessorPlaceholder(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Professor',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class ProfessorPlaceholder extends StatelessWidget {
  const ProfessorPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics,
            size: 80,
            color: AppTheme.primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'Professor Analytics',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Coming Soon in Part 2\n\nView student learning records and analytics.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
