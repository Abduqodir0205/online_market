import 'package:flutter/material.dart';

class UserAcc extends StatelessWidget {
  const UserAcc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Assalomu aleykum, Xush kelibsiz! 👋'),
            const Text(
              'Abdusattorov Abduqodir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/user.jpg"),
        ),
      ],
    );
  }
}
