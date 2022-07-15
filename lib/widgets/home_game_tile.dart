import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/consts/k_colors.dart';
import 'package:one_to_ten_game/providers/games_provider.dart';

class HomeGameTile extends ConsumerWidget {
  final String title;
  final String prefixSubtitle;
  final String suffixSubtitle;
  final String backgroundImageAssetUrl;
  final String? routePath;
  const HomeGameTile({this.routePath, required this.title, required this.prefixSubtitle, required this.suffixSubtitle, required this.backgroundImageAssetUrl,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(gamesProvider.notifier);
    return InkWell(
      onTap: (){
        if(routePath != null){
          Navigator.of(context).pushReplacementNamed(routePath!);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.srcOver),
            fit: BoxFit.cover,
            image: Image.asset(backgroundImageAssetUrl).image
          ),
          border: Border.all(width: 3, color: KColors.mainAccent)
        ),
        child: Stack(
          children: [
            Center(
              child: Text(title, style: TextStyle(color: KColors.white, fontSize: 36, fontWeight: FontWeight.bold),),
            ),
            Align(alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Row(children: [
                Text(prefixSubtitle, style: TextStyle(color: KColors.mainAccent),),
                Spacer(),
                Text(suffixSubtitle, style: TextStyle(color: KColors.mainAccent),),
              ],),
            ),)
          ],
        ),
      ),
    );
  }
}
