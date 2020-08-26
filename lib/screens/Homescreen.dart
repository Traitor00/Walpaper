import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:walpaper/Jsonclass/class.dart';
import 'package:walpaper/Response/httpresponse.dart';
import 'package:walpaper/default%20widget/appbar.dart';

class Wallscreen extends StatefulWidget {
  @override
  _WallscreenState createState() => _WallscreenState();
}

class _WallscreenState extends State<Wallscreen> {
  Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.perPage,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        child: Hero(
                            tag: snapshot.data.photos[index],
                            child: FadeInImage(
                                placeholder: AssetImage("assets/india.jpg"),
                                image: NetworkImage(
                                    "snapshot.data.photos[index]"))),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
