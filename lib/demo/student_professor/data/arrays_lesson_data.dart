class ArraysLesson {
  static const String title = 'Arrays';
  static const String description = 'Learn the fundamentals of arrays in computer science';

  static const List<LessonSection> sections = [
    LessonSection(
      title: 'What is an Array?',
      content:
          'An array is a collection of elements stored in contiguous memory locations. '
          'It is one of the most fundamental data structures in computer science. '
          'Arrays allow you to store multiple values of the same type in a single variable.',
    ),
    LessonSection(
      title: 'Indexing',
      content:
          'Arrays use zero-based indexing, meaning the first element is at index 0. '
          'If an array has n elements, the valid indices are 0 to n-1. '
          'This is a convention used in most programming languages.',
    ),
    LessonSection(
      title: 'Accessing Elements',
      content:
          'To access an element in an array, use its index in square brackets. '
          'Example: array[0] gives the first element, array[5] gives the sixth element. '
          'Accessing an element takes O(1) time—constant time!',
    ),
    LessonSection(
      title: 'Basic Operations',
      content:
          'Common array operations include: Insert (add element), Delete (remove element), '
          'Search (find element), and Update (modify element). '
          'Each operation has different time complexity depending on where the operation occurs.',
    ),
    LessonSection(
      title: 'Time Complexity',
      content:
          'Access: O(1) - instant if you know the index. '
          'Search: O(n) - may need to check every element. '
          'Insert: O(n) - may need to shift elements. '
          'Delete: O(n) - may need to shift elements. '
          'Understanding complexity helps you write efficient code.',
    ),
  ];
}

class LessonSection {
  final String title;
  final String content;

  const LessonSection({
    required this.title,
    required this.content,
  });
}
