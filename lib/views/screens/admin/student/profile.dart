import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_school/models/application/application.dart';
import 'package:web_school/models/option.dart';
import 'package:web_school/networks/admin.dart';
import 'package:web_school/views/widgets/body/wrapper/stream.dart';
import 'package:web_school/views/widgets/buttons/dropdown.dart';
import 'package:web_school/views/widgets/buttons/primary.dart';
import 'package:web_school/views/widgets/fields/dropdown.dart';
import 'package:web_school/views/widgets/forms/emergency.dart';
import 'package:web_school/views/widgets/forms/family.dart';
import 'package:web_school/views/widgets/forms/personal.dart';
import 'package:web_school/views/widgets/forms/residence.dart';
import 'package:web_school/views/widgets/forms/school.dart';

@RoutePage()
class AdminStudentProfileScreen extends StatefulWidget {
  const AdminStudentProfileScreen({
    super.key,
  });

  @override
  State<AdminStudentProfileScreen> createState() =>
      _AdminStudentProfileScreenState();
}

class _AdminStudentProfileScreenState extends State<AdminStudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final AdminDB adminDB = Provider.of<AdminDB>(context, listen: false);
      adminDB.updateStudentStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AdminDB adminDB = Provider.of<AdminDB>(context);
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          "Please assign a section",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: adminDB.sectionList.map((e) {
                          return PrimaryButton(
                            onPressed: () {
                              adminDB.updateStudentSection(context, e);
                            },
                            label: e.label!,
                          );
                        }).toList(),
                        // content: CustomDropdown<SelectionOption>(
                        //   initialValue: adminDB.studentSection,
                        //   value: adminDB.studentSection,
                        //   label: "Assign a section",
                        //   hintText: 'Select',
                        //   items:
                        //       adminDB.sectionList.map((SelectionOption option) {
                        //     return SchoolDropdownMenuItem<SelectionOption>(
                        //       value: option,
                        //       label: option.label!,
                        //       child: SchoolDropdown(
                        //         option: option,
                        //       ),
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) =>
                        //       adminDB.updateStudentSection(context, value),
                        // ),
                      );
                    });
              },
              child: Text(
                "Assign",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: StreamWrapper<ApplicationInfo>(
            stream: adminDB.studentStream,
            child: (applicationInfo) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => adminDB.updateSchoolInfoShow(),
                              child: Icon(
                                adminDB.schoolInfoShow
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            Text(
                              "School Info",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Visibility(
                          visible: adminDB.schoolInfoShow,
                          child: SchoolInfoForm(
                            schoolInfo: applicationInfo!.schoolInfo,
                            viewOnly: true,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => adminDB.updatePersonalInfoShow(),
                              child: Icon(
                                adminDB.personalInfoShow
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            Text(
                              "Personal Info",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Visibility(
                          visible: adminDB.personalInfoShow,
                          child: BasicPersonalInfoForm(
                            personalInfo: applicationInfo.personalInfo,
                            viewOnly: true,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => adminDB.updateResidenceInfoShow(),
                              child: Icon(
                                adminDB.residenceInfoShow
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            Text(
                              "Residence Info",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Visibility(
                          visible: adminDB.residenceInfoShow,
                          child: ResidenceForm(
                            residenceInfo: applicationInfo.residenceInfo,
                            viewOnly: true,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => adminDB.updateEmergencyInfoShow(),
                              child: Icon(
                                adminDB.emergencyInfoShow
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            Text(
                              "Emergency Info",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Visibility(
                          visible: adminDB.emergencyInfoShow,
                          child: EmergencyForm(
                            emergencyInfo: applicationInfo.emergencyInfo,
                            viewOnly: true,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => adminDB.updateFamilyInfoShow(),
                              child: Icon(
                                adminDB.familyInfoShow
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            Text(
                              "Family Info",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Visibility(
                          visible: adminDB.familyInfoShow,
                          child: FamilyInformationForm(
                            familyInfo: applicationInfo.familyInfo,
                            viewOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
