import 'dart:collection';

/// Parent class for any stack implementation for [BackStackedBottomNavLayout] navigation.
///
/// [BackStackedBottomNavLayout] requires an instance of [PageStack] to be passed in as a parameter.
///
/// Users can extend this class to have their own stack behaviour.
///
/// If custom behavior is implemented, implementations should never have 2 of the same item consecutively.
/// Having so causes back button to sometimes appear unresponsive and cause poor user experience.
/// [BackStackedBottomNavLayout] never pushes the last item in the stack into the stack.
///
/// Additionally, the last item in the stack is the current selected page index.
/// Therefore, the stack is never empty while the [BackStackedBottomNavLayout] is handling the pop events.
/// When there is a single item on the stack and pop is called, the app exits if no other back button handler is added.
abstract class PageStack extends ListQueue<int> {
  // Constructor pushes the initialPage to the stack.
  PageStack({required int initialPage}) {
    addLast(initialPage);
  }

  void push(int index);

  int pop();

  int peek();
}

/// [PageStack] implementation that behaves like a standard stack.
///
/// This behavior is used by Google Play app.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->1->2->1.
/// pop();   Stack: 0->1->2.
/// push(0); Stack: 0->1->2->0.
/// pop();   Stack: 0->1->2.
class StandardPageStack extends PageStack {
  StandardPageStack({required int initialPage})
      : super(initialPage: initialPage);

  @override
  void push(int pageIndex) {
    // Check if the last index is pushed again
    if (pageIndex == last)
      throw Exception("pageIndex pushed cannot be the same as the last item.");

    // Add index
    addLast(pageIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [PageStack] implementation that follows reorder-to-front behavior.
///
/// This behavior is used by Instagram, Reddit, and Netflix apps.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->2->1.
/// pop();   Stack: 0->2.
/// push(0); Stack: 2->0.
/// pop();   Stack: 2.
class ReorderToFrontPageStack extends PageStack {
  ReorderToFrontPageStack({required int initialPage})
      : super(initialPage: initialPage);

  @override
  void push(int pageIndex) {
    // Check if the last index is pushed again
    if (pageIndex == last)
      throw Exception("pageIndex pushed cannot be the same as the last item.");

    // If the pushed item exist on the stack, remove it
    remove(pageIndex);

    // Add index
    addLast(pageIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [PageStack] implementation that follows reorder-to-front behavior except the first item.
/// The first item never changes and can be at two different positions in the stack.
///
/// This behavior is used by Youtube app.
///
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->1->2.
/// push(1); Stack: 0->2->1.
/// pop();   Stack: 0->2.
/// push(0); Stack: 0->2->0.
/// pop();   Stack: 0->2.
class ReorderToFrontExceptFirstPageStack extends PageStack {
  ReorderToFrontExceptFirstPageStack({required int initialPage})
      : super(initialPage: initialPage);

  @override
  void push(int pageIndex) {
    // Check if the last index is pushed again
    if (pageIndex == last)
      throw Exception("pageIndex pushed cannot be the same as the last item.");

    // If the the item pushed is not the first item
    if (pageIndex != first)
      // If the pushed item exist on the stack, remove it
      remove(pageIndex);

    // If the index pushed is the first index,
    else {
      // Remove it up to two times.
      this..remove(pageIndex)..remove(pageIndex);

      // Add it back to the first spot
      addFirst(pageIndex);
    }

    // Add index
    addLast(pageIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [PageStack] implementation that only stores the last item pushed.
///
/// This is similar to the naive example given at flutter docs:
/// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
///
/// This behavior is used by a lot of applications. This is also Cupertino's default behavior.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 1.
/// push(2); Stack: 2.
/// push(1); Stack: 1.
/// pop();   Stack: - (Exit app).
/// push(0); Stack: - (N/A).
/// pop();   Stack: - (N/A).
class ReplacePageStack extends PageStack {
  ReplacePageStack({required int initialPage})
      : super(initialPage: initialPage);

  @override
  void push(int pageIndex) {
    // Check if the last index is pushed again
    if (pageIndex == last)
      throw Exception("pageIndex pushed cannot be the same as the last item.");

    // Remove the only index
    removeLast();

    // Add index
    addLast(pageIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}

/// [PageStack] implementation that stores the first and the last item pushed.
///
/// This behavior is used by Google, Gmail, Facebook, and Twitter apps.
///
/// Example:
/// Initial  Stack: 0.
/// push(1); Stack: 0->1.
/// push(2); Stack: 0->2.
/// push(1); Stack: 0->1.
/// pop();   Stack: 0.
/// push(0); Stack: 0.
/// pop();   Stack: - (Exit app).
class ReplaceExceptFirstPageStack extends PageStack {
  ReplaceExceptFirstPageStack({required int initialPage})
      : super(initialPage: initialPage);

  @override
  void push(int pageIndex) {
    // Check if the last index is pushed again
    if (pageIndex == last)
      throw Exception("pageIndex pushed cannot be the same as the last item.");

    // If the stack have 2 items
    if (length == 2)
      // Remove the last one.
      removeLast();

    // If the index pushed is not in the stack
    if (last != pageIndex)
      // Add index
      addLast(pageIndex);
  }

  @override
  int pop() => removeLast();

  @override
  int peek() => last;
}
