import 'package:flutter/material.dart';
import '../../model/life_lesson.dart';
import '../../model/action_plan.dart';
import '../widget/action_plan_section.dart';
import '../widget/dropdowns.dart';
import '../widget/input_card.dart';
import '../../model/life_lesson_control.dart';
import 'all_lesson_page.dart';

class CreateLifeLessonPage extends StatefulWidget {
  final LifeLessonControl allLessons;
  final LifeLesson? lesson;
  
  const CreateLifeLessonPage({
    super.key,
    required this.allLessons,
    this.lesson,
  });

  @override
  State<CreateLifeLessonPage> createState() => _CreateLifeLessonPageState();
}

class _CreateLifeLessonPageState extends State<CreateLifeLessonPage> {
  final _titleController = TextEditingController();
  final _happenedController = TextEditingController();
  final _learnedController = TextEditingController();
  final _actionPlanController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  LessonCategory _selectedCategory = LessonCategory.personalGrowth;
  Mood _selectedMood = Mood.okay;
  bool _isFavorite = false;
  bool _hasActionPlan = false;
  bool _isActionComplete = false;
  late final bool _isEditMode;
  late LifeLesson? _originalLesson;

  @override
  void initState() {
    super.initState();

    _isEditMode = widget.lesson != null;

    if (_isEditMode) {
      final l = widget.lesson!;
      _originalLesson = l; 

      _titleController.text = l.title;
      _happenedController.text = l.happened;
      _learnedController.text = l.learned;
      _selectedDate = l.date;
      _isFavorite = l.isFavorite ?? false;
      _selectedCategory = l.category;
      _selectedMood = l.mood;

      if (l.actionPlan != null) {
        _hasActionPlan = true;
        _actionPlanController.text = l.actionPlan!.actionText;
        _isActionComplete = l.actionPlan!.isComplete;
      }
    }
  }

  bool _hasChanges() {
    if (!_isEditMode) return true;

    final o = _originalLesson!;

    return o.title != _titleController.text.trim() ||
        o.happened != _happenedController.text.trim() ||
        o.learned != _learnedController.text.trim() ||
        o.date != _selectedDate ||
        o.isFavorite != _isFavorite ||
        o.category != _selectedCategory ||
        o.mood != _selectedMood ||
        (o.actionPlan?.actionText ?? '') != _actionPlanController.text.trim() ||
        (o.actionPlan?.isComplete ?? false) != _isActionComplete;
  }

  void _saveLesson() {
    if (_titleController.text.trim().isEmpty ||
        _happenedController.text.trim().isEmpty ||
        _learnedController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Incomplete Lesson'),
          content: Text('Please complete all required fields'),
        ),
      );
      return;
    }
    if (_isEditMode && !_hasChanges()) {
      Navigator.pop(context);
      return;
    }

    ActionPlan? actionPlan;
    if (_hasActionPlan && _actionPlanController.text.trim().isNotEmpty) {
      actionPlan = ActionPlan(
        id: _isEditMode ? widget.lesson?.actionPlan?.id : null,
        actionText: _actionPlanController.text.trim(),
        createdAt: _isEditMode
            ? widget.lesson?.actionPlan?.createdAt ?? DateTime.now()
            : DateTime.now(),
        isComplete: _isEditMode ? _isActionComplete : false,
      );
    }

    final lesson = LifeLesson(
      id: _isEditMode ? widget.lesson!.id : null, 
      title: _titleController.text.trim(),
      happened: _happenedController.text.trim(),
      learned: _learnedController.text.trim(),
      date: _selectedDate,
      isFavorite: _isFavorite,
      category: _selectedCategory,
      mood: _selectedMood,
      actionPlan: actionPlan,
    );

    if (_isEditMode) {
      widget.allLessons.editLesson(lesson);
    } else {
      widget.allLessons.addLesson(lesson);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => AllLessonsPage(allLessons: widget.allLessons),
      ),
      (_) => false,
    );
  }

  Future<void> _pickLessonDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC7DEFC),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'New Life Lesson',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 40),
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            InputCard(
              label: 'Lesson Title',
              controller: _titleController,
              hint: 'What did you learn from this experience?',
            ),
            DateField(selectedDate: _selectedDate, onTap: _pickLessonDate),
            InputCard(
              label: 'What happened?',
              controller: _happenedController,
              hint: 'Describe what happened...',
              maxLines: 3,
            ),
            InputCard(
              label: 'What did you learn?',
              controller: _learnedController,
              hint: 'Write down the lesson you learned...',
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CategoryDropdown(
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: MoodDropdown(
                    value: _selectedMood,
                    onChanged: (value) {
                      setState(() {
                        _selectedMood = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ActionPlanSection(
              controller: _actionPlanController,
              hasActionPlan: _hasActionPlan,
              isComplete: _isActionComplete,
              isEditMode: _isEditMode,

              onAdd: () {
                if (_hasActionPlan) return; 
                setState(() {
                  _hasActionPlan = true;
                  _isActionComplete = false;
                });
              },

              onCheck: (value) {
                setState(() {
                  _isActionComplete = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: _saveLesson,
                child: Text(
                  widget.lesson == null ? 'Create Lesson' : 'Save Changes',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
