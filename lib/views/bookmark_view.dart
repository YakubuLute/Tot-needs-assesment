import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmarkcontroller.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  final BookmarkService _bookmarkService = BookmarkService();
  final BookMarkController _bookMarkController = BookMarkController();
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmark'),
        ),
        body: FutureBuilder(
          future: _bookmarkService.getAllRecipe(),
          key: _key,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            List<RecipeModel> _recipeModels =
                snapshot.data as List<RecipeModel>;
            return ListView.builder(
              itemBuilder: (context, index) {
                RecipeModel recipeModel = _recipeModels[index];
                return ListTile(
                  leading: Image.network(
                    recipeModel.image,
                    width: 130,
                    height: 130,
                  ),
                  title: Text(recipeModel.title),
                  trailing: const Icon(Icons.delete),
                  onTap: () {
                    _bookMarkController.deleteBookMark(recipeModel.id);
                  },
                );
              },
              itemCount: _recipeModels.length,
            );
          },
        ));
  }
}
