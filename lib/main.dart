import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
 void main(){
   runApp(ApiCalling());
 }
 class ApiCalling extends StatefulWidget{
  @override
  State<ApiCalling> createState() => _ApiCallingState();
}
var data=[];

class _ApiCallingState extends State<ApiCalling> {
   Future getdata()async{
     String urllink="https://fakestoreapi.com/products";
     final responce= await  http.get(Uri.parse(urllink));

     if(responce!.statusCode==200)
       {
         var jsonData=jsonDecode(responce.body);
         setState(() {
           data=jsonData;
         });
       }
     else{
       print("error 404 found");
     }

   }

   @override
   Widget build(BuildContext context)
   {
     return MaterialApp(home: Scaffold(
       appBar: AppBar(title: Text("apicallings"),centerTitle: true),
       body:
         SingleChildScrollView(
           child: Column(children: [
             ElevatedButton(onPressed: getdata, child: Text("getdata")),
             Container(height: 700,
               child: ListView.builder(itemCount: data.length,itemBuilder: (context, index) => Card(
                 child:Column(children:[

                  ListTile(title: Text(data[index]["title"].toString()),
                  subtitle: Text(data[index]["price"].toString()),
                  ),
                   Text(data[index]["description"].toString()),
                 ])
               )),
               )
            
           ]),
         )
     ));
   }
}