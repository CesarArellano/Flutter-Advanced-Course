part of 'helpers.dart';

void calculatingAlert( BuildContext context ) {
  if( Platform.isAndroid ) {
    showDialog(
      context: context, 
      builder: ( _ ) => const AlertDialog(
        title: Text('Please Wait'),
        content: Text('Calculating route'),
      )
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: ( _ ) => const CupertinoAlertDialog(
        title: Text('Please Wait'),
        content: CupertinoActivityIndicator()
      )
    );
  }
}