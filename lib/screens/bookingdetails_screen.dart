import 'package:flutter/material.dart';

class Bookingdetails extends StatelessWidget {
  static const routeName = '/bookingdetails';
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> bookingid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: bookingid['error'] == 'Not Found'
          ? Center(
              child: Text(
                'No Booking',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 25,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/meeles-786110.appspot.com/o/green.jpg?alt=media&token=04ea4218-23f6-4dfb-abb0-730ca937603e'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mess Name',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookingid['Shop Name'],
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Meal Type',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookingid['Type'],
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Payment Mode',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookingid['Payment Mode'],
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rs. ${bookingid['Price']}',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey[200],
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        height: 140,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Menu',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              bookingid['Item1'],
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              bookingid['Item2'],
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              bookingid['Item3'],
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              bookingid['Item4'],
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${bookingid['Roti Quantity']} Roti',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              bookingid['Rice Type'],
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          bookingid['Desert'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: bookingid['url'] == null
                                          ? NetworkImage(
                                              'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                                            )
                                          : NetworkImage(bookingid['url']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
