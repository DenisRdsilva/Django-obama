import 'package:flutter/material.dart';
import 'package:frontproj/example.dart';
import 'package:frontproj/sqlite.dart';
import 'dart:convert';

import '../env.sample.dart';
import './example.dart';


List<Data> post_list = [];

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: Container(
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(height: 0.5, color: Colors.black38),
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: post_list == null ? 0 : post_list.length,
              itemBuilder: (context, index) {
                return new Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    post_list[index].id +
                        ' ' +
                        post_list[index].created_date +
                          ' ' +
                          post_list[index].updated_date  +
                            ' ' +
                            post_list[index].author_id  +
                              ' ' +
                              post_list[index].content  +
                                ' ' +
                                post_list[index].summary  +
                                  ' ' +
                                  post_list[index].title  +
                                    ' ' +
                                    post_list[index].text,
                  ),
                );
              }
            )
          ),
    );
  }
}