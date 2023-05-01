import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          title: Image.asset(
            "assets/app/app_logo_primary.png",
            height: kToolbarHeight * 0.8,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Center(
                  child: Text(
                    "Terms And Conditions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Introduction",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Welcome to Aitebar Foundation's mobile application (\"App\"). By using the App, you agree to comply with and be bound by the following terms and conditions of use (\"Terms\"), which together with our Privacy Policy govern Aitebar Foundation's relationship with you in relation to this App. If you disagree with any part of these terms and conditions, please do not use our App.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Use of App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "The content of the pages of this App is for your general information and use only. It is subject to change without notice.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Intellectual Property Rights",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "This App contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance, and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Disclaimer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "The information contained in this App is for general information purposes only. The information is provided by Aitebar Foundation, and while we endeavor to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the App or the information, products, services, or related graphics contained on the App for any purpose. Any reliance you place on such information is therefore strictly at your own risk.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Limitations of Liability",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "In no event will Aitebar will be liable for any loss or damage whatsoever arising from loss of data or profits arising out of or in connection with the use of this App.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Indemnification",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "You agree to indemnify, defend, and hold harmless Aitebar Foundation, its officers, directors, employees, agents, licensors and suppliers (collectively the \"Service Providers\") from and against all losses, expenses, damages and costs, including reasonable attorneys' fees, resulting from any violation of these Terms or any activity related to your account (including negligent or wrongful conduct) by you or any other person accessing the App using your account.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "User Accounts",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "To use our app, you may be required to create an account. You are responsible for maintaining the security of your account and password. We reserve the right to terminate your account for any reason.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "User Conduct",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We expect all users to behave in a respectful and appropriate manner while using our app. Harassment, hate speech, or sharing of inappropriate content will not be tolerated.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Termination and Suspension",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We reserve the right to terminate or suspend access to our app for any reason, including violation of these Terms.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Changes to Terms and Conditions",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Aitebar Foundation reserves the right, at its sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Governing Law and Dispute Resolution",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "These Terms are governed by and construed in accordance with the laws of Pakistan, without giving effect to any principles of conflicts of law. Any disputes will be resolved through binding arbitration.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "Severability",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "If any provision of these Terms is found to be unenforceable or invalid under any applicable law, such unenforceability or invalidity shall not render these Terms unenforceable or invalid as a whole, and such provisions shall be deleted without affecting the remaining provisions herein.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
