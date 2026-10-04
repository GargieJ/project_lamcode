import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_theme.dart';
import '../models/student_learning_record.dart';
import '../repository/student_analytics_repository.dart';
import 'student_detail_screen.dart';

class ProfessorDashboardScreen extends StatefulWidget {
  const ProfessorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ProfessorDashboardScreen> createState() =>
      _ProfessorDashboardScreenState();
}

class _ProfessorDashboardScreenState extends State<ProfessorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professor Analytics'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Consumer<StudentAnalyticsRepository>(
        builder: (context, repository, _) {
          final records = repository.getAllRecords();
          final metrics = _calculateMetrics(records);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetricsGrid(context, metrics),
                  const SizedBox(height: 32),
                  if (records.isNotEmpty) ...[_buildTopPerformersSection(context, records)],
                  if (records.isNotEmpty) const SizedBox(height: 32),
                  if (records.isNotEmpty) ...[_buildTimeSpentSection(context, records)],
                  if (records.isNotEmpty) const SizedBox(height: 32),
                  if (records.isNotEmpty) ...[_buildChartsSection(context, records)],
                  if (records.isNotEmpty) const SizedBox(height: 32),
                  _buildStudentPerformanceTable(context, records),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricsGrid(
    BuildContext context,
    Map<String, dynamic> metrics,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MetricCard(
              label: 'Total Students',
              value: metrics['totalStudents'].toString(),
              icon: Icons.people,
            ),
            MetricCard(
              label: 'Completed',
              value: metrics['completedStudents'].toString(),
              icon: Icons.check_circle,
            ),
            MetricCard(
              label: 'Completion Rate',
              value: '${metrics['completionRate'].toStringAsFixed(1)}%',
              icon: Icons.trending_up,
            ),
            MetricCard(
              label: 'Avg Score',
              value: metrics['averageScore'].toStringAsFixed(1),
              icon: Icons.score,
            ),
            MetricCard(
              label: 'Avg Accuracy',
              value: '${metrics['averageAccuracy'].toStringAsFixed(1)}%',
              icon: Icons.percent,
            ),
            MetricCard(
              label: 'Total Hours',
              value: metrics['totalHours'].toStringAsFixed(1),
              icon: Icons.schedule,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopPerformersSection(
    BuildContext context,
    List<StudentLearningRecord> records,
  ) {
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    final topPerformer = records.reduce(
      (a, b) => a.accuracy > b.accuracy ? a : b,
    );
    final lowestPerformer = records.reduce(
      (a, b) => a.accuracy < b.accuracy ? a : b,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Highlights',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: HighlightCard(
                title: 'Highest Performer',
                studentName: topPerformer.studentName,
                value: '${topPerformer.accuracy.toStringAsFixed(1)}%',
                icon: Icons.star,
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HighlightCard(
                title: 'Lowest Performer',
                studentName: lowestPerformer.studentName,
                value: '${lowestPerformer.accuracy.toStringAsFixed(1)}%',
                icon: Icons.sentiment_dissatisfied,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSpentSection(
    BuildContext context,
    List<StudentLearningRecord> records,
  ) {
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    final mostTime = records.reduce(
      (a, b) => a.timeSpentSeconds > b.timeSpentSeconds ? a : b,
    );
    final leastTime = records.reduce(
      (a, b) => a.timeSpentSeconds < b.timeSpentSeconds ? a : b,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time Analysis',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: HighlightCard(
                title: 'Most Time Spent',
                studentName: mostTime.studentName,
                value: _formatTime(mostTime.timeSpentSeconds),
                icon: Icons.hourglass_full,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HighlightCard(
                title: 'Least Time Spent',
                studentName: leastTime.studentName,
                value: _formatTime(leastTime.timeSpentSeconds),
                icon: Icons.hourglass_bottom,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartsSection(
    BuildContext context,
    List<StudentLearningRecord> records,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visual Analytics',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score by Student',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildBarChart(records, (r) => r.score, 'Score'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accuracy by Student',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildBarChart(records, (r) => r.accuracy, 'Accuracy'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time Spent by Student',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildBarChart(records, (r) => r.timeSpentSeconds.toDouble(), 'Time'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(
    List<StudentLearningRecord> records,
    double Function(StudentLearningRecord) getValue,
    String label,
  ) {
    final barRecords = <String, StudentLearningRecord>{};
    for (final record in records) {
      if (!barRecords.containsKey(record.studentId) ||
          barRecords[record.studentId]!.timestamp.isBefore(record.timestamp)) {
        barRecords[record.studentId] = record;
      }
    }

    final latestRecords = barRecords.values.toList();
    final maxValue = latestRecords.map(getValue).reduce((a, b) => a > b ? a : b);

    return Column(
      children: latestRecords.map((record) {
        final value = getValue(record);
        final percentage = maxValue == 0 ? 0.0 : (value / maxValue) * 100;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    record.studentName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    label == 'Time'
                        ? _formatTime(record.timeSpentSeconds)
                        : value.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStudentPerformanceTable(
    BuildContext context,
    List<StudentLearningRecord> records,
  ) {
    final recordsByStudent = <String, StudentLearningRecord>{};
    for (final record in records) {
      if (!recordsByStudent.containsKey(record.studentId) ||
          recordsByStudent[record.studentId]!.timestamp
              .isBefore(record.timestamp)) {
        recordsByStudent[record.studentId] = record;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Student Performance',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        if (recordsByStudent.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No student records yet',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
          )
        else
          Card(
            elevation: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Student')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Score')),
                  DataColumn(label: Text('Accuracy')),
                  DataColumn(label: Text('Status')),
                ],
                rows: recordsByStudent.values.map((record) {
                  return DataRow(
                    onSelectChanged: (_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => StudentDetailScreen(record: record),
                        ),
                      );
                    },
                    cells: [
                      DataCell(Text(record.studentName)),
                      DataCell(Text(_formatTime(record.timeSpentSeconds))),
                      DataCell(
                          Text('${record.correctAnswers}/${record.totalQuestions}')),
                      DataCell(Text('${record.accuracy.toStringAsFixed(1)}%')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: record.completed
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            record.completed ? 'Completed' : 'Not Completed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: record.completed
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }

  Map<String, dynamic> _calculateMetrics(List<StudentLearningRecord> records) {
    if (records.isEmpty) {
      return {
        'totalStudents': 0,
        'completedStudents': 0,
        'completionRate': 0.0,
        'averageScore': 0.0,
        'averageAccuracy': 0.0,
        'totalHours': 0.0,
      };
    }

    final latestByStudent = <String, StudentLearningRecord>{};
    for (final record in records) {
      if (!latestByStudent.containsKey(record.studentId) ||
          latestByStudent[record.studentId]!.timestamp.isBefore(record.timestamp)) {
        latestByStudent[record.studentId] = record;
      }
    }

    final latestRecords = latestByStudent.values.toList();
    final completedStudents =
        latestRecords.where((record) => record.completed).length;

    final averageScore = latestRecords.isEmpty
        ? 0.0
        : latestRecords.fold<double>(0, (sum, record) => sum + record.score) /
            latestRecords.length;

    final averageAccuracy = latestRecords.isEmpty
        ? 0.0
        : latestRecords
                .fold<double>(0, (sum, record) => sum + record.accuracy) /
            latestRecords.length;

    final totalSeconds = latestRecords.fold<int>(
      0,
      (sum, record) => sum + record.timeSpentSeconds,
    );

    return {
      'totalStudents': latestRecords.length,
      'completedStudents': completedStudents,
      'completionRate': latestRecords.isEmpty
          ? 0.0
          : (completedStudents / latestRecords.length) * 100,
      'averageScore': averageScore,
      'averageAccuracy': averageAccuracy,
      'totalHours': totalSeconds / 3600,
    };
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes == 0) {
      return '${remainingSeconds}s';
    }
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const MetricCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppTheme.primaryColor.withOpacity(0.7), size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightCard extends StatelessWidget {
  final String title;
  final String studentName;
  final String value;
  final IconData icon;
  final Color color;

  const HighlightCard({
    Key? key,
    required this.title,
    required this.studentName,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              studentName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
