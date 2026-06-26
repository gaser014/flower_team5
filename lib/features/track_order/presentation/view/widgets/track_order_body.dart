import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_info_card.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_items_card.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_order_progress.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_order_status_header.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_order_totals.dart';
import 'package:gap/gap.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key, required this.order});

  final TrackOrderEntity order;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        TrackOrderStatusHeader(status: order.status),
        const Gap(16),
        TrackOrderProgress(status: order.status),
        const Gap(24),
        _AddressCard(label: order.addressLabel, details: order.addressDetails),
        const Gap(16),
        _PaymentCard(total: order.total, paymentLabel: order.paymentLabel),
        const Gap(16),
        TrackItemsCard(items: order.items),
        const Gap(24),
        TrackOrderTotals(
          subTotal: order.subTotal,
          deliveryFee: order.deliveryFee,
          total: order.total,
        ),
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.label, required this.details});

  final String label;
  final String details;

  @override
  Widget build(BuildContext context) {
    return TrackInfoCard(
      leading: SvgPicture.asset(
        AppAssets.iconsLocation,
        colorFilter: const ColorFilter.mode(AppColors.black0C, BlendMode.srcIn),
      ),
      title: label,
      subtitle: details,
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.total, required this.paymentLabel});

  final num total;
  final String paymentLabel;

  @override
  Widget build(BuildContext context) {
    return TrackInfoCard(
      leading: const Icon(
        Icons.payments_outlined,
        size: 24,
        color: AppColors.black0C,
      ),
      title: "$total ${AppStrings.egp}",
      subtitle: paymentLabel,
    );
  }
}
