import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookMarkController with ChangeNotifier {
  //constructor
  BookMarkController();

  BookmarkService bookmarkService = BookmarkService();

  Future<List<RecipeModel>?> getAllBookMarks() async {
    try {
      await bookmarkService.open();
      List<RecipeModel>? recipies = await bookmarkService.getAllRecipe();
      if (recipies != null) {
        notifyListeners();
        await bookmarkService.close();
        return recipies;
      }
      return null;
    } catch (error) {
      await bookmarkService.close();
      print("Sorry, Something went wrong $error");
      return throw error;
    }
  }

  Future<bool> isBookmarked(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      RecipeModel? recipies = await bookmarkService.getRecipe(recipeModel.id!);
      notifyListeners();
      await bookmarkService.close();
      return recipies != null;
    } catch (error) {
      await bookmarkService.close();
      print("Something went wrong checking isBookmarked recipe $error");
      throw error;
    }
  }

  Future<RecipeModel?> addBookMark(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      RecipeModel recipe = await bookmarkService.insert(recipeModel);
      print('Added to boomarks: ${recipe.toJson()}');
      await getAllBookMarks();
      toast(msg: "Added to bookmarks");
      await bookmarkService.close();

      return recipe;
    } catch (error) {
      await bookmarkService.close();
      print("Something went wrong adding recipies $error");
      return null;
    }
  }

  Future<int> deleteBookMark(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      int deleteCount = await bookmarkService.delete(recipeModel.id!);
      print('Deleted $deleteCount recipies from boomarks');
      await getAllBookMarks();
      toast(msg: "Removed from bookmarks");
      await bookmarkService.close();
      return deleteCount;
    } catch (error) {
      await bookmarkService.close();
      print("Sorry something went wrong adding recipies $error");
      return 0;
    }
  }
}

void toast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}
