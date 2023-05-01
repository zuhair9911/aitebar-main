import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Introduction",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We are committed to protecting the privacy of our users. This Privacy Policy explains how we collect, use, and disclose information through our mobile application (App). By using our App, you consent to our Privacy Policy.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "USE OF PERSONAL INFORMATION",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We use your personal information to:\n\n• Provide and improve our App and services.\n• Respond to your inquiries, feedback, and support requests.\n• Communicate with you about updates, changes, or new features of the App.\n• Enforce our App's terms and conditions.\n• Comply with legal obligations.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text("YOUR CHOICES AND RIGHTS",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 5),
                Text(
                  "You may have certain choices and rights regarding your information, including:\n\n• Accessing and updating your information by logging into your account or contacting us.\n• Deleting your account and associated information by contacting us.\n• Opting out of receiving promotional and marketing communications from us by following the instructions in our communications or contacting us.\n• Limiting the collection and use of your information through your device settings or by contacting us.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "DATA SECURITY",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We take reasonable measures to protect your personal information from unauthorized access, disclosure, or loss. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee the absolute security of your personal information.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "RETENTION OF PERSONAL INFORMATION",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We retain your personal information for as long as necessary to fulfill the purposes for which it was collected, or as required by applicable laws or regulations",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "DISCLOSURE OF PERSONAL INFORMATION",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We do not sell, rent, or lease your personal information to any third party. However, we may disclose your personal information in the following circumstances:",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "• With your consent.\n• To third-party service providers who perform services on our behalf, such as hosting or technical support services.\n• To comply with legal obligations, such as a court order or law enforcement request.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "CHANGES TO THIS PRIVACY POLICY",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We may update this Privacy Policy from time to time by posting a revised version on our website or within the App. The updated Privacy Policy will take effect on the date it is posted. We encourage you to review this Privacy Policy periodically to stay informed about our data practices.",
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
