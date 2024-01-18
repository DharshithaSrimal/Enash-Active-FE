import 'package:flutter/material.dart';
import 'package:stadium_reservation/stadiumPage.dart' as stadium;
import 'package:stadium_reservation/stadiumPage.dart';

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
              _navigateToStadiumInfoPage(context, stadium);
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      stadium.imageUrl,
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          Text(
                            stadium.details,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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

  void _navigateToStadiumInfoPage(BuildContext context, Stadium stadium) {
    // Replace StadiumInfoPage with your actual page.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StadiumInfoPage(imageUrl: stadium.imageUrl, name: stadium.name,),
      ),
    );
  }
}



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StadiumResultsPage(
        searchResults: [
          Stadium(
            name: 'Stadium 1',
            imageUrl:
            'https://images.unsplash.com/photo-1521537634581-0dced2fee2ef?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YmFkbWludG9uJTIwY291cnR8ZW58MHx8MHx8fDA%3D',
            details: 'City X, District A, Date: 2024-01-06, Time: 12:00 PM - 3:00 PM',
          ),
          Stadium(
            name: 'Stadium 2',
            imageUrl:
            'https://images.unsplash.com/photo-1611630483685-472d017cbb4f?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            details: 'City X, District A, Date: 2024-01-06, Time: 2:00 PM - 5:00 PM',
          ),
          Stadium(
            name: 'Stadium 3',
            imageUrl:
            'https://images.unsplash.com/photo-1626926938421-90124a4b83fa?q=80&w=1951&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            details: 'City C, District B, Date: 2024-12-03, Time: 4:00 PM - 7:00 PM',
          ),
        ],
      ),
    ),
  );
}
