import 'dart:collection';

/// Parent class for any stack implementation for [BackStackedBottomNavLayout] navigation.
///
/// [BackStackedBottomNavLayout] requires an instance of [TabStack] to be passed in as a parameter.
///
/// Users can extend this class to have their own stack behaviour.
///
/// If custom behavior is implemented, implementations should never have 2 of the same item consecutively.
/// Having so causes back button to sometimes appear unresponsive and cause poor user experience.
/// [BackStackedBottomNavLayout] never pushes the last item in the stack into the stack.
///
/// Additionally, the last item in the stack is the current selected tabIndex.
/// Therefore, the stack is never empty while the [BackStackedBottomNavLayout] is handling the pop events.
/// When there is a single item on the stack and pop is called, the app exits if no other back button handler is added.
abstract class TabStack extends ListQueue<int> {
  TabStack({required int initialTab}) {
    addLast(initialTab);
  }

  void push(int index);

  int pop();

  int peek();
}

/// [TabStack] implementation that is a trivial stack.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->1->2->1.
/// pop();   Stack: 0->1->2.
/// push(0); Stack: 0->1->2->0.
/// pop();   Stack: 0->1->2.
class StandardTabStack extends TabStack {
  StandardTabStack({required int initialTab}) : super(initialTab: initialTab);

  @override
  void push(int tabIndex) {
    addLast(tabIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [TabStack] implementation that follows reorder-to-front behavior.
///
/// This behavior is used in instagram.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->2->1.
/// pop();   Stack: 0->2.
/// push(0); Stack: 2->0.
/// pop();   Stack: 2.
class ReorderToFrontTabStack extends TabStack {
  ReorderToFrontTabStack({required int initialTab}) : super(initialTab: initialTab);

  @override
  void push(int tabIndex) {
    remove(tabIndex);
    addLast(tabIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [TabStack] implementation that follows reorder-to-front behavior except the first item.
/// The first item never changes and can be twice in the stack.
///
/// This behavior is used in youtube.
///
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->2->1.
/// pop();   Stack: 0->2.
/// push(0); Stack: 0->2->0.
/// pop();   Stack: 0->2.
class ReorderToFrontExceptFirstTabStack extends TabStack {
  ReorderToFrontExceptFirstTabStack({required int initialTab}) : super(initialTab: initialTab);

  @override
  void push(int tabIndex) {
    if (tabIndex != first) {
      remove(tabIndex);
    } else {
      if (remove(tabIndex)) remove(tabIndex);
      addFirst(tabIndex);
    }
    addLast(tabIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [TabStack] implementation that only stores the last item pushed.
///
/// This behavior is very similar to the behavior in the following example:
/// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 1.
/// push(2); Stack: 2.
/// push(1); Stack: 1.
/// pop();   Stack: - (Exit app).
/// push(0); Stack: - (N/A).
/// pop();   Stack: - (N/A).
class ReplaceTabStack extends TabStack {
  ReplaceTabStack({required int initialTab}) : super(initialTab: initialTab);

  @override
  void push(int tabIndex) {
    removeLast();
    addLast(tabIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [TabStack] implementation that stores the first and the last item pushed.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->2.
/// push(1); Stack: 0->1.
/// pop();   Stack: 0.
/// push(0); Stack: 0.
/// pop();   Stack: - (Exit app).
class ReplaceExceptFirstTabStack extends TabStack {
  ReplaceExceptFirstTabStack({required int initialTab}) : super(initialTab: initialTab);

  @override
  void push(int tabIndex) {
    if (length == 2) removeLast();
    if (last != tabIndex) addLast(tabIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}
