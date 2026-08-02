import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/router/app_router.dart';
import 'package:kore_honyaku/app/ui/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: KoreApp()));
}

class KoreApp extends ConsumerWidget {
  const KoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Kore!?',
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
