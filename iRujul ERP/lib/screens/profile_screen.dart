import 'package:flutter/material.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: fontSemiBoldStyle(fontSize: 18),),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child:Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Image.asset("assets/images/img_user.png"),
                ),
                const SizedBox(height: 20,),
                Text(AppManager.shared.loginModel?.defaultExecutiveName ?? "-",
                  style: fontSemiBoldStyle(fontSize: 16),
                ),
                const SizedBox(height: 20,),
                AppCardWidget(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(children: [
                            Text("Company:", style: fontRegularStyle(fontSize: 14),),
                            const SizedBox(width: 10,),
                            Text(AppManager.shared.loginModel?.companyName ?? "-", style: fontBoldStyle(fontSize: 14),),
                          ],),
                          const SizedBox(height: 20,),
                          Row(children: [
                            Text("Branch:", style: fontRegularStyle(fontSize: 14),),
                            const SizedBox(width: 10,),
                            Text(AppManager.shared.loginModel?.branchName ?? "-", style: fontBoldStyle(fontSize: 14),),
                          ],),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
      )
    );
  }
}
