import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatelessWidget {
  static const routeName = "/placeList";
  const PlaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your places"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'add place',
              onPressed: () {
                Navigator.pushNamed(context, "/addPlace");
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlace>(context, listen: false)
              .fetchandSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlace>(
                  child: const Center(child: Text("Got no places to show")),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                      ? ch!
                      : ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                onTap: () {
                                  //go to detail path
                                },
                              ))),
        ));
  }
}
