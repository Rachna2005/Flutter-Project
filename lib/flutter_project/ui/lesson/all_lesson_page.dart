import 'package:flutter/material.dart';
import '../../model/life_lesson_control.dart';
import '../../model/life_lesson.dart';
import '../widget/lesson_card.dart';
import 'life_lesson_detail.dart';
import '../widget/lesson_helper.dart';

class AllLessonsPage extends StatefulWidget {
  final LifeLessonControl allLessons;

  const AllLessonsPage({super.key, required this.allLessons});

  @override
  State<AllLessonsPage> createState() => _AllLessonsPageState();
}

class _AllLessonsPageState extends State<AllLessonsPage> {
  List<LifeLesson> _lessons = [];
  bool _loading = true;
  List<LifeLesson> _filteredLessons = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  @override
  void didUpdateWidget(covariant AllLessonsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    final data = await widget.allLessons.getLessons();
    if (!mounted) return;
    setState(() {
      _lessons = data;
      _loading = false;
      _filteredLessons = data;
    });
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLessons = _lessons;
      } else {
        _filteredLessons = _lessons.where((lesson) {
          final q = query.toLowerCase();
          return lesson.title.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Life Lessons'),
        backgroundColor: const Color(0xFFC7DEFC),
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearch,
                    decoration: InputDecoration(
                      hintText: 'Search lessons by title...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _lessons.isEmpty
                      ? const Center(
                          child: Text(
                            'No lessons yet.\nStart reflecting',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : _filteredLessons.isEmpty
                      ? const Center(
                          child: Text(
                            'No lessons found',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredLessons.length,
                          itemBuilder: (context, index) {
                            final lesson = _filteredLessons[index];

                            return GestureDetector(
                              onTap: () async {
                                final changed = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LessonDetailPage(
                                      lesson: lesson,
                                      allLessons: widget.allLessons,
                                    ),
                                  ),
                                );

                                if (changed == true) {
                                  await _loadLessons();
                                }
                              },
                              child: LessonCard(
                                key: ValueKey(lesson.id),
                                lesson: lesson,
                                color: categoryCardColor(lesson.category),

                                onFavorite: () async {
                                  setState(() {
                                    lesson.isFavorite =
                                        !(lesson.isFavorite ?? false);
                                  });
                                  await widget.allLessons.editLesson(lesson);
                                },

                                onDelete: () async {
                                  setState(() {
                                    _lessons.removeWhere(
                                      (l) => l.id == lesson.id,
                                    );
                                    _filteredLessons.removeWhere(
                                      (l) => l.id == lesson.id,
                                    );
                                  });
                                  await widget.allLessons.deleteLesson(
                                    lesson.id,
                                  );
                                },

                                onAction: (value) async {
                                  if (lesson.actionPlan == null ||
                                      value == null)
                                    return;
                                  setState(() {
                                    lesson.actionPlan!.isComplete = value;
                                  });
                                  await widget.allLessons.tapActionPlan(
                                    lesson.actionPlan!,
                                    value,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
