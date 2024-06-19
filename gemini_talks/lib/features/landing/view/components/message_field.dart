import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MessageField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        minLines: null,
        autocorrect: true,
        controller: controller,
        onChanged: (value) {
          controller.text = value;
        },
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
