import 'dart:math';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FundsRaisingDetailsView extends StatelessWidget {
  final FundsRaising fundsRaising;

  const FundsRaisingDetailsView({required this.fundsRaising, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: const Text(AppStrings.fundsDetails),
            actions: [IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(LineIcons.times))],
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: max(150.0, context.width * 0.15),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1,
            ),
            items: fundsRaising.images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return AppImage.network(
                    imageUrl: image,
                    width: double.infinity,
                    height: max(150.0, context.width * 0.15),
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(4.0),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          Text(fundsRaising.title),
          const SizedBox(height: 12.0),
          Container(
            height: 4.0,
            decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(8.0)),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              text: '\$${fundsRaising.raisedAmount}',
              style: context.labelLarge,
              children: [
                TextSpan(
                  text: ' USD raised of \$${fundsRaising.requireAmount} goal',
                  style: context.labelLarge?.copyWith(color: Colors.grey),
                ),
                TextSpan(
                  text: ' \u2022 ',
                  style: context.labelLarge?.copyWith(color: Colors.grey),
                ),
                TextSpan(
                  text: ' ${fundsRaising.donors.length}',
                  style: context.labelLarge,
                ),
                TextSpan(
                  text: ' ${AppStrings.donor.toLowerCase()}',
                  style: context.labelLarge?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          AppButton.gradient(onPressed: () {}, child: const Text(AppStrings.share)),
          const SizedBox(height: 8.0),
          // AppButton.gradient(
          //   onPressed: () => context.router.push(DonationAccountDetailsRoute(id: fundsRaising.id)),
          //   child: const Text(AppStrings.donateNow),
          // ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: AppImage.network(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fundsRaising.email,
                        style: context.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(fundsRaising.contactNumber, style: context.labelLarge),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Colors.grey),
          const SizedBox(height: 12.0),
          RichText(
            text: TextSpan(
              text: '${fundsRaising.createdAt?.timeAgo}',
              style: context.labelLarge,
              children: [
                TextSpan(
                  text: '    \u2022    ',
                  style: context.labelLarge?.copyWith(color: Colors.grey),
                ),
                TextSpan(
                  text: fundsRaising.category,
                  style: context.labelLarge?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Colors.grey),
          const SizedBox(height: 12.0),
          Text(
            fundsRaising.description,
            style: context.labelLarge,
          ),
          const SizedBox(height: 12.0),
          Container(
            height: 4.0,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
          ),
        ],
      ),
    );
  }
}
