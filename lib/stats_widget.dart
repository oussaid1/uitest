import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/extentions.dart';

class PriceNumberZone extends StatelessWidget {
  final TextAlign textAlign;
  final bool withDollarSign;
  final num price;
  final double? signSize;
  final TextStyle? priceStyle;
  final Widget? right;
  const PriceNumberZone({
    Key? key,
    required this.price,
    this.priceStyle,
    this.signSize,
    required this.withDollarSign,
    this.textAlign = TextAlign.end,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          withDollarSign
              ? Consumer(builder: (context, ref, _) {
                  const currency = '\$';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      currency.toString(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: signSize ?? 12,
                            color: priceStyle?.color ??
                                context.theme.onSecondaryContainer,
                          ),
                    ),
                  );
                })
              : const SizedBox.shrink(),
          Text(
            '$price',
            textAlign: textAlign,
            style: priceStyle ??
                Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: context.theme.onSecondaryContainer,
                    ),
          ),
        ],
      ),
    );
  }
}
