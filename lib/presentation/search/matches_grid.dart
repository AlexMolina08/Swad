///
///
/// Grid View usuarios
/// Recibe un searchLoaded el un scrollcontroller de su padre
/// Renderiza 10 usuarios en pantalla, si se llega al final del gridview,
/// renderizar 10 más
///
///

import 'package:flutter/material.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/states/search_state.dart';
import 'package:untitled/utilities/constants.dart';


class MatchesGrid extends StatefulWidget {

  SearchLoaded searchResult;
  int usersGridCount;

  MatchesGrid({
    required this.searchResult,
    required this.usersGridCount,
    Key? key,
  }) : super(key: key) {
    /// Nº de usersGrids inicialmente.
    /// si hay menos de los solicitados, inicializar al numero de usuarios
  }

  @override
  State<MatchesGrid> createState() => _MatchesGridState();
}

class _MatchesGridState extends State<MatchesGrid> {
  //var usersGridCount; /// Nº de usuarios mostrados por página


  @override
  void initState() {
    /// comprobar el numero de usuarios para saber si se pueden mostrar
    /// 18 (kUsersPerPage)
    if(widget.searchResult.numUsers < kUsersPerPage){
      setState(() {
        widget.usersGridCount = widget.searchResult.numUsers;
      });
    }else{
      setState(() {
        widget.usersGridCount = kUsersPerPage;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardHeight = size.height;
    final double cardWidth = size.width;
    List<dynamic> usersMatchedList;

    /// si la búsqueda ha sido exitosa , obtener el numero de usuarios
    /// y la lista (puede estar vacía)

    usersMatchedList = widget.searchResult.users;

    return usersMatchedList.isEmpty
        ? SliverToBoxAdapter(
            child: const Text("Nada por aquí"),
          )
        : SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
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
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                          )
                        : Image(
                            image: AssetImage('resources/no_user_photo.png'),
                            width: cardWidth / 5,
                            height: cardHeight / 5),
                  ),
                ),
              );
            }, childCount: widget.usersGridCount),
          );
  }
}
