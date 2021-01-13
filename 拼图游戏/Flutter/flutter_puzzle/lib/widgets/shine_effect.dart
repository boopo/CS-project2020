import 'dart:math';

import 'package:flutter/material.dart';

class ShineEffect extends StatefulWidget {

	const ShineEffect({
		Key key,
		this.offset = Offset.zero,
		this.angle = pi/6,
		this.duration = const Duration(seconds: 3),
	}): super(key: key);

	final Offset offset;
	final double angle;
	final Duration duration;
  @override
  ShineEffectState createState() => new ShineEffectState();
}

class ShineEffectState extends State<ShineEffect> with SingleTickerProviderStateMixin{

	List<Color> colors;
	List<double> stops;
	AnimationController _controller;

	@override
	void initState() {
		super.initState();
		super.initState();
		colors = [
			Colors.white24,
			Colors.white38,
			Colors.white70,
			Colors.white38,
			Colors.white24,
		];
		stops = [
			0.1,
			0.3,
			0.5,
			0.7,
			0.9
		];

		_controller = AnimationController(duration: widget.duration, vsync: this);

		_controller
			..addListener((){
				setState(() => {});
			})
		 ..repeat();
	}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){

	    return Stack(
		    children: <Widget>[
			    Positioned(
				    left: _controller.value * (constraints.maxWidth + widget.offset.dx + constraints.maxHeight * tan(widget.angle)),
				    top: -widget.offset.dy - 20 * sin(widget.angle),
				    child: Container(
					    transform: Matrix4.rotationZ(widget.angle),
					    decoration: BoxDecoration(
						    gradient: LinearGradient(
								    colors: colors,
								    stops: stops,
								    tileMode: TileMode.clamp
						    ),
					    ),
					    width: 20,
					    height: constraints.maxHeight + 20 * sin(widget.angle) * 3,
				    ),
			    ),
		    ],
	    );
    });
  }

	@override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}