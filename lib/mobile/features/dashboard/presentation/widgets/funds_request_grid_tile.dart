import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FundsRequestGridTile extends StatelessWidget {
  final Widget _child;

  FundsRequestGridTile({super.key, required final FundsRequest fundsRequest, VoidCallback? onEdit, VoidCallback? onTap})
      : _child = _FundsRequestGridTile(
          fundsRequest: fundsRequest,
          onEdit: onEdit,
          onTap: onTap,
        );

  const FundsRequestGridTile.skeleton({super.key}) : _child = const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}

class _FundsRequestGridTile extends StatelessWidget {
  final FundsRequest fundsRequest;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

  const _FundsRequestGridTile({Key? key, required this.fundsRequest, this.onEdit, this.onTap}) : super(key: key);

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
            children: [
              Stack(
                children: [
                  AppImage.network(
                    imageUrl: fundsRequest.cnicImages.first,
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
                      fundsRequest.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium?.copyWith(
                        color: context.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (fundsRequest.isZakatEligible == true)
                      Text(
                        AppStrings.zakatEligible,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: context.primary),
                      ),
                    const SizedBox(height: 8.0),
                    Text(
                      fundsRequest.category,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${fundsRequest.requestedAmount}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${fundsRequest.createdAt?.timeAgo}',
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
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  fundsRequest.status.name.toUpperCase(),
                  style: TextStyle(
                    color: fundsRequest.status.color,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: context.primary,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity, color: context.primary, height: 16.0),
                      const SizedBox(height: 8.0),
                      Container(width: double.infinity, color: context.primary, height: 12.0),
                      const SizedBox(height: 8.0),
                      Container(width: double.infinity, color: context.primary, height: 8.0),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  height: 4.0,
                  decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(8.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
