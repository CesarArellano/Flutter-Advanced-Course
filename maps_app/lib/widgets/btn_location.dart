part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final myLocationBloc = BlocProvider.of<MyLocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final destination = myLocationBloc.state.location!;
            mapBloc.moveCamera(destination);
          },
        )
      ),
    );
  }
}