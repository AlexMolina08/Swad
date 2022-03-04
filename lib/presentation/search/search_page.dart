import 'package:flutter/material.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/utilities/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _currentSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            ExploreAppBar()
          ],
        ),
      )
    );
  }
}
