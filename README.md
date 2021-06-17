# bottom_nav_layout
A quick and powerful layout with
 - Bottom navigation bar
 - Navigation management
 - Page state preservation

# Installation
This package hasn't been released. Therefore the installiation is directly from github.
Add the following to your `pubspec.yaml` file.
```
  bottom_nav_layout:
    git:
      url: https://github.com/m-azyoksul/bottom_nav_layout.git
      ref: main
```

# Quick Start Example
```
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavLayout(
        pages: [
          Center(child: Text("Favorites")),
          Center(child: Text("Music")),
          Center(child: Text("Places")),
          Center(child: Text("News")),
        ],
        bottomNavBarDelegate: BottomNavBarDelegate(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
            BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          ],
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
```
