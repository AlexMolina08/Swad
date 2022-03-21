import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/navigation_providers/navbar_visibility_provider.dart';
import 'package:untitled/providers/search_providers/search_provider.dart';
import 'package:untitled/states/search_state.dart';
import 'package:untitled/utilities/constants.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage();

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  /// ---
  var usersGrids = [];
  late ScrollController _controller;

  void initializeScrollController() {
    _controller = ScrollController();

    /// inicializar scrollcontroller

    /// Listener para comprobar direccion scroll user y actualizar visibilidad
    /// navBar
    _controller.addListener(
      () {
        if (_controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          /// scrolling up
          ref.read(navBarVisibilityProvider).hide();
        }
        if (_controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          /// scrolling down
          ref.read(navBarVisibilityProvider).show();
        }
      },
    );
  }

  @override
  void initState() {
    initializeScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchState searchState = ref.watch(searchNotifierProvider);

    /// Se llama a findUserProvider para obtener coincidencias con el filtro actual
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          ExploreAppBar(
            onSubmitted: (String currentFilter) async {
              /// limpiar buffer con la lista visible (usersGrid)
              if (usersGrids.isNotEmpty) usersGrids.clear();

              /// Llamar a Find en la API
              await ref
                  .read(searchNotifierProvider.notifier)
                  .find("0", "0", currentFilter);
            },
          ),
          SliverToBoxAdapter(
              child: (searchState is SearchLoaded)
                  ? Text(
                      "NumUsers: ${searchState.numUsers},UsersGridCount:${usersGrids.length}")
                  : Text('')),
          showSearchView(searchState),
          SliverToBoxAdapter(
              child: loadModeButton(searchState) ??
                  Container(
                    width: 0,
                  )),
        ],
      ),
    );
  }

  /// Comprobar el estado actual de la búsqueda y devolver widget adecuado
  Widget showSearchView(SearchState state) {
    switch (state.runtimeType) {
      case SearchLoading:
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

      case SearchError:
        return const SliverToBoxAdapter(
          child: Center(
            child: Icon(Icons.error_outline_sharp),
          ),
        );

      case SearchLoaded:
        var searchResult = state as SearchLoaded;

        if (searchResult.users.isNotEmpty) {
          if (usersGrids.isEmpty) {
            /// comprobar si la lista está vacia y su tamaño
            if (searchResult.numUsers < kUsersPerPage) {
              /// añadir todos los usuarios a la lista de grids
              usersGrids = List<dynamic>.from(searchResult.users);
            } else {
              /// añadir los n primeros usuarios a la lista de grids
              usersGrids = List<dynamic>.from(searchResult.users)
                  .sublist(0, kUsersPerPage);
            }
            setState(() {});
          }

          /// SLIVER GRID
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height) *
                  1.4,
            ),

            /// metodo para renderizar cada elemento de la lista en el gridview
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index < usersGrids.length) {
                var user = User.fromJson(usersGrids[index]);

                return UserGrid(user: user);
              }
            }, childCount: usersGrids.length + 1),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Text("Nada por aquí"),
          );
        }

      ///##################################################################
      ///##################################################################

      default:
        return const SliverToBoxAdapter(
          child: Text("Busca a un estudiante o profesor"),
        );
    }
  }

  Widget? loadModeButton(SearchState state) {
    if (state is SearchLoaded && usersGrids.length < state.numUsers) {
      return Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: TextButton(
            onPressed: () {
              /// comprobar si quedan grids por mostrar
              int itemsLeft = state.numUsers - usersGrids.length;

              /// añadir más items a la vista (dependiendo de los que falten añadirlos todos
              /// o kUsersPerPage)
              List<dynamic> nextItems;

              if (itemsLeft < kUsersPerPage) {
                nextItems = List<dynamic>.from(state.users)
                    .sublist(usersGrids.length - 1);

                print("ITEMS::: ${nextItems.runtimeType}");
              } else {
                nextItems = List<dynamic>.from(state.users).sublist(
                    usersGrids.length - 1,

                    /// inicio
                    (usersGrids.length - 1) + kUsersPerPage);

                /// fin

                print("ITEMS::: ${nextItems.runtimeType}");
              }

              usersGrids.insertAll(usersGrids.length, nextItems);

              setState(() {});
            },
            child: const Text("Cargar más", style: kLoadMoreTextStyle),
          ),
        ),
      );
    }
  }
}

class UserGrid extends StatelessWidget {
  const UserGrid({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 0.15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.4,
              blurRadius: 0.4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                user.photoUrl != null
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(user.photoUrl),
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('resources/no_user_photo.png'),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
