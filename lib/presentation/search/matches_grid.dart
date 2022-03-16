///
///
/// Grid View con los usuarios obtenidos de una búsqueda
/// Recibe un searchState
///
///

import 'package:flutter/material.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/states/search_state.dart';

class MatchesGrid extends StatefulWidget {
  final SearchLoaded searchState;
  const MatchesGrid({
    required this.searchState,
    Key? key,
  }) : super(key: key);

  @override
  State<MatchesGrid> createState() => _MatchesGridState();
}

class _MatchesGridState extends State<MatchesGrid> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardHeight = size.height;
    final double cardWidth = size.width;
    var numUsers;
    List<dynamic> usersMatchedList;

    /// si la búsqueda ha sido exitosa , obtener el numero de usuarios
    /// y la lista (puede estar vacía)

    numUsers = widget.searchState.numUsers ?? 0;
    usersMatchedList = widget.searchState.users;

    return usersMatchedList.isEmpty
        ? SliverToBoxAdapter(
            child: const Text("Nada por aquí"),
          )
        : SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (cardWidth / cardHeight) * 2,
            ),

            /// metodo para renderizar cada elemento de la lista en el gridview
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
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
                        ? Padding(
                      padding: EdgeInsets.all(20.0),
                          child: Image.network(
                              user.photoUrl,
                              fit: BoxFit.contain,
                              width: cardWidth,
                              height: cardHeight,
                            ),
                        )
                        : Image(
                            image: AssetImage('resources/no_user_photo.png'),
                            width: cardWidth / 5,
                            height: cardHeight / 5),
                  ),
                ),
              );
            }, childCount: numUsers),
          );
  }
}
