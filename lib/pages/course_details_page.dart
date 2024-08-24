
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/blocs/course/course_bloc.dart';
import 'package:project2/models/course.dart';
import 'package:project2/widgets/Course_options_widget.dart';
import 'package:project2/widgets/lecture_chips.dart';
import 'package:video_box/video_box.dart';

class CourseDetailsPage extends StatefulWidget {
  static const String id = 'course_details';
  final Course course;
  const CourseDetailsPage({required this.course, super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  double? height;

  @override
  void initState() {
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocBuilder<CourseBloc, CourseState>(builder: (ctx, state) {
          if (state is! LectureState) return const SizedBox();
          var stateEx = state is LectureChosenState ? state : null;
          return SizedBox(
            height: 250,
            child: VideoBox(
              controller: VideoController(
                  source: VideoPlayerController.networkUrl(
                      Uri.parse(stateEx!.lecture.lecture_url!))),
            ),
          );
        }),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<CourseBloc, CourseState>(
            buildWhen: (previous, current) => current is LectureState,
            builder: (context, state) {
            //  var applyChanges = (state is LectureChosenState) ? true : false;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.course.title ?? 'No Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.course.instructor?.name ??
                            'No Instructor Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: BlocBuilder<CourseBloc, CourseState>(
                            buildWhen: (previous, current) => true,
                            builder: (ctx, state) {
                              print('>>>>>>>>build ${state}');
                              return Column(
                                children: [
                                  LectureChipsWidget(
                                    selectedOption:
                                        (state is CourseOptionStateChanges)
                                            ? state.courseOption
                                            : null,
                                    onChanged: (courseOption) {
                                      context.read<CourseBloc>().add(
                                          CourseOptionChosenEvent(
                                              courseOption));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                      child: (state
                                              is CourseOptionStateChanges)
                                          ? CourseOptionsWidgets(
                                              course: context
                                                  .read<CourseBloc>()
                                                  .course!,
                                              courseOption:
                                                  state.courseOption,
                                              onLectureChosen: (lecture) {
                                                context
                                                    .read<CourseBloc>()
                                                    .add(LectureChosenEvent(
                                                        lecture));
                                              },
                                            )
                                          : const SizedBox.shrink())
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
