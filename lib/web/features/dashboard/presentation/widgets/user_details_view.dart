import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

class UserDetails extends StatelessWidget {
  final AppUser user;

  const UserDetails({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.userDetails),
          actions: [IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(LineIcons.times)), const SizedBox(width: 8.0)],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(radius: 50.0, child: Icon(LineIcons.user, size: 36.0)),
              const SizedBox(height: 16.0),
              ListTile(
                onTap: () {},
                leading: const Icon(LineIcons.user),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                title: Text('${user.name}'),
              ),
              const SizedBox(height: 12.0),
              ListTile(
                onTap: () {},
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                leading: const Icon(LineIcons.envelope),
                title: Text('${user.email}'),
              ),
              const SizedBox(height: 12.0),
              ListTile(
                onTap: () {},
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                leading: const Icon(Icons.calendar_month),
                title: Text('${user.createdAt?.format()}'),
              ),
              const SizedBox(height: 12.0),
              ListTile(
                  onTap: () {},
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  leading: const Icon(LineIcons.user),
                  title: Text('${AppStrings.uid}: ${user.uid}'),
                  trailing: IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: user.uid)).then((_) {
                        context.showToast(AppStrings.copied);
                      });
                    },
                    icon: const Icon(LineIcons.copy),
                  )),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ],
    );
  }
}
