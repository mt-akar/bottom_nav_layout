import 'package:bottom_nav_layout/bottom_nav_layout.dart';

/// Create a class that extends [PageStack]
class MyPageStack extends PageStack {
  /// Create the constructor
  MyPageStack({required int initialPage}) : super(initialPage: initialPage);

  /// Implement [PageStack.push].
  ///
  /// Don't forget that, pageStack.peek() is always the current page index in the layout.
  /// If you want to navigate to a page and peek implementation is "int peek() => last;",
  /// it is necessary to actually push the index to the end of the stack.
  void push(int pageIndex) {
    // Prevent pushing the last element again,
    // even though the layout never pushes the last element again anyways.
    // Having same index back to back causes UI to appear unresponsive when back button is pressed.
    if (pageIndex == last) throw Exception("pageIndex pushed cannot be the same as the last index.");

    // For example, push the page both to the start and to the end.
    addFirst(pageIndex);
    addLast(pageIndex);
  }

  /// Implement [PageStack.pop].
  int pop() => removeLast();

  /// Implement [PageStack.peek].
  int peek() => last;
}
