## 3.0.9
 - Sep 20, 2021
 - Docs updated.
 - Dart formats fixed.

## 3.0.0
 - Jul 16, 2021
 - In-page navigation is simplified.
   - `pages`, `pageBuilders` and `keys` parameters are combined into `pages` parameter. (breaking)
   - User don't need to create keys anymore.
   - Helper methods and documentation added for in-page navigation.
 - Bottom bar delegates are removed. (breaking)
   - Bottom navbar is created by the user, using a builder.
   - Removes a layer of adapters in between.
   - Removes all bottom bar dependencies.
 - Parameter defaults are changed to make the user more aware of their design choices.
   - `savePageState` default is change to false.
   - `pageStack` default is change to `NoPageStack` for iOS apps.
 - Page transition animations added.5
   - Use `pageTransitionData` parameter to add animations while changing the page.
 - State management inside the library and performance is improved.
 - Comprehensive documentation added.

## 2.1.0
 - Jul 13, 2021
 - `ReplacePageStack` renamed to `NoPageStack` (breaking)
 - `ReplaceExceptPageStack` renamed to `FirstAndLastPageStack` (breaking)
 - `bottomBarStyler` renamed to `bottomBarWrapper` (breaking)
 - Added `resizeToAvoidBottomInset` parameter.
 - Bar Designs included:
   - Convex Bottom Bar
   - Sliding Clipped Nav Bar
 
## 2.0.0
 - Jul 12, 2021
 - Alternative bottom bar usage API unified into `NavBarDelegate`s. (breaking)
 - Bar Designs included:
   - Flutter Snake Navigation Bar
   - Bottom Bar With Sheet
 
## 1.1.0
 - Jul 11, 2021
 - Bar Designs included:
   - Water Drop Bar
 
## 1.0.0
 - Jul 10, 2021
 - Added `extendBody` parameter.

## 0.0.1-dev
 - Jul 08, 2021
 - Main layout initial release. Features include:
   - Page State Preservation
   - Lazy Page Loading
   - Page Back Stack
   - In-Page Navigation Using GlobalKeys
   - Different Bar Designs (Material and Salomon)
   - Bar Styling
 - Bar Designs include:
   - Material
   - Salomon