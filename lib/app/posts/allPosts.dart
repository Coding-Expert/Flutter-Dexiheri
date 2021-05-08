import 'dart:convert';

import 'package:dexiheri/app/models/single_post.dart';
import 'package:dexiheri/app/posts/ui/overlayed_container.dart';
import 'package:dexiheri/app/posts/ui/post_container.dart';
import 'package:dexiheri/app/posts/wp-api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:dexiheri/global.dart';
import 'package:dexiheri/app/posts/singlePost.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;

final _root = 'https://dexiheri.gr'; //replace with your site url
final wp.WordPress wordPress = wp.WordPress(baseUrl: _root);

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

List<SinglePost> parsePosts(response) {
  final parsed = jsonDecode(response)['posts'].cast<Map<String, dynamic>>();
  return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
}

Future<List<SinglePost>> _getPosts() async {
  final response = await http.get(baseUrl);
  return compute(parsePosts, response.body);
}

class _PostsScreenState extends State<PostsScreen> {
  Future<List<SinglePost>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _getPosts();
    //this.getPosts();
  }

  Future<String> getPosts() async {
    var res = await fetchPosts();
    setState(() {
      posts = res;
    });
    return "Success!";
  }

  List<wp.Post> posts;
  Future<List<wp.Post>> fetchPosts() async {
    var posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        postStatus: wp.PostPageStatus.publish,
        orderBy: wp.PostOrderBy.date,
        order: wp.Order.desc,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
      fetchCategories: true,
      fetchTags: true,
      postType: "posts",
    );
    return posts;
  }

  Widget buildPost(int index) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              buildImage(index),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(posts[index].title.rendered)),
                  subtitle: Text(posts[index].excerpt.rendered),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildImage(int index) {
    if (posts[index].featuredMedia == null) {
      return Image.network(
        'https://mozartec.com/wp-content/uploads/2019/04/asp-dot-net-core.jpg',
      );
    }
    return Image.network(
      posts[index].featuredMedia.mediaDetails.sizes.medium.sourceUrl,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dexiheri Blog'),
        centerTitle: true,
      ),
      body:Container(
          child: FutureBuilder(
            future: fetchWpPosts(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error"),
                  ),
                );
              }
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      Map wppost = snapshot.data[index];
                      return PostTile(href: wppost['_links']['wp:featuredmedia'][0]['href'],
                          title: wppost['title']['rendered'].replaceAll("#038;",""),
                          desc: wppost['excerpt']['rendered'],
                          content: wppost['content']['rendered']);
                    }
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
    );

    /*Scaffold(
      appBar: AppBar(
        title: Text('Dexiheri Blog'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts == null ? 0 : posts.length,
        itemBuilder: (BuildContext context, int index) {
          return buildPost(index); //Building the posts list view
        },
      ),
    );*/
    /*SafeArea(
      child: FutureBuilder<List<SinglePost>>(
        future: fetchWpPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "Dexiheri Blog",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.black),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        "${snapshot.data[0].avatarURL}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              *//*body: ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: PageView.builder(
                      controller: PageController(viewportFraction: .76),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) => OverlayedContainer(
                        authorAvatar: "${snapshot.data[i].avatarURL}",
                        author: "${snapshot.data[i].authorName}",
                        image: "${snapshot.data[i].featuredImage}",
                        title: "${snapshot.data[i].title}",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostScreen(postData: snapshot.data[i]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "All Posts",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, i) => PostContainer(
                            author: "${snapshot.data[i].authorName}",
                            image: "${snapshot.data[i].featuredImage}",
                            title: "${snapshot.data[i].title}",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostScreen(postData: snapshot.data[i]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),*//*
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );*/
  }
}


class PostTile extends StatefulWidget {
  final String href, title, desc, content;

  const PostTile({Key key, this.href, this.title, this.desc, this.content}) : super(key: key);
  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  var imageUrl = "";

  Widget shortDescriptionView(){
    return Html(
      data: widget.desc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(
        imageUrl: imageUrl,
        title: widget.title,
        desc: widget.content,
      )));
    },
    child:Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: fetchWpPostImageUrl(widget.href),
              builder: (context, snapshot){
              if(snapshot.hasData){
                imageUrl = snapshot.data['guid']['rendered'];
                return Image.network(snapshot.data['guid']['rendered']);
              }
              return CircularProgressIndicator();
              }),
          SizedBox(height: 8),
          Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 5),
          shortDescriptionView(),
        ],
      ),
    )
    );
  }
}