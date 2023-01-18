import 'package:flutter/material.dart';


Widget actionButton(IconData icon, String actionTitle, Color iconColor) {
  return Expanded(
    child: TextButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        actionTitle,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}


//the feed box will have for parameters :
// the user name , the user avatar, the pub date, the content text and content img
Widget feedBox(String avatarUrl, String userName, String date,
    String contentText, String contentImg) {
  print(avatarUrl);
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Color.fromARGB(255, 240, 235, 235),
      // border: Border.all(color: Colors.black),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                
                backgroundImage: AssetImage("assets/favicon.png"),
                // backgroundImage: NetworkImage(avatarUrl),
                radius: 25.0,
                // backgroundColor: Colors.black,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: Color.fromARGB(255, 12, 12, 12),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          if (contentText != "")
            Text(
              contentText,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          SizedBox(
            height: 10.0,
          ),
          if (contentImg != "") Container(
            width: 150, 
            height: 150, 
            alignment: Alignment.center,
  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset("assets/test2.png"),
              ],
            )),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            thickness: 1.5,
            color: Color.fromARGB(255, 24, 23, 23),
          ),
          Row(
            children: [
              actionButton(Icons.thumb_up, "Like", Color(0xFF505050)),
              actionButton(Icons.comment, "Reply", Color(0xFF505050)),

              actionButton(Icons.share, "Share", Color(0xFF505050)),
            ],
          )
        ],
      ),
    ),
  );
}
