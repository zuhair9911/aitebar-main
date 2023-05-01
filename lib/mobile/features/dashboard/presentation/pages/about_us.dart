import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
                  "About Us",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome to Aitebar Foundation - where giving meets impact. Our non-profit organization is committed to revolutionizing the way we donate and receive donations. We believe that everyone has the power to create change, and our mission is to empower individuals and communities to do just that.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "With our user-friendly app, we have created a platform that seamlessly connects donors with those in need. We understand that giving should be easy, and that's why we have streamlined the donation process. Our app allows you to give to a specific cause or person with just a few clicks, and our secure payment system ensures that your donation goes directly to the intended recipient.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "At Aitebar Foundation, we also prioritize transparency and accountability. We provide regular updates on how donations are being used, and we ensure that every dollar goes towards making a meaningful impact. Whether you're donating to support a local community project or providing emergency relief to a disaster-stricken area, your contribution can make a difference.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "By using our app, you can become part of a community of individuals who are dedicated to creating positive change. You can see the impact of your donations in real-time, and you can connect with other like-minded individuals who share your passion for social welfare",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  "We believe that by working together, we can create a better future for everyone. Join us in our mission to make a difference and bring hope to those who need it most.",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
