import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../models/demo_student.dart';
import 'arrays_lesson_screen.dart';

class StudentDashboardScreen extends StatelessWidget {
  final DemoStudent student;

  const StudentDashboardScreen({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student.name}\'s Dashboard'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Profile',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                student.name[student.name.length - 1],
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                student.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Topics Section
              Text(
                'Topics',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Arrays Topic (Active)
              TopicCard(
                title: 'Arrays',
                status: 'Demo',
                description: 'Learn the fundamentals of arrays',
                icon: Icons.list,
                isActive: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArraysLessonScreen(
                        student: student,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Linked Lists Topic (Coming Soon)
              TopicCard(
                title: 'Linked Lists',
                status: 'Coming Soon',
                description: 'Master linked list data structures',
                icon: Icons.link,
                isActive: false,
              ),
              const SizedBox(height: 12),

              // Stacks Topic (Coming Soon)
              TopicCard(
                title: 'Stacks',
                status: 'Coming Soon',
                description: 'Understand LIFO data structures',
                icon: Icons.layers,
                isActive: false,
              ),
              const SizedBox(height: 12),

              // Queues Topic (Coming Soon)
              TopicCard(
                title: 'Queues',
                status: 'Coming Soon',
                description: 'Learn FIFO data structures',
                icon: Icons.queue,
                isActive: false,
              ),
              const SizedBox(height: 12),

              // Trees Topic (Coming Soon)
              TopicCard(
                title: 'Trees',
                status: 'Coming Soon',
                description: 'Explore hierarchical data structures',
                icon: Icons.account_tree,
                isActive: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final String status;
  final String description;
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  const TopicCard({
    Key? key,
    required this.title,
    required this.status,
    required this.description,
    required this.icon,
    required this.isActive,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 4 : 1,
      child: InkWell(
        onTap: isActive ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.primaryColor.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  icon,
                  color: isActive
                      ? AppTheme.primaryColor
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.black : Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isActive ? Colors.grey : Colors.grey[400],
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.primaryColor.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppTheme.primaryColor
                            : Colors.grey.withOpacity(0.7),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
