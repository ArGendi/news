import 'package:flutter/material.dart';
import 'package:news/models/news.dart';
import 'package:news/web_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebService _webService;
  List<News> news = [];

  void getNewsFromAPI() async{
    List<News> data = await _webService.getNewsWithDio();
    setState(() {
      news = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webService = WebService();
    getNewsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
            itemBuilder: (context, i){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(news[i].imageUrl != null)
                    Image.network(news[i].imageUrl!),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      news[i].title.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      news[i].description.toString(),
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                ],
              );
            }, 
            separatorBuilder: (context, i){
              return SizedBox(height: 20,);
            }, 
            itemCount: news.length,
          ),
    );
  }
}

