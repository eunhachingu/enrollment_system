import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_school/models/application/application.dart';
import 'package:web_school/models/student/subject.dart';
import 'package:web_school/networks/student.dart';
import 'package:web_school/values/strings/colors.dart';
import 'package:web_school/views/widgets/body/wrapper/stream.dart';
import 'package:web_school/views/widgets/buttons/primary.dart';

@RoutePage()
class StudentWebEnrollmentScreen extends StatefulWidget {
  const StudentWebEnrollmentScreen({
    required this.applicationInfo,
    super.key,
  });

  final ApplicationInfo applicationInfo;

  @override
  State<StudentWebEnrollmentScreen> createState() =>
      _StudentWebEnrollmentScreenState();
}

class _StudentWebEnrollmentScreenState
    extends State<StudentWebEnrollmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final StudentDB studentDB = Provider.of<StudentDB>(context, listen: false);
      studentDB.updateListSubjectStream(widget.applicationInfo.userModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final StudentDB studentDB = Provider.of<StudentDB>(context);
    final ThemeData theme = Theme.of(context);

    final studentInfo = widget.applicationInfo.studentInfo;

    return Scaffold(
      body: StreamWrapper<List<Subject>>(
          stream: studentDB.listSubjectStream,
          child: (subjectList) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Enrollment Status: ",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: studentDB.enrollmentStatus(studentInfo),
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: studentDB.enrollmentStatus(studentInfo).contains("not")
                                    ? Colors.red
                                    : ColorTheme.primaryBlack,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    studentInfo.enrolled
                        ? Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, -4),
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                              ),
                              BoxShadow(
                                offset: const Offset(4, 0),
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                              ),
                            ]),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Congrats! You are enrolled",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text("Subject"),
                                    ),
                                    DataColumn(
                                      label: Text("Enroll"),
                                    ),
                                  ],
                                  rows: subjectList!.map((Subject subject) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(subject.name),
                                        ),
                                        // DataCell(
                                        //   Center(
                                        //     child: CustomCheckbox(
                                        //       value: subject.enrolled,
                                        //       onChanged: (value) {
                                        //         studentDB.updateSubjectId(subject.id.toString());
                                        //         studentDB.updateSubjectEnroll(
                                        //           isEnrolled: subject.enrolled,
                                        //           userModel: widget.applicationInfo.userModel,
                                        //         );
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: PrimaryButton(
                                    isEnabled: studentDB.validateEnrollment(subjectList),
                                    onPressed: () {
                                      studentDB.updateEnrollProfile(context, widget.applicationInfo);
                                    },
                                    label: "Enroll",
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
