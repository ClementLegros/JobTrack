import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Widget slideLeftWidget() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            "Supprimé",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
