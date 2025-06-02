import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecialtyButton extends StatelessWidget {
  final String? specialtyName;
  const SpecialtyButton({super.key, this.specialtyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      child: InkWell(
        onTap: () {
          // Navigate to the chat doctor page with the selected specialty
          context.goNamed('chatdoctorspecialty', pathParameters: {'specialty': specialtyName ?? 'General Practitioner'});
        },
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
            Text(
              specialtyName ?? "Specialty",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
