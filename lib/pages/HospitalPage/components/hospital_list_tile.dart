import 'package:flutter/material.dart';
import 'package:medipath/model/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalListTile extends StatelessWidget {
  final HospitalModel hospital;
  const HospitalListTile({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xff44157D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hospital.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hospital.address,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          hospital.region,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      hospital.phone,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color(0xffE0DD26)),
                    foregroundColor: WidgetStateProperty.all<Color>(Color(0xff44157D)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                    onPressed: () async {
                      final Uri phoneUrl = Uri(scheme: 'tel', path: hospital.phone);

                      if (await canLaunchUrl(phoneUrl)) {
                        await launchUrl(phoneUrl);
                      } else {
                        throw 'Could not launch $phoneUrl';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, size: 16, color: Color(0xff44157D),),
                        SizedBox(width: 5),
                        Text("Telepon"),
                      ],
                    ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color(0xffE0DD26)),
                    foregroundColor: WidgetStateProperty.all<Color>(Color(0xff44157D)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(hospital.name)}"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city, size: 16, color: Color(0xff44157D),),
                      SizedBox(width: 5),
                      Text("Rute"),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
