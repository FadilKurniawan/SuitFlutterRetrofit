import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/models/place.dart';
import 'package:jasamarga_nde_flutter/modules/sample_place/place_page.dart';

class PlacesWidget {
  static Widget list(List<Place> places, BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        final placeProfile = null;
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: placeProfile != null
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(placeProfile.image)),
                        borderRadius: BorderRadius.circular(6)),
                    width: 70,
                  )
                : Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    width: 70,
                  ),
            title: Text(place.name, style: Theme.of(context).textTheme.headline1,),
            subtitle: Text(place.address),
            isThreeLine: true,
            onTap: () {
              PlacePage.show(context, place.id);
            },
          ),
        );
      },
    );
  }
}
