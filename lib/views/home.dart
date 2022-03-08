import 'package:flutter/material.dart';
import 'package:google_sheet_db/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FeedbackModel> feedbacks = List<FeedbackModel>();

  getFeedbackFromSheet() async {
    var raw = await http.get(
        "https://script.google.com/macros/s/AKfycbxk9seTxVxsgWLM_eBQlaJ3dHvAVpCZidh8apLS4gBjOO5YvAIOPANOrCRMjgFefyspDw/exec");
//https://script.google.com/macros/s/AKfycbxk9seTxVxsgWLM_eBQlaJ3dHvAVpCZidh8apLS4gBjOO5YvAIOPANOrCRMjgFefyspDw/exec
    var jsonFeedback = convert.jsonDecode(raw.body);
    print('this is json Feedback $jsonFeedback');

    feedbacks = jsonFeedback.map((json) => FeedbackModel.fromJson(json));

    jsonFeedback.forEach((element) {
      print('$element THIS IS NEXT>>>>>>>');
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.timestamp = element["timestamp"];
      feedbackModel.typeapt = element["typeapt"];
      feedbackModel.dateapt = element["dateapt"];
      feedbackModel.resultapt = element["resultapt"];
      feedbackModel.notes = element["notes"];

      feedbacks.add(feedbackModel);
  
    });

    //print('${feedbacks[0]}');
  }

  @override
  void initState() {
    getFeedbackFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return FeedbackTile(
                timestamp: feedbacks[index].timestamp,
                typeapt: feedbacks[index].typeapt,
                dateapt: feedbacks[index].dateapt,
                resultapt: feedbacks[index].resultapt,
                notes: feedbacks[index].notes
              );
            }),
      ),
    );
  }
}

class FeedbackTile extends StatelessWidget {
  final String timestamp, typeapt, dateapt, resultapt, notes;
  FeedbackTile(
      {this.timestamp, this.typeapt, this.dateapt, this.resultapt, this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Image.network(resultapt))),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(typeapt),
                  Text(
                    'from',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(dateapt)
        ],
      ),
    );
  }
}
