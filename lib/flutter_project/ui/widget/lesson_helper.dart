//ui/widget/lesson_helper.dart
import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';

String moodEmoji(Mood mood) {
  switch (mood) {
    case Mood.okay:
      return '😌';
    case Mood.happy:
      return '😊';
    case Mood.stressed:
      return '😖';
    case Mood.sad:
      return '😢';
    case Mood.angry:
      return '😡';
  }
}

String categoryLabel(LessonCategory category) {
  switch (category) {
    case LessonCategory.workStudy:
      return 'Work / Study';
    case LessonCategory.personalGrowth:
      return 'Personal Growth';
    case LessonCategory.relationshipsCommunication:
      return 'Relationships';
    case LessonCategory.healthWellBeing:
      return 'Health & Well-being';
    case LessonCategory.mistakesSelfControl:
      return 'Mistakes & Self-Control';
  }
}

IconData categoryIcon(LessonCategory category) {
  switch (category) {
    case LessonCategory.workStudy:
      return Icons.work; 

    case LessonCategory.personalGrowth:
      return Icons.eco; 

    case LessonCategory.relationshipsCommunication:
      return Icons.favorite; 

    case LessonCategory.healthWellBeing:
      return Icons.local_florist; 

    case LessonCategory.mistakesSelfControl:
      return Icons.self_improvement; 
  }
}

Color categoryColor(LessonCategory category) {
  switch (category) {
    case LessonCategory.workStudy:
      return const Color(0xFF5B8DEF);
    case LessonCategory.personalGrowth:
      return const Color(0xFF4CAF93);
    case LessonCategory.relationshipsCommunication:
      return const Color(0xFFE57373);
    case LessonCategory.healthWellBeing:
      return const Color(0xFF81C784);
    case LessonCategory.mistakesSelfControl:
      return const Color(0xFFFFB74D);
  }
}

String formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

Color categoryCardColor(LessonCategory category) {
  switch (category) {
    case LessonCategory.personalGrowth:
      return const Color(0xFFECF8F5);

    case LessonCategory.workStudy:
      return const Color(0xFFEEF0FD);

    case LessonCategory.relationshipsCommunication:
      return const Color(0xFFFCEFF3);

    case LessonCategory.healthWellBeing:
      return const Color(0xFFEFF9F2);

    case LessonCategory.mistakesSelfControl:
      return const Color(0xFFFFF6E5);
  }
}
