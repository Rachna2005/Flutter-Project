import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import 'lesson_helper.dart';

class CategoryDropdown extends StatelessWidget {
  final LessonCategory value;
  final ValueChanged<LessonCategory> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  // String _label(LessonCategory category) {
  //   switch (category) {
  //     case LessonCategory.personalGrowth:
  //       return 'Personal Growth';
  //     case LessonCategory.workStudy:
  //       return 'Work / Study';
  //     case LessonCategory.relationshipsCommunication:
  //       return 'Relationships';
  //     case LessonCategory.mistakesSelfControl:
  //       return 'Mistakes & Self-Control';
  //     case LessonCategory.healthWellBeing:
  //       return 'Health & Well-being';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label row
            Row(
              children: const [
                Icon(Icons.folder_open, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text('Category', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<LessonCategory>(
              value: value,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF3F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: LessonCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(categoryLabel(category)),
                );
              }).toList(),
              onChanged: (val) => onChanged(val!),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodDropdown extends StatelessWidget {
  final Mood value;
  final ValueChanged<Mood> onChanged;

  const MoodDropdown({super.key, required this.value, required this.onChanged});

  String _label(Mood mood) {
    switch (mood) {
      case Mood.okay:
        return '😌 Okay';
      case Mood.happy:
        return '😊 Happy';
      case Mood.stressed:
        return '😖 Stressed';
      case Mood.sad:
        return '😢 Sad';
      case Mood.angry:
        return '😡 Angry';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label row
            Row(
              children: const [
                Icon(Icons.mood, size: 18, color: Colors.grey),
                SizedBox(width: 6),
                Text('Mood', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<Mood>(
              value: value,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF3F7FD),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: Mood.values.map((mood) {
                return DropdownMenuItem(value: mood, child: Text(_label(mood)));
              }).toList(),
              onChanged: (val) => onChanged(val!),
            ),
          ],
        ),
      ),
    );
  }
}
