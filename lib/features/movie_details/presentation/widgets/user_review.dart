import 'package:flutter/material.dart';
import 'package:flutter_intro_bootcamp_project/features/movie_details/presentation/widgets/expandable_text.dart';

class UserReview extends StatefulWidget {
  const UserReview({super.key, required this.reviewDetails});

  final List<Map<String, dynamic>> reviewDetails;

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showAll = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<dynamic> reviewDetails = widget.reviewDetails;
    if (reviewDetails.isEmpty) {
      return SizedBox();
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('User Reviews', style: TextStyle(color: Colors.white, fontSize: 18))),
                GestureDetector(
                  onTap: () => setState(() => showAll = !showAll),
                  child: Row(
                    children: <Widget>[
                      !showAll
                          ? Text('All Reviews ${reviewDetails.length}', style: TextStyle(fontSize: 16))
                          : Text('Show Less', style: TextStyle(fontSize: 16)),
                      Icon(showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          showAll
              ? Column(
                children: List<Widget>.generate(
                  reviewDetails.length,
                  (int index) => Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage(reviewDetails[index]['avatarPhoto']), fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FittedBox(fit: BoxFit.scaleDown, child: Text(reviewDetails[index]['name'])),
                                        SizedBox(height: 5),
                                        Text(
                                          reviewDetails[index]['creationDate'],
                                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FittedBox(fit: BoxFit.scaleDown, child: Icon(Icons.star, color: Colors.yellow, size: 20)),
                                    SizedBox(width: 5),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        reviewDetails[index]['rating'],
                                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(children: <Widget>[Expanded(child: ExpandableText(text: reviewDetails[index]['review']))]),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage(reviewDetails[0]['avatarPhoto']), fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(fit: BoxFit.scaleDown, child: Text(reviewDetails[0]['name'])),
                                    SizedBox(height: 5),
                                    Text(reviewDetails[0]['creationDate'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FittedBox(fit: BoxFit.scaleDown, child: Icon(Icons.star, color: Colors.yellow, size: 20)),
                                const SizedBox(width: 5),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    reviewDetails[0]['rating'],
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(children: <Widget>[Expanded(child: ExpandableText(text: reviewDetails[0]['review']))]),
                    ],
                  ),
                ),
              ),
        ],
      );
    }
  }
}
