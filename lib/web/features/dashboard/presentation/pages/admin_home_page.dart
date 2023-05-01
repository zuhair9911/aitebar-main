import 'dart:math';

import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  final List<Color> _listColors = List.generate(10, (index) => Color(Random().nextInt(0xffffffff)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.count(
        crossAxisCount: context.isMobile ? 1 : (context.width ~/ 340),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: 10,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          Color color = _listColors[index%_listColors.length];
          return SizedBox(
            height: 120,
            child: Card(
              color: color.withOpacity(0.3),
              shadowColor: Colors.transparent,
              child: InkWell(
                onTap: (){},
                splashColor: color,
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                        Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Icon(LineIcons.file),
                            SizedBox(height: 8.0),
                            Text('Good day'),
                          ],
                        ),
                      ),
                      Text('11', style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28.0),)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
