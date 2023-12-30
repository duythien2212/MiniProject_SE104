import 'package:flutter/material.dart';
import 'package:new_project/models/class.dart';
import 'package:new_project/screens/quizList/createClassScreen.dart';
import 'package:new_project/data/classes.dart';
import 'package:new_project/screens/quizList/quizListScreen.dart';
import 'package:new_project/utils/app_styles.dart';

class SelectClassScreen extends StatefulWidget {
  const SelectClassScreen({super.key, required this.setScreen});
  final void Function(Widget screen) setScreen;

  @override
  State<StatefulWidget> createState() {
    return _SelectClassScreen();
  }
}

class _SelectClassScreen extends State<SelectClassScreen> {
  void addClass(Class newClass) {
    setState(() {
      classes.add(newClass);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: width,
            height: height - 100,
            child: ListView(
              children: [
                for (var lop in classes)
                  TextButton(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${lop.classID} - ${lop.className}',
                            style: const TextStyle(
                                fontSize: 20, color: AppThemes.headingColor),
                          ),
                          Text('Teacher: ${lop.teacherID}'),
                        ],
                      ),
                    ),
                    onPressed: () {
                      widget.setScreen(QuizListScreen(
                        selectedClass: lop,
                        setScreen: widget.setScreen,
                      ));
                    },
                  )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Create new class',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Text(
                        'Import a class or create a new class',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Import'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => CreateClassScreen(
                                addClass: addClass,
                              ),
                            );
                          },
                          child: const Text('Create'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Create Class',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ],
          )
        ],
      ),
    );
  }
}
