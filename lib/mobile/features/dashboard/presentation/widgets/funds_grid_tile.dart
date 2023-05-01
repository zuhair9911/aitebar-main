import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:flutter/material.dart';

class FundsGridTile extends StatelessWidget {
  final FundsRaising fundsRaising;
  final VoidCallback? onEdit;

  const FundsGridTile({this.onEdit, required this.fundsRaising, this.onTap, Key? key}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (fundsRaising.images.isNotEmpty)
                    AppImage.network(
                      imageUrl: fundsRaising.images.first,
                      width: double.infinity,
                      height: 100.0,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  if (onEdit != null)
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: Material(
                          color: context.primary,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: onEdit?.call,
                            child: Icon(Icons.edit, size: 16.0, color: context.onPrimary),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fundsRaising.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium?.copyWith(
                        color: context.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fundsRaising.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // if (fundsRaising.lastDonation != null)
                    Text(
                      '${AppStrings.lastDonation} ${fundsRaising.createdAt?.timeAgo}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodySmall?.copyWith(color: Colors.grey, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                height: 4.0,
                decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(8.0)),
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${fundsRaising.raisedAmount} ${AppStrings.raised}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.titleSmall,
              ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    fundsRaising.status.value.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyLarge?.copyWith(color: fundsRaising.status.color),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
