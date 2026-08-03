import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/translate/sections/translate_input_section.dart';
import 'package:kore_translation/app/pages/translate/sections/translation_result_section.dart';
import 'package:kore_translation/app/pages/translate/widgets/history_list.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/layout/app_breakpoints.dart';
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// Pure layout shell: the sections own their state and provider watches, so
/// this page rebuilds only on window-size changes.
class TranslatePage extends StatelessWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Narrow windows reach the history with an edge swipe (or the drawer
      // button the Scaffold adds); wide windows show the persistent sidebar.
      drawer: MediaQuery.sizeOf(context).width < AppBreakpoints.historySidebar ? const _HistoryDrawer() : null,
      appBar: AppBar(
        // The brand logo, intentionally identical in every locale (the
        // localized product name lives in the OS-level labels).
        title: const Text('Kore!?'),
        actions: [
          // Both settings pages, reachable in one gesture by name.
          PopupMenuButton<_SettingsDestination>(
            tooltip: context.t.translate.settingsTooltip,
            icon: const Icon(Icons.settings_outlined),
            onSelected: (destination) {
              switch (destination) {
                case _SettingsDestination.model:
                  unawaited(const ModelSettingsRoute().push<void>(context));
                case _SettingsDestination.advanced:
                  unawaited(const AdvancedSettingsRoute().push<void>(context));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: _SettingsDestination.model, child: Text(context.t.settings.model)),
              PopupMenuItem(value: _SettingsDestination.advanced, child: Text(context.t.settings.advanced.title)),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= AppBreakpoints.historySidebar) {
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: AppBreakpoints.historySidebarWidth, child: HistoryList()),
                  VerticalDivider(width: 1),
                  Expanded(child: _TwoPaneLayout()),
                ],
              );
            }
            if (constraints.maxWidth >= AppBreakpoints.twoPane) {
              return const _TwoPaneLayout();
            }
            return const _SingleColumnLayout();
          },
        ),
      ),
    );
  }
}

enum _SettingsDestination { model, advanced }

/// Narrow-width history access. Selecting an entry closes the drawer and
/// leaves the entry showing in the result pane.
class _HistoryDrawer extends StatelessWidget {
  const _HistoryDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(context.t.history.title, style: Theme.of(context).textTheme.titleMedium),
            ),
            Expanded(child: HistoryList(onSelected: () => Navigator.of(context).pop())),
          ],
        ),
      ),
    );
  }
}

/// Desktop and tablet: input on the left, result on the right.
///
/// Each pane's scroll view spans the pane so its scrollbar sits at the
/// pane's right edge (the right pane's at the window edge); only the
/// content is width-constrained.
class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _Pane(child: TranslateInputSection())),
        VerticalDivider(width: 1),
        Expanded(child: _Pane(child: TranslationResultSection())),
      ],
    );
  }
}

class _Pane extends HookWidget {
  const _Pane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: useAnimatedScrollController(),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth / 2),
          child: child,
        ),
      ),
    );
  }
}

/// Phone and small windows: one scrollable column. The scroll view spans
/// the full window so the scrollbar sits at the window edge; only the
/// content is width-constrained.
class _SingleColumnLayout extends HookWidget {
  const _SingleColumnLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: useAnimatedScrollController(),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxSingleColumnWidth),
          child: const Column(
            children: [
              TranslateInputSection(),
              SizedBox(height: 24),
              TranslationResultSection(),
            ],
          ),
        ),
      ),
    );
  }
}
