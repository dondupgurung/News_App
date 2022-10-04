

import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/Widgets/tab_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Widgets/web_view.dart';
import 'package:get/get.dart';






class mainScreen extends StatelessWidget {


  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const TabBar(
              tabs: [
                Tab(text: 'Politics',),
                Tab(text: 'Sports',),
                Tab(text: 'Gaming',)
              ],
            ),
          ),

          body: Column(

            children: [
              Container(
                height: 200,

                child: TabBarView(
                  children: [
                    TabBarWidget('news'),
                    TabBarWidget('premierleague'),
                    TabBarWidget('pubg')
                  ],
                ),

              ),
              const SizedBox(height: 2,),
              Consumer(
                  builder: (context, ref, child) {
                    final newsData = ref.watch(searchProvider);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      child: Column(
                        children: [
                          TextFormField(
                            controller:searchController,
                            onFieldSubmitted: (val){
                              ref.read(searchProvider.notifier).searchNews(val);
                              searchController.clear();
                            },
                            decoration: const InputDecoration(
                                fillColor: Colors.grey,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Search News',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5)
                            ),
                          ),
                          SizedBox(height: 5,),


                          newsData.isEmpty ? Container(
                            child: Text('Loading....'),
                          )
                              : newsData[0].title == 'No matches for your search.' ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 40,),
                                ElevatedButton(onPressed:(){
                                  ref.refresh(searchProvider.notifier);
                                },
                                    child: Text('Reload')),
                                Text('No matches for your search.')
                              ],
                            ),
                          )
                              
                              :Container(
                            height: 440,
                            color: Colors.white12,

                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: newsData.length,
                              itemBuilder: (context, index) {
                                final dat = newsData[index];

                                return InkWell(
                                  onTap: (){
                                   Get.to(() => WebDetail(dat.link), transition: Transition.leftToRight);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10, top: 8, bottom: 5),
                                    width: 200,
                                    height: 200,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(imageUrl: dat.media, fit: BoxFit.fill, height: 170,width: 130,errorWidget: (ctx, d, string) => Image.asset('assets/noimg.jpg'), ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(child: Column(
                                          children: [
                                            Text(dat.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 3,),

                                            Text(dat.summary, maxLines: 7, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.blueGrey)),
                                            Text(dat.author,style: TextStyle(color: Colors.lightBlue)),
                                          ],
                                        ))

                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                          )
                        ],
                      ),);
                  }

              )

            ],
          ),
        ));
  }

}
