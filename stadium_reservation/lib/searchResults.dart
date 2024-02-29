import 'package:flutter/material.dart';
import 'Stadium.dart';

class StadiumResultsPage extends StatelessWidget {
  final List<Stadium> searchResults;

  const StadiumResultsPage({
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stadium Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Stadium stadium = searchResults[index];
          return InkWell(
            onTap: () {
              // Handle stadium tap
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: <Widget>[
                //  ClipRRect(
                //    borderRadius: BorderRadius.circular(15.0),
                 /*   child: Image.network(
                      stadium.imageUrl,
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),*/
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            stadium.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 10.0),
                          // Check if stadium.details is not null before displaying
                          stadium.description != null
                              ? Text(
                            stadium.description!,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                              : Text(
                            'Details not available',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
