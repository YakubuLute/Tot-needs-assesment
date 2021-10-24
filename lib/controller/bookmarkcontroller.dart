import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

class BookMarkController {
  BookmarkService bookMarkService = BookmarkService();

  Future<List<RecipeModel>> getUserBookMarkRecipe() async {
    try {
      await bookMarkService.open();
      var bookmark = await bookMarkService.getAllRecipe();
      if (bookmark != null) {
        await bookMarkService.close();
      }
    } catch (error) {
      //if error
      print("Something went wrong $error");
    }
    await bookMarkService.close();
    return [];
  }

  addBookMark(RecipeModel recipeModel) async {
    try {
      await bookMarkService.open();
      bookMarkService.insert(recipeModel);
      await bookMarkService.close();
    } catch (error) {
      //if error
      print("Something went wrong $error");
    }
  }

  deleteBookMark(id) async {
    try {
      await bookMarkService.open();
      bookMarkService.delete(id);
      await bookMarkService.close();
    } catch (error) {
      //if error
      print("Something went wrong $error");
    }
  }
}
