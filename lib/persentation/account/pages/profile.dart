import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String name;
  final String email;
  final List<String> dataList;

  const Profile({required Key key, required this.name, required this.email, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: $name'),
        Text('Email: $email'),
        const Text('Data List:'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dataList[index]),
            );
          },
        ),
      ],
    );
  }
}
