import 'dart:async';

import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';

import 'package:openvpn/presentations/page/billing/premium_page.dart';
import 'package:openvpn/presentations/page/main/history_page.dart';

import 'package:openvpn/presentations/page/main/settingpage.dart';
import 'package:openvpn/presentations/page/main/vpn_page.dart';
import 'package:openvpn/presentations/widget/impl/backround.dart';
import 'package:openvpn/presentations/widget/impl/custombar.dart';
import 'package:openvpn/presentations/widget/index.dart';
import 'package:openvpn/resources/assets.gen.dart';

import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/icondata.dart';

import 'package:openvpn/utils/config.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().startBilling();
    });

    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: state.isLoading
                      ? [
                          Colors.white,
                          Colors.grey,
                        ]
                      : state.titleStatus == 'Connected'
                          ? [Colors.white, Color(0xff5cffd1)]
                          : [Colors.white, Colors.grey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/images/Group 907.png'),
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AppTitleText(
                        text: Config.appName,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.purple,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return PremiumPage();
                              }));
                            },
                            child: Row(
                              children: [
                                $AssetsImagesGen().logo.image(height: 10),
                                const Text(
                                  'Go VIP',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    )
                    // BlocBuilder<AppCubit, AppState>(
                    //   builder: (context, state) {
                    //     return Container(
                    //       decoration: const BoxDecoration(
                    //         boxShadow: <BoxShadow>[
                    //           BoxShadow(
                    //             color: Colors.white12,
                    //             blurRadius: 10,
                    //           ),
                    //         ],
                    //         borderRadius: BorderRadius.all(Radius.circular(100)),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(horizontal: 16),
                    //       child: CachedNetworkImage(
                    //         imageUrl: state.currentServer?.flag ?? 'assets/images/Frame.png',
                    //         height: 32,
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child:
                          TabBarView(controller: controller, children: const [
                        VpnPage(),
                        HistoryPage(),
                        PremiumPage(),
                        SettingPage(),
                      
                      ]),
                    ),
                    CustomBottomBar(
                      controller: controller,
                      listIcon: [
                        Icons.bolt_rounded,
                        Icons.history_outlined,
                        Icons.radar,
                        Icons.settings,
                      ],
                      onSelect: (index) { return controller.animateTo(index);
                    },
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
