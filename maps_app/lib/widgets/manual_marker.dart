part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 70,
          left: 20,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon( Icons.arrow_back, color: Colors.black87),
              onPressed: () {

              },
            )
          )
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -18),
            child: Icon( Icons.location_on, size: 50)
          )
        ),

        Positioned(
          bottom: 70,
          left: 30,
          child: MaterialButton(
            minWidth: width - 120,
            height: 45,
            child: Text('Confirm destination', style: TextStyle( color: Colors.white, fontSize: 16 )),
            color: Colors.black,
            elevation: 0,
            splashColor: Colors.transparent,
            shape: StadiumBorder(),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}