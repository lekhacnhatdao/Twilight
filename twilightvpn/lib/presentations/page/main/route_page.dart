import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:openvpn/data/local/app_db.dart';
import 'package:openvpn/presentations/route/app_router.gr.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';

@RoutePage()
class AgreePrivacyPage extends StatelessWidget {
  const AgreePrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      bottom: false,
      child: Scaffold(backgroundColor: Colors.white,
       
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: 
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  const PrivacyPolicyItem(
                    'Privacy and security',
                    '\nProtect your privacy, be safe and avoid  losing your data.',
                  ),
                  SizedBox(height: screenHeight * 0.1,),
                 const $AssetsImagesGen().security.image(),
                  SizedBox(height: screenHeight * 0.1),
          
                  GestureDetector(
                    onTap: (){
                       
                        AppDatabase().setAgreePrivacyStatus(true);
                       AutoRouter.of(context).replace(const MainRoute());
                      
                    },
                    child:  Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(colors: AppColors.listgradient, begin: Alignment.centerLeft, end: Alignment.centerRight)
                      ),
                        child: const Align(child: Text("Agree and continue", style: TextStyle(color: AppColors.primary),)) ,
                     
                     ),
                  ),
                  SizedBox(height: screenHeight * 0.15),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}

class PrivacyPolicyItem extends StatelessWidget {
  final String title;
  final String content;

  const PrivacyPolicyItem(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
     
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          child: Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
