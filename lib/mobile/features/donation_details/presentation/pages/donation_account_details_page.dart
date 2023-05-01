import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/string_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DonationAccountDetailsPage extends StatelessWidget {
  final String id;

  const DonationAccountDetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Account Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.accountTitle, style: context.bodySmall),
                    Text('AITEBAR Foundation', style: context.titleMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.accountNumber, style: context.bodySmall),
                    Text('123123123123', style: context.titleMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.bankName, style: context.bodySmall),
                    Text('National Bank', style: context.titleMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              color: context.error.withOpacity(0.2),
              shadowColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.referenceNumber, style: context.bodySmall),
                    Text(id.referenceId, style: context.titleMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppStrings.doNotForGetToAddReferenceNumberWhileDonating, style: context.bodySmall?.copyWith(color: context.error)),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
