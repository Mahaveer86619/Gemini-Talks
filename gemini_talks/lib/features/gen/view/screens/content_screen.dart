import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/core/utils/extensions.dart';
import 'package:gemini_talks/features/gen/view/components/generate_button.dart';
import 'package:gemini_talks/features/gen/view/components/input_field.dart';

class ContentScreen extends StatefulWidget {
  final String prompt;
  const ContentScreen({super.key, required this.prompt});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildBody(),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: true,
      actions: [
        GestureDetector(
          onTap: () {
            //* save content to history
          },
          child: SvgPicture.asset(
            'assets/icons/save.svg',
            semanticsLabel: 'Save',
            width: 18,
            height: 18,
            theme: SvgTheme(
              currentColor: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            //* dont know what to do here
          },
          icon: Icon(
            Icons.more_vert_sharp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Input your text',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: MyInputField(
              hintText: 'Enter your prompt',
              controller: inputController,
              validator: (val) {
                if (!val!.isValidName) {
                  return 'Enter a valid text.';
                }
                return null;
              },
              initialValue: widget.prompt,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Hero(
              tag: 'generate_btn',
              child: MyGenerateButton(
                text: 'Generate',
                onPressed: () {
                  // generate content
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Generated content',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    size: 22,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.copy,
                    size: 24,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: SelectableText(
              '{\"poem\": \"With velvet paws and emerald eyes,\\nA feline grace that mesmerizes,\\nThey stalk the shadows, soft and sleek,\\nTheir purrs a song, a gentle squeak.\\n\\nFrom playful pounce to gentle rub,\\nThey weave their magic, a furry stub,\\nOf independence, aloof and proud,\\nTheir presence fills the air, a gentle cloud.\\n\\nThey bat at sunbeams, chase the string,\\nTheir curious minds, a wondrous thing,\\nThey curl up close, a warm embrace,\\nTheir love unspoken, a comforting grace.\\n\\nSo let us praise the feline kind,\\nWith hearts so pure, and minds so refined,\\nFor in their presence, we find delight,\\nA purrfect friend, both day and night.\"}\n',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
