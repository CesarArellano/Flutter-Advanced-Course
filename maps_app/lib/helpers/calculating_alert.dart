part of 'helpers.dart';

void calculatingAlert( BuildContext context ) {
  if( Platform.isAndroid ) {
    showDialog(
      context: context, 
      builder: ( _ ) => AlertDialog(
        title: Text('Please Wait'),
        content: Text('Calculating route'),
      )
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: ( _ ) => CupertinoAlertDialog(
        title: Text('Please Wait'),
        content: CupertinoActivityIndicator()
      )
    );
  }
}