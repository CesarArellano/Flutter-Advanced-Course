part of './widgets.dart';

class BtnMyRoute extends StatelessWidget {
  const BtnMyRoute({super.key});


  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: () {
            mapBloc.add(OnMarkRoute());
          },
        )
      ),
    );
  }
}