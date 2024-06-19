import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/core/themes/pallet.dart';

class MyGenerateButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const MyGenerateButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Pallete.gradient1,
                  Pallete.gradient2,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/creative.svg',
                  semanticsLabel: 'sidebar Logo',
                  width: 22,
                  height: 22,
                  theme: SvgTheme(
                    currentColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
