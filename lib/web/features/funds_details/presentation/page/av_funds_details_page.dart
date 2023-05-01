import 'dart:math';

import 'package:aitebar/core/components/app_general_dialog.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/funds_details/presentation/widgets/add_funds_raising_donation_view.dart';
import 'package:aitebar/web/features/funds_details/presentation/widgets/funds_raising_details_tab.dart';
import 'package:aitebar/web/features/funds_details/presentation/widgets/funds_raising_donations_tab.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AVFundsDetailsPage extends StatefulWidget {
  final FundsRaising fundsRaising;

  const AVFundsDetailsPage({required this.fundsRaising, Key? key}) : super(key: key);

  @override
  State<AVFundsDetailsPage> createState() => _AVFundsDetailsPageState();
}

class _AVFundsDetailsPageState extends State<AVFundsDetailsPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showAppGeneralDialog(
              context,
              child: AddFundsRaisingDonationView(fundsRaising: widget.fundsRaising),
            );
          },
          label: const Text(AppStrings.addDonation),
          icon: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.fundsRaising.title),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: AppStrings.fundsDetails),
              Tab(text: AppStrings.donations),
            ],
          ),
        ),
        body: Center(
          child: SizedBox(
            width: context.isDesktop ? min(context.width * 0.8, 1200.0) : context.width,
            child: TabBarView(
              controller: _tabController,
              children: [
                FundsRaisingDetailsTab(tabController: _tabController, fundsRaising: widget.fundsRaising),
                FundsRaisingDonationsTab(fundsRaising: widget.fundsRaising),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
