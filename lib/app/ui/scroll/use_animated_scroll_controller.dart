import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scroll_animator/scroll_animator.dart';

/// A hook-managed [AnimatedScrollController] using Chromium's ease-in-out
/// curve, so discrete mouse-wheel ticks scroll as smoothly as in Chrome
/// while trackpad deltas stay under OS inertia.
AnimatedScrollController useAnimatedScrollController() {
  final controller = useMemoized(
    () => AnimatedScrollController(animationFactory: const ChromiumEaseInOut()),
  );
  useEffect(() => controller.dispose, [controller]);
  return controller;
}
