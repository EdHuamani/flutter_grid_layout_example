import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildItem(CardItem item) => Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              item.icon,
              size: 42.0,
              color: Colors.purple,
            ),
            Text(
              item.title,
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: ClipPath(
              clipper: ArcClipper(50.0),
              child: Container(
                color: Colors.purple,
              ),
            ),
          ),
          Positioned(
            top: 58.0,
            left: 0.0,
            right: 0.0,
            child: Center(
                child: Text('GridLayout & CardView',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8.0,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0),
              itemCount: allItems.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildItem(allItems[index]),
            ),
          )
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  ArcClipper(this.height);

  ///The height of the arc
  final double height;

  @override
  Path getClip(Size size) {
    return _getBottomPath(size);
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - height);
    //Adds a quadratic bezier segment that curves from the current point
    //to the given point (x2,y2), using the control point (x1,y1).
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width, size.height - height);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    ArcClipper oldie = oldClipper as ArcClipper;
    return height != oldie.height;
  }
}

class CardItem {
  final IconData icon;
  final String title;

  CardItem({this.icon, this.title});
}

final List<CardItem> allItems = [
  CardItem(icon: FontAwesomeIcons.facebookF, title: 'Facebook'),
  CardItem(icon: FontAwesomeIcons.googlePlus, title: 'Google'),
  CardItem(icon: FontAwesomeIcons.linkedinIn, title: 'LinkedIn'),
  CardItem(icon: FontAwesomeIcons.twitterSquare, title: 'Twitter'),
  CardItem(icon: FontAwesomeIcons.instagram, title: 'Instagram'),
  CardItem(icon: FontAwesomeIcons.youtube, title: 'YouTube'),
];
