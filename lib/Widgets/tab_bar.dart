
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/Widgets/web_view.dart';
import 'package:get/get.dart';

class TabBarWidget extends StatelessWidget {

  final String query;
  TabBarWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context,ref,child){
    final newsData = ref.watch(newsProvider(query));
    return newsData.when(
        data: (data){
          return ListView.builder(

            scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
            final dat= data[index];
            return InkWell(
              onTap: (){
                Get.to(() => WebDetail(dat.link), transition: Transition.leftToRight );
              },
              child: Container(
                padding: EdgeInsets.only(left: 8,top: 8,bottom: 2),
                width: 200,
                height: 300,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(imageUrl:dat.media, fit: BoxFit.cover,height: 130,errorWidget: (ctx, d, string) => Image.asset('assets/noimg.jpg')),
                    ),
                    Text(dat.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    Text(dat.author)
                  ],
                ),
              ),
            );
          });
        },
        error: (err,stack) => Text('$err'),
        loading:() => Transform.scale(scale:0.1,child: CircularProgressIndicator()));
    });


  }
}
