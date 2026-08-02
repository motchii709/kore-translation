/// Layout breakpoints, following the Material 3 window size classes.
abstract final class AppBreakpoints {
  /// Expanded window class: side-by-side panes instead of a single column.
  static const twoPane = 840.0;

  /// Wide desktop windows: a persistent history sidebar joins the panes.
  /// Narrower windows reach the history through its own page instead.
  static const historySidebar = 1200.0;

  /// Fixed width of that sidebar.
  static const historySidebarWidth = 300.0;

  /// Maximum width of the two-pane translate layout.
  static const maxContentWidth = 1200.0;

  /// Maximum width of a single-column page on larger windows.
  static const maxSingleColumnWidth = 720.0;

  /// Maximum width of form pages (settings).
  static const maxFormWidth = 600.0;
}
