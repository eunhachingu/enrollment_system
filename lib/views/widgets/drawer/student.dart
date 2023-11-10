import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_school/networks/auth.dart';
import 'package:web_school/networks/student.dart';
import 'package:web_school/values/strings/images.dart';
import 'package:web_school/views/widgets/hover/tile_button.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final StudentDB studentDB = Provider.of<StudentDB>(context);
    final Auth auth = Provider.of<Auth>(context);
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Drawer(
        width: 230,
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(PngImages.background,
                scale: 5,
              ),
            ),
            Text("St. Jude Agro-Industrial Secondary School",
              style: theme.textTheme.bodyMedium!.copyWith(
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            OnHoverListTileButton(
              leading: Icon(CupertinoIcons.profile_circled),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(0);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(0);
                }
              },
              title: Text("Profile",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(CupertinoIcons.graph_circle),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(1);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(1);
                }
              },
              title: Text("Grades",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(CupertinoIcons.square_stack_3d_down_right),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(2);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(2);
                }
              },
              title: Text("Admission Status",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(Icons.schedule),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(3);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(3);
                }
              },
              title: Text("Schedule",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(Icons.payment),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(4);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(4);
                }
              },
              title: Text("Payment",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(Icons.password),
              onTap: () {
                if (AutoRouter.of(context).root.current.name == "StudentHomeRoute") {
                  studentDB.updateStudentIndex(5);

                } else {
                  AutoRouter.of(context).popUntil((route) => route.settings.name == "StudentHomeRoute");
                  studentDB.updateStudentIndex(5);
                }
              },
              title: Text("Change Password",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            OnHoverListTileButton(
              leading: Icon(Icons.logout),
              onTap: () {
                auth.logout(context);
              },
              title: Text("Logout",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
