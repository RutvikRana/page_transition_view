# lock_view
[![pub package](https://img.shields.io/pub/v/page_transition_view.svg)](https://pub.dartlang.org/packages/page_transition_view)

PageTransitionView - Used To Create PageView With Page Transition Effects.

## preview
<img src="https://raw.githubusercontent.com/RutvikRana/page_transition_view/tree/main/video_example/giffy.gif" alt="Example App" width="300" height="450">

## Installation
Follow Installation guide of Pub.dev

## Syntax

      LockView({
            this.width,                                                        //Width
            this.height,                                                       //Height
            this.password,                                                     //Password ex,[0,1,2,4,6,7,8] for Z pattern
            this.gridNumber = 3,                                               //GridNumber Default 3 means 3x3
            this.lineWidth = 5,                                                //Width Of Follow-Line                                                     
            this.circleRadius = 0.15,                                          //Radius Of Circles
            this.borderColor = Colors.black,                                   //BorderColor Of Circle
            this.normalColor = Colors.white,                                   //NormalColor Of Circle
            this.correctColor = Colors.green,                                  //Color When Unlocked
            this.incorrectColor = Colors.red,                                  //Color When Wrong Guess
            this.passColor = Colors.blue,                                      //Color When Circles Selected
            this.background = const BoxDecoration(                             //Background Decoration
                  color: Colors.white, 
                  boxShadow: [BoxShadow(blurRadius: 10)],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            this.lineDecoration=const BoxDecoration(                            //Line Decoration
                  color: Colors.grey,
                  boxShadow: [BoxShadow(blurRadius: 10)]),
            this.onEndPattern,                                                  //Called When DragEnd
            this.takePattern = false,                                           //Want To Take Pattern Instead?
            this.onEndTakePattern                                               //Called When DragEnd and takePattern=true
          });

**Note**: When takePattern = true, LockView Will Not Be Cleared After DragEnd, For Clear It, Change It By Parent SetState((){}) Callback.


## Example
```
class _HomeState extends State<Home> {
  bool unlock = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("LockView Example"),),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(padding: EdgeInsets.only(bottom: 30),child: SizedBox(height: 50,child: FittedBox(child: Text(unlock?"UnLocked":"Locked")))),
            
            LockView(
                  height: 300,
                  width: 300,
                  password: [0,1,2,4,6,7,8],
                  onEndPattern: (didUnlocked) {
                        setState(() {
                          unlock = didUnlocked;
                        });
                         if(didUnlocked){
                         Navigator.push(context, MaterialPageRoute(builder: (c)=>Scaffold(
                              appBar: AppBar(title: Text("Unlocked Content"),),
                              body: Center(child: Text("Unlocked",style: TextStyle(fontSize: 30),),),)));
                    }
                  },
            )],
          )
      )
    );
  }
```

## Contact Me

I Am Rutvik Rana, Medical Student cum Passionate Coder, Invite You To My [Coding(noob to pro)](https://t.me/coding_noob_to_pro) Channel.
