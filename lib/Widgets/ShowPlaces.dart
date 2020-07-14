import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Places_List.dart';

class ShowPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Places>(
      builder: (context, data, ch) => data.places.length == 0
          ? ch
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.file(
                              data.places[index].image,
                              fit: BoxFit.cover,
                              height: 250,
                              width: double.infinity,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            bottom: 10,
                            child: Container(
                              width: 380,
                              color: Colors.black54,
                              child: Text(
                                data.places[index].title,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              ),
//                      decoration: BoxDecoration(
//                        border: Border.all(color: Colors.grey, width: 1),
//                      ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: data.places.length,
            ),
      child: Center(
        child: Text('No Places Yet!Start Adding Some!'),
      ),
    );
  }
}
