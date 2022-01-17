import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/post_model.dart';

class HomScreen extends StatefulWidget {
   const HomScreen({Key? key}) : super(key : key);

   @override
  _HomScreenState createState() => _HomScreenState();
}

class  _HomScreenState extends State<HomScreen>{

  List<PostModel> postList =[];

  Future<List<PostModel>> getPostApi () async{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data =jsonDecode(response.body.toString());
      if(response.statusCode == 200){
        for(Map i in data){
          postList.add(PostModel.fromJson(i));
        }
        return postList;

      }else {
        return postList;

      }
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text('Api'),
      ),
      body: Column(
        children:  [
          Expanded(
              child:FutureBuilder(
            future: getPostApi(),
            builder: (context , snapshot){
              if(snapshot.hasData){
                return  Text('Loading');
              }else{
                return ListView.builder(
                  itemCount: postList.length,
                    itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      children:[]
                    )
                  );
                });
              }
            },
          )
          )],
      ),
    );
  }
}