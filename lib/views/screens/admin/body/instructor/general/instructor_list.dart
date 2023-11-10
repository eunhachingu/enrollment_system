import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_school/extensions/instructor_table.dart';
import 'package:web_school/models/instructor.dart';
import 'package:web_school/networks/admin.dart';
import 'package:web_school/networks/router/routes.gr.dart';
import 'package:web_school/views/widgets/buttons/primary.dart';
import 'package:web_school/views/widgets/hover/button.dart';
import 'package:web_school/views/widgets/hover/text.dart';

@RoutePage()
class AdminInstructorListScreen extends StatefulWidget {
  const AdminInstructorListScreen({
    required this.instructorList,
    super.key,

  });

  final List<Instructor> instructorList;

  @override
  State<AdminInstructorListScreen> createState() =>
      _AdminInstructorListScreenState();
}

class _AdminInstructorListScreenState extends State<AdminInstructorListScreen> {

  @override
  Widget build(BuildContext context) {
    final AdminDB adminDB = Provider.of<AdminDB>(context);
    final ThemeData theme = Theme.of(context);

    final DataTableSource data = InstructorDataList(
      context: context,
      dataList: widget.instructorList,
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: adminDB.generalYearList.length,
            //   itemBuilder: (context, index) {
            //     return OnHoverButton(
            //       onTap: () {
            //         adminDB.updateGeneralYear(adminDB.generalYearList[index]);
            //         context.pushRoute(const AdminInstructorGradeRoute());
            //       },
            //       builder: (isHovered) => Container(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(adminDB.generalYearList[index].label!,
            //               style: theme.textTheme.bodyMedium!.copyWith(
            //                 color: isHovered ? Colors.white : Colors.black87,
            //               ),
            //             ),
            //             Icon(Icons.arrow_right,
            //               color: isHovered ? Colors.white : Colors.black87,
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  onPressed: () => context.pushRoute(const AdminAddInstructorRoute()),
                  label: "Add Instructor",
                ),
                // OnHoverTextButton(
                //   label: "Add Instructor",
                //   onTap: () => context.pushRoute(const AdminAddInstructorRoute()),
                // ),
              ],
            ),

            PaginatedDataTable(
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Grade")),
                DataColumn(label: Text("Section")),
              ],
              columnSpacing: 0,
              horizontalMargin: 10,
              rowsPerPage: 10,
              source: data,

            ),

            // DataTable(
            //   columnSpacing: 30,
            //   columns: const [
            //     DataColumn(
            //       label: Text(
            //         "Name",
            //       ),
            //     ),
            //     DataColumn(
            //       label: Text("Grade"),
            //     ),
            //     DataColumn(
            //       label: Text("Section"),
            //     ),
            //     // DataColumn(
            //     //   label: Icon(Icons.remove),
            //     // ),
            //   ],
            //   rows: widget.instructorList.map((e) {
            //     return DataRow(
            //       cells: [
            //         DataCell(
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width * 0.3,
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: OnHoverTextButton(
            //                     label: e.username,
            //                     onTap: () {
            //                       adminDB.updateInstructorId(e.userModel.id);
            //                         context.pushRoute(AdminEditInstructorRoute(
            //                           instructorData: e,
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ),
            //                 // Expanded(
            //                 //   child: InkWell(
            //                 //     onTap: () {
            //                 //       adminDB.updateInstructorId(e.userModel.id);
            //                 //       context.pushRoute(AdminEditInstructorRoute(
            //                 //         instructorData: e,
            //                 //       ),
            //                 //       );
            //                 //     },
            //                 //     child: Text(
            //                 //       style: theme.textTheme.bodyMedium!.copyWith(
            //                 //         color: Colors.blue,
            //                 //         decoration: TextDecoration.underline,
            //                 //       ),
            //                 //       e.username,
            //                 //     ),
            //                 //   ),
            //                 // ),
            //                 IconButton(onPressed: () {
            //                   adminDB.updateInstructorId(e.userModel.id);
            //                   adminDB.deleteInstructor(context);
            //                 }, icon: Icon(Icons.delete,
            //                   color: Colors.red,
            //                 )),
            //               ],
            //             ),
            //           ),
            //         ),
            //         DataCell(
            //           SizedBox(width: 60, child: Text(e.grade!.label!)),
            //         ),
            //         DataCell(
            //           Center(
            //             child: Text(e.section!.label!),
            //           ),
            //         ),
            //         // DataCell(
            //         //   GestureDetector(
            //         //     onTap: () {
            //         //       adminDB.updateInstructorId(e.userModel.id);
            //         //       adminDB.deleteInstructor(context);
            //         //     },
            //         //     child: const Icon(
            //         //       Icons.delete,
            //         //       color: Colors.red,
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}