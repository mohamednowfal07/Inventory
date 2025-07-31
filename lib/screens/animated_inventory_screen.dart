import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  @override
  _ImplicitAnimationsScreenState createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _toggled = false;
  bool _visible = true;
  bool _alignedTop = true;
  bool _padded = true;
  bool _expanded = true;
  bool _textStyled = true;
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Implicit Animation Demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _toggled = !_toggled;
                _visible = !_visible;
                _alignedTop = !_alignedTop;
                _padded = !_padded;
                _expanded = !_expanded;
                _textStyled = !_textStyled;
                _showFirst = !_showFirst;
              });
            },
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text("AnimatedContainer"),
              GestureDetector(
                onTap: () => setState(() => _toggled = !_toggled),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: _toggled ? 200 : 100,
                  height: _toggled ? 100 : 200,
                  decoration: BoxDecoration(
                    color: _toggled ? Colors.teal : Colors.amber,
                    borderRadius: BorderRadius.circular(_toggled ? 30 : 8),
                  ),
                  alignment: Alignment.center,
                  child: Text("Tap Me"),
                ),
              ),
              SizedBox(height: 20),
              Text("AnimatedOpacity"),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 80,
                  color: Colors.blueAccent,
                  child: Center(child: Text("Fade Me")),
                ),
              ),
              SizedBox(height: 20),
              Text("AnimatedAlign"),
              Container(
                height: 100,
                color: const Color.fromARGB(255, 253, 0, 0),
                child: AnimatedAlign(
                  alignment:
                      _alignedTop ? Alignment.topLeft : Alignment.bottomRight,
                  duration: Duration(milliseconds: 500),
                  child: FlutterLogo(size: 40),
                ),
              ),
              SizedBox(height: 20),
              Text("AnimatedPadding"),
              AnimatedPadding(
                duration: Duration(milliseconds: 400),
                padding: EdgeInsets.all(_padded ? 32 : 8),
                child: Container(
                  height: 50,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              SizedBox(height: 20),
              Text("AnimatedSize"),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
                child: Container(
                  color: Colors.orangeAccent,
                  height: _expanded ? 50 : 100,
                  width: double.infinity,
                  child: Center(child: Text("Resize Me")),
                ),
              ),
              SizedBox(height: 20),
              Text("AnimatedDefaultTextStyle"),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 400),
                style: _textStyled
                    ? TextStyle(fontSize: 24, color: Colors.black)
                    : TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                child: Text("Mohamed Nowfal"),
              ),
              SizedBox(height: 20),
              Text("AnimatedSwitcher"),
              Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: _showFirst
                      ? Container(
                          key: ValueKey(1),
                          width: 150,
                          height: 50,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text("First"),
                        )
                      : Container(
                          key: ValueKey(2),
                          width: 150,
                          height: 50,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Text("Second"),
                        ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            left: _toggled ? 30 : 200,
            top: _toggled ? 600 : 500,
            child: Container(
              width: 60,
              height: 60,
              color: Colors.indigo,
              child: Icon(Icons.star, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
