import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  const UserReview({super.key, required this.reviewDetails});

  final List<Map<String, dynamic>> reviewDetails;

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showAll = false;
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
                Expanded(child: Text('User Reviews', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                GestureDetector(
                  onTap: () => setState(() => showAll = !showAll),
                  child: Row(
                    children: <Widget>[
                      !showAll
                          ? Text(
                            'All Reviews ${reviewDetails.length}',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          )
                          : Text('Show Less', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          showAll
              ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: reviewDetails.length,
                  itemBuilder:
                      (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
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
                            SizedBox(height: 10),
                            Row(children: <Widget>[Expanded(child: Text(reviewDetails[index]['review']))]),
                          ],
                        ),
                      ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
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
                              const SizedBox(width: 19),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      reviewDetails[0]['name'],
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    reviewDetails[0]['creationDate'],
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
                    const SizedBox(height: 10),
                    Row(children: <Widget>[Expanded(child: Text(reviewDetails[0]['review']))]),
                  ],
                ),
              ),
        ],
      );
    }
  }
}
