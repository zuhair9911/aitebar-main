import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/string_extension.dart';
import 'package:aitebar/core/mixins/input_formatters.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/funds_raising/funds_raising_cubit.dart';
import 'package:aitebar/web/features/funds_details/domain/models/funds_raising_donations/funds_raising_donation.dart';
import 'package:aitebar/web/features/funds_details/presentation/bloc/funds_raising_donations/funds_raising_donations_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class AddFundsRaisingDonationView extends StatelessWidget with Validators, InputFormatter {
  final FundsRaising fundsRaising;

  AddFundsRaisingDonationView({required this.fundsRaising, Key? key}) : super(key: key);
  num _amount = 0;
  final _donationCubit = sl<FundsRaisingDonationsCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.addFundRaisingDonation),
          actions: [
            IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(LineIcons.times),
            ),
            const SizedBox(width: 8.0)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                title: Text(AppStrings.accountTitle, style: context.titleSmall),
                trailing: Text(fundsRaising.accountTitle, style: context.titleSmall),
              ),
              ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                title: Text(AppStrings.bankName, style: context.titleSmall),
                trailing: Text(fundsRaising.bankName, style: context.titleSmall),
              ),
              ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                title: Text(AppStrings.accountNumber, style: context.titleSmall),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(fundsRaising.accountNumber, style: context.titleSmall),
                    const SizedBox(width: 12.0),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: fundsRaising.accountNumber));
                        context.showToast(AppStrings.copied);
                      },
                      icon: const Icon(LineIcons.copyAlt),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                title: Text(AppStrings.referenceId, style: context.titleSmall),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(fundsRaising.referenceId ?? fundsRaising.id.referenceId, style: context.titleSmall),
                    const SizedBox(width: 12.0),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: fundsRaising.referenceId ?? fundsRaising.id.referenceId));
                        context.showToast(AppStrings.copied);
                      },
                      icon: const Icon(LineIcons.copyAlt),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(AppStrings.referenceId, style: context.titleTextStyle?.copyWith(fontSize: 20.0)),
                  Text(fundsRaising.referenceId ?? fundsRaising.id.referenceId, style: context.titleTextStyle?.copyWith(fontSize: 16.0)),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                onChanged: (value) => _amount = num.tryParse(value) ?? 0,
                inputFormatters: [decimalFormatter],
                decoration: const InputDecoration(hintText: AppStrings.donationAmount),
                validator: validateAmount,
              ),
              const SizedBox(height: 16.0),
              BlocConsumer<FundsRaisingDonationsCubit, FundsRaisingDonationsState>(
                bloc: _donationCubit,
                listener: (_, state) {
                  if (state is FundsRaisingDonationsSuccess) {
                    FundsRaisingDonation? donation = state.addDonation;
                    if (donation != null) {
                      sl<FundsRaisingCubit>().updateFundsRaising(
                        fundsRaising: fundsRaising.copyWith(
                          donors: [...fundsRaising.donors, donation.id],
                          transactions: [...fundsRaising.transactions, donation.id],
                          raisedAmount: fundsRaising.raisedAmount + donation.amount,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  } else if (state is FundsRaisingDonationsFailure) {
                    context.showToast(state.message);
                  }
                },
                builder: (context, state) {
                  return AppButton.gradient(
                    isProcessing: state == FundsRaisingDonationsLoading(items: state.items),
                    onPressed: () {
                      if (_amount > 0) {
                        String id = FirebaseFirestore.instance.collection(FirebaseKey.fundsRaisingDonation).doc().id;

                        FundsRaisingDonation donation = FundsRaisingDonation(
                          id: id,
                          fundsRaisingId: fundsRaising.id,
                          amount: _amount,
                          createdAt: DateTime.now(),
                          adminId: FirebaseAuth.instance.currentUser?.uid ?? '',
                        );
                        _donationCubit.addDonation(donation);
                      }
                    },
                    child: const Text(AppStrings.addDonations),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
