part of './widgets.dart';

class BtnFollowLocation extends StatelessWidget {
  const BtnFollowLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: ( context, state ) => _createBtn(context, state)
    );
  }

  Widget _createBtn(BuildContext context, MapState state) {
    
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            (state.followLocation)
            ? Icons.directions_run
            : Icons.accessibility_new, 
            color: 
            (state.followLocation)
            ? Colors.blue
            : Colors.black87,
          ),
          onPressed: () {
            mapBloc.add( OnFollowLocation() );
          },
        )
      ),
    );
  }
}