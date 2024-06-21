import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini_talks/core/common/app_constants.dart';
import 'package:gemini_talks/core/themes/pallet.dart';
import 'package:gemini_talks/core/utils/extensions.dart';
import 'package:gemini_talks/features/landing/view/components/creative_templates.dart';
import 'package:gemini_talks/features/landing/view/components/generate_button.dart';
import 'package:gemini_talks/features/landing/view/components/history_tile.dart';
import 'package:gemini_talks/features/landing/view/components/input_field.dart';
import 'package:gemini_talks/features/landing/view/components/search_form_field.dart';
import 'package:gemini_talks/features/landing/view/screens/chat_screen.dart';
import 'package:gemini_talks/features/landing/view/screens/content_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final creativeController = TextEditingController();
  final searchController = TextEditingController();

  _changeScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) {
      // call the init function of the screen
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    creativeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: _appBar(),
        drawer: _buildDrawer(),
        body: _buildBody(),
      ),
    );
  }

  _appBar() {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.background,
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: SvgPicture.asset(
            'assets/icons/sidebar.svg',
            semanticsLabel: 'sidebar Logo',
            width: 22,
            height: 22,
            theme: SvgTheme(
              currentColor: theme.colorScheme.onBackground,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Go Plus',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.add,
                size: 18,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  _buildDrawer() {
    final theme = Theme.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: theme.colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SearchFormField(
                hintText: 'Search history',
                controller: searchController,
                validator: (val) {
                  if (!val!.isValidName) {
                    return 'Enter a valid text.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22.0),
              ListTile(
                title: Text(
                  'Home',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                leading: Icon(
                  Icons.home,
                  color: theme.colorScheme.onBackground,
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                leading: Icon(
                  Icons.settings,
                  color: theme.colorScheme.onBackground,
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text(
                  'About Us',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                leading: Icon(
                  Icons.info,
                  color: theme.colorScheme.onBackground,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.surface,
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: theme.colorScheme.onBackground,
                ),
                onPressed: () {},
              ),
              title: Text(
                'John Doe',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  _buildCreativeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Generate Content',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              MyInputField(
                hintText: 'Try: Write an essay on anime...',
                controller: creativeController,
                validator: (val) {
                  if (!val!.isValidName) {
                    return 'Enter a valid text.';
                  }
                  return null;
                },
                lines: 4,
              ),
              Hero(
                tag: 'generate_btn',
                child: MyGenerateButton(
                  onPressed: () {
                    _changeScreen(
                        ContentScreen(prompt: creativeController.text));
                  },
                  text: 'Generate',
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: creativeTemplates.map((template) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CreativeTemplateTile(
                  headline: template.headline,
                  prompt: template.prompt,
                  onTap: () {
                    creativeController.text = template.prompt;
                    _changeScreen(
                        ContentScreen(prompt: creativeController.text));
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _buildChatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Chat with AI',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _changeScreen(const ChatScreen());
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start a conversation with AI',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(width: 8),
                Hero(
                  tag: 'chat_btn',
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                        Radius.circular(20),
                      ),
                    ),
                    child: Icon(
                      Icons.send,
                      size: 22,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              TextButton(
                onPressed: () {
                  //! show all activity
                },
                child: Text(
                  'Show all',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: historyList.map((history) {
            return HistoryTile(
              history: history,
              onTap: () {},
            );
          }).toList(),
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCreativeSection(),
          const SizedBox(height: 16),
          _buildChatSection(),
        ],
      ),
    );
  }
}
