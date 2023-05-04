import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var allUsersQunatity = 0;

  @override
  void initState() {
    allUsersQunatity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var doc = snapshot.data!.docs;
                  return Text('All Users : ${doc.length.toString()}',style:const TextStyle(fontSize: 20),);
                }),
            const SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var doc = snapshot.data!.docs;

                    return ListView.builder(
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          var data = doc[index].data();
                          return Card(
                            child: ListTile(
                              // leading: CircleAvatar(
                              //   child: Image.network(data['profile']),
                              // ),
                              title: Text(data['email']),
                              subtitle: Text(data['user_name']),
                              trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(data['email'])
                                        .delete();
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
