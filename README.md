# page_transition_view
[![pub package](https://img.shields.io/pub/v/page_transition_view.svg)](https://pub.dartlang.org/packages/page_transition_view)

PageTransitionView - Used To Create PageView With Page Transition Effects.

## preview
<img src="https://raw.githubusercontent.com/RutvikRana/page_transition_view/main/video_example/giffy.gif" alt="Example App" width="300" height="450">

## Installation
Follow Installation guide of Pub.dev

## Syntax

      PageTransitionView({
            this.toPrev,                                     //What To Do On Previous Page?
            this.toNext,                                     //What To Do On Next Page?
            this.direction = 0,                              //Direction Of Transition. 1 = Next, -1 = Prev, 0 = Both
            this.scale = const Offset(1.0,1.0),              //Fixed Initial Scale Of Pages
            this.offset = const Offset(0.0,0.0),             //Fixed Initial Position Of Pages
            this.rotation = const Rotation(0.0,              //Fixed Initial Rotation Of Pages
                  axis: Vec3(0, 0, 1)),

            this.key,                                        // All PageView Options...             
            this.scrollDirection = Axis.horizontal, 
            this.reverse = false, 
            this.controller,
            this.physics, 
            this.pageSnapping: true, 
            this.onPageChanged, 
            this.itemBuilder, 
            this.itemCount, 
            this.dragStartBehavior = DragStartBehavior.start, 
            this.allowImplicitScrolling = false,

      });

## How To Do?

1. Set Initial Scale, Offset, Rotation. (Optional)
   This Will Apply To Every Pages.
2. Set The Direction Of Transition (Optional, Default is 0 means BiDirectional)
3. 
```
      toPrev / toNext : (extra, scale, offset, rotation){
      //extra is Transition Factor... range from (0,1)..... 0 = Page Transition Start, 1 = Transition End ( Changed To New Page )
      //scale, offset, rotation Are RealTime Values of Page Transformation. Usually We Dont Need To Use It.
            
      //Now Make Changes In Transformation.
      scale = Offset(1.0, 1.0) * extra;
            
      //return Changed Values as List.
      return [scale, offset, rotation];
      }
 ```
4. Use toNext For Direction = 1, toPrev For Direction = -1, Both For Direction = 0. If You Leave Both Null Then Default Scale Transition Occurs.

## Example
```
class _HomeState extends State<Home> {
  List<Color> colors = [Colors.red,Colors.pink,Colors.yellow,Colors.blue,Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PageTransitionView Example"),),
      body: Container(
        color: Colors.black,
        child: PageTransitionView(
          direction: 0,
          toNext: (extra, scale, offset, rotation) {
            scale = Offset(1.0,1.0) * (extra);
            offset = Offset(500.0,700.0) * (1-extra);
            rotation = Rotation(2*pi*(1-extra));
            return [scale,offset,rotation];
          },
          toPrev: (extra, scale, offset, rotation) {
            scale = Offset(1.0,1.0) * (extra);
            offset = Offset(-500.0,-700.0) * (1-extra);
            rotation = Rotation(2*pi*extra);
            return [scale,offset,rotation];
          },
          itemCount: 10,
          itemBuilder: (c,index){
            return Container(
                  color: colors[index%colors.length],
                  child: Center(
                        child: SizedBox(width: 100,height: 100,
                              child: FittedBox(
                                    child: Text("$index")),),));
            },
          ),
        ),
    );
  }
 ```

## Contact Me

I Am Rutvik Rana, Medical Student cum Passionate Coder, Invite You To My [Coding(noob to pro)](https://t.me/coding_noob_to_pro) Channel.
