import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/presentations/widget/impl/app_buttons.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/utils/config.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> _launchURL(String link) async {
  final url = Uri.parse(link);
  await launchUrl(url, mode: LaunchMode.externalApplication);
}
class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return 
       Container(
                 
        color: Colors.white,
         child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(leading: TextButton(onPressed: (){
              Navigator.pop(context);
            },child: Icon(Icons.clear_rounded)),
            
            ),
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     topRight: Radius.circular(20),
            //   ),
            //   child: 
              

            // ),
            const SizedBox(
              height: 10,
            ),
            const AppBodyText(
              text: 'Do you like ${Config.appName} ?',
              textAlign: TextAlign.center,
              size: 20,
              color: AppColors.primaryDark,
            ),
            AppBodyText(
              text: Platform.isIOS
                  ? 'Tap a star to rate on the App Store'
                  : 'Tap on a star to provide your rating on Google Play',
              textAlign: TextAlign.center,
              size: 14,
              color: AppColors.primaryDark,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: i <= _rating
                          ? 
                          Icon(Icons.star, color: Colors.amber,) : Icon(Icons.star, color: Colors.grey,),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
  Navigator.of(context).pop();
                debugPrint('User rated: $_rating stars');
                if (_rating > 3) {
                  _launchURL(Config.storeAppUrl);
                  // StoreRedirect.redirect(
                  //   androidAppId: "com.Padoventi.JackpotVPN",
                  // );
                }
              },
           child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff5cffd1),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Align(child: Text('Send Feedback', style: TextStyle(
color: AppColors.primaryDark
            ),))),
            ),
          SizedBox(height: 30,)
          ],),
       )
        ;
   
  }
}

