import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_school/models/application/application.dart';
import 'package:web_school/models/payment.dart';
import 'package:web_school/networks/payment.dart';
import 'package:web_school/views/widgets/body/wrapper/stream.dart';

@RoutePage()
class StudentPaymentHomeScreen extends StatefulWidget {
  const StudentPaymentHomeScreen({
    required this.applicationInfo,
    super.key,
  });

  final ApplicationInfo applicationInfo;

  @override
  State<StudentPaymentHomeScreen> createState() => _StudentPaymentHomeScreenState();
}

class _StudentPaymentHomeScreenState extends State<StudentPaymentHomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final PaymentDB paymentDB = Provider.of<PaymentDB>(context, listen: false);
      paymentDB.updateStudentPaymentStream(id: widget.applicationInfo.userModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final PaymentDB paymentDB = Provider.of<PaymentDB>(context);
    final ThemeData theme = Theme.of(context);


    return Scaffold(
      body: StreamWrapper<List<PaymentDescription>>(
        stream: paymentDB.studentPaymentStream,
        child: (paymentList) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your current balance is: ${widget.applicationInfo.studentInfo.balance}"),
                  const SizedBox(height: 24.0),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: paymentList!.length,
                    itemBuilder: (context, index) {

                      final payment = paymentList[index];
                      final date = payment.dateTime.toDate();

                      final formattedDate = DateFormat("MMMM/dd/yyyy").format(date);

                      return Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text("${index + 1}"),
                                  radius: 15,
                                ),
                                const SizedBox(width: 4.0),
                                Text("#${payment.refNumber}",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status: ${payment.status}"),
                                  Text("Amount: ₱${payment.amount}"),
                                  Text("Date transaction: ${formattedDate}"),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}