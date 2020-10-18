///importing...
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as m;

///Vector3 
class Vec3{
  ///x,y,z
  final double x,y,z;  
  ///Constructor
  const Vec3(this.x,this.y,this.z);
}

///Rotation
class Rotation{
  ///Rotation Axis
  final Vec3 axis;
  ///Angle (in Radian)
  final double angle;
  ///Constructor
  const Rotation(this.angle,{this.axis=const Vec3(0, 0, 1)});  
}

///PageTransitionView
class PageTransitionView extends StatefulWidget {
  ///controller of PageView
  final PageController controller;
  ///Key of PageView
  final Key key;
  ///scrollDirection of PageView
  final Axis scrollDirection;
  ///reverse of PageView
  final bool reverse;
  ///physics of PageView
  final ScrollPhysics physics;
  ///pageSnapping of PageView
  final bool pageSnapping;
  ///onPageChanged of PageView
  final ValueChanged<int> onPageChanged;
  ///itemBuilder of PageView
  final IndexedWidgetBuilder itemBuilder; 
  ///itemCount of PageView
  final int itemCount;
  ///dragStartBehavior of PageView
  final DragStartBehavior dragStartBehavior;
  ///allowImplicitScrolling of PageView
  final bool allowImplicitScrolling;
  ///toPrev,toNext of PageTransitionView
  final List Function(double extra,Offset scale,Offset offset,Rotation rotation) toPrev, toNext;
  ///scale,offset of PageTransitionView
  final Offset scale,offset;
  ///rotation of PageTransitionView
  final Rotation rotation;
  ///direction of PageTransitionView
  final int direction;

  ///Constructor
  PageTransitionView({this.toPrev,this.toNext,this.direction = 0,this.scale = const Offset(1.0,1.0),this.offset = const Offset(0.0,0.0),this.rotation = const Rotation(0.0,axis: Vec3(0, 0, 1)),this.key,this.scrollDirection = Axis.horizontal, this.reverse = false, this.controller, this.physics, this.pageSnapping: true, this.onPageChanged, this.itemBuilder, this.itemCount, this.dragStartBehavior = DragStartBehavior.start, this.allowImplicitScrolling = false,});
  @override
  _PageTransitionViewState createState() => _PageTransitionViewState();
}

///State of PageTransitionView
class _PageTransitionViewState extends State<PageTransitionView> {
  ///Scale
  Offset scale;
  ///Offset
  Offset offset;
  ///Rotation
  Rotation rotate;
  ///Next
  int _next = 1;
  ///Prev
  int _prev = -1;
  ///Direction
  int _direction;
  ///Controller
  PageController _controller;
  
  ///initState
  @override
  void initState(){
    super.initState();
    initialize();
  }

  ///didUpdateWidget
  void didUpdateWidget(oldWidget){
    initialize();
    super.didUpdateWidget(oldWidget);
  }

  ///initialize
  void initialize(){
    scale = widget.scale;
    offset = widget.offset;
    rotate = widget.rotation;
    _direction = widget.direction;

    if(widget.controller == null){
      _controller = PageController();
    }
    else{
      _controller = widget.controller;
    }

    _controller.addListener(() {
      double page = _controller.page;
      double extra = page-page.floor();

      if(extra == 0){
        _next = page.floor()+1;
        _prev = _next - 2;
        scale = widget.scale;
        offset = widget.offset;
        rotate = widget.rotation;
        setState(() { });
        return;
      }

      int next = page.floor()+1;
      bool is_prev = false;
      if(next<_next){
        is_prev = true;
      }
      next = (_direction == 0?(is_prev?next+1:next):(_direction==1?next:next+1));
      int prev = next-2;

      if(widget.toNext == null && widget.toPrev == null){
        scale = Offset(1.0,1.0) * (_direction == 0?(is_prev?1-extra:extra):(_direction==1?extra:1-extra));
      }
      else{
        if(widget.toNext != null && _direction!=-1 && !is_prev){
          List myList = widget.toNext(extra,scale,offset,rotate);
          scale = myList[0];
          offset = myList[1];
          rotate = myList[2];
        }
        if(widget.toPrev != null && _direction!=1 && is_prev){
          List myList = widget.toPrev(1-extra,scale,offset,rotate);
          scale = myList[0];
          offset = myList[1];
          rotate = myList[2];
        }
      }

      setState(() {
        _next = next;
        _prev = prev;
      });
    });    
  }

  ///dispose
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  ///Main Build Method
  @override
  Widget build(BuildContext context) {
    Matrix4 _transform = (Matrix4.identity()..scale(scale.dx,scale.dy)..translate(offset.dx,offset.dy)..rotate(m.Vector3(rotate.axis.x,rotate.axis.y,rotate.axis.z),rotate.angle));
    return PageView.builder(
      key: widget.key,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      physics: widget.physics, 
      pageSnapping: widget.pageSnapping,
      onPageChanged: widget.onPageChanged,
      itemBuilder: (context,index){
        return Transform(alignment: Alignment.center,transform: (_next!=index && _prev!=index)?(Matrix4.identity()):_transform,child:
          widget.itemBuilder(context,index));
      },
      itemCount: widget.itemCount,
      dragStartBehavior: widget.dragStartBehavior,
      allowImplicitScrolling: widget.allowImplicitScrolling,
      controller: _controller,
      );
  }
}