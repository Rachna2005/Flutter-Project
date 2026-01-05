import 'package:flutter/material.dart';

class ActionPlanSection extends StatelessWidget {
  final TextEditingController controller;
  final bool hasActionPlan;
  final bool isComplete;
  final VoidCallback onAdd;
  final ValueChanged<bool> onCheck;
  final bool isEditMode;

  const ActionPlanSection({
    super.key,
    required this.controller,
    required this.hasActionPlan,
    required this.isComplete,
    required this.isEditMode,
    required this.onAdd,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onAdd,
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Next Time, I Will...'),
                ],
              ),
            ),

            if (hasActionPlan) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: isComplete,
                    onChanged: isEditMode ? (v) => onCheck(v!) : null,
                  ),
                  Expanded(child: TextField(controller: controller)),
                ],
              ),
            ],
            const SizedBox(height: 6),
            const Text(
              'Optional — turn this lesson into an action.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
