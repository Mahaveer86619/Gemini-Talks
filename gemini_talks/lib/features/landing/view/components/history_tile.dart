import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/core/common/models/history_model.dart';

class HistoryTile extends StatelessWidget {
  final HistoryModel history;
  final VoidCallback onTap;
  const HistoryTile({super.key, required this.history, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: history.isChat
                    ? SvgPicture.asset(
                        'assets/icons/chat.svg',
                        theme: SvgTheme(
                          currentColor:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/icons/creative.svg',
                        theme: SvgTheme(
                          currentColor:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              history.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
