///
///
/// Grid View con los usuarios obtenidos de una búsqueda
/// Recibe un searchState
///
///

import 'package:flutter/material.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/states/search_state.dart';


class MatchesGrid extends StatelessWidget {
  final SearchState searchState;
  const MatchesGrid({
    required this.searchState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardHeight = size.height;
    final double cardWidth = size.width;
    var numUsers;
    List<dynamic> usersMatchedList;

    /// si la búsqueda ha sido exitosa , obtener el numero de usuarios
    /// y la lista (puede estar vacía)
    if (searchState is SearchLoaded) {
      var loaded = searchState as SearchLoaded;
      numUsers = loaded.numUsers;
      usersMatchedList = loaded.users;

      /// En otro caso , devolver lista vacía
    } else {
      numUsers = 0;
      usersMatchedList = List.empty();
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (cardWidth / cardHeight) * 2,
      ),

      /// metodo para renderizar cada elemento de la lista en el gridview
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var user = User.fromJson(usersMatchedList[index]);

        return Container(
          child: GridTile(
              footer: Text(
                "${user.firstName} ${user.surName1} ${user.surName2}",
                textAlign: TextAlign.center,
              ),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: user.photoUrl != null
                      ?
                  Image.network(
                          user.photoUrl,
                          fit: BoxFit.contain,
                          width: cardWidth,
                          height: cardHeight,
                        )
                      : Image(
                          image: AssetImage('resources/no_user_photo.png'),
                          width: cardWidth / 5,
                          height: cardHeight / 5))),
        );
      }, childCount: numUsers),
    );
  }
}
