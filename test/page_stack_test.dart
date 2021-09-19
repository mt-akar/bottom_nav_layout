import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter_test/flutter_test.dart';

/// - Start at page 0
/// - Navigate to page 1
/// - Navigate to page 2
/// - Navigate to page 1
/// - Press back button
/// - Navigate to page 0
/// - Press back button
void main() {
  test('StandardPageStack test', () {
    final pageStack = StandardPageStack(initialPage: 0);

    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 2);

    pageStack.push(2);
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 3);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 4);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 3);

    pageStack.push(0);
    expect(pageStack.peek(), 0);
    expect(pageStack.length, 4);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 3);
  });

  test('ReorderToFrontPageStack test', () {
    final pageStack = ReorderToFrontPageStack(initialPage: 0);

    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 2);

    pageStack.push(2);
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 3);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 3);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 2);

    pageStack.push(0);
    expect(pageStack.peek(), 0);
    expect(pageStack.length, 2);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 1);
  });

  test('ReorderToFrontExceptFirstPageStack test', () {
    final pageStack = ReorderToFrontExceptFirstPageStack(initialPage: 0);

    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 2);

    pageStack.push(2);
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 3);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 3);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 2);

    pageStack.push(0);
    expect(pageStack.peek(), 0);
    expect(pageStack.length, 3);

    pageStack.pop();
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 2);
  });

  test('NoPageStack test', () {
    final pageStack = NoPageStack(initialPage: 0);

    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 1);

    pageStack.push(2);
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 1);

    pageStack.pop();
    expect(pageStack.length, 0);
  });

  test('FirstAndLastPageStack test', () {
    final pageStack = FirstAndLastPageStack(initialPage: 0);

    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 2);

    pageStack.push(2);
    expect(pageStack.peek(), 2);
    expect(pageStack.length, 2);

    pageStack.push(1);
    expect(pageStack.peek(), 1);
    expect(pageStack.length, 2);

    pageStack.pop();
    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    expect(() => pageStack.push(0), throwsA(isA<Exception>()));
    expect(pageStack.peek(), 0);
    expect(pageStack.length, 1);

    pageStack.pop();
    expect(pageStack.length, 0);
  });
}
