import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medipath/controller/get_articles_controller.dart';
import 'package:medipath/pages/HomePage/components/article_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffFDF3F2),
                Color(0xffABB6DC)
              ],
            )
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xff22577A),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Achmed Fidel",
                          style: TextStyle(
                            color: Color(0xff22577A)
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            "Jalan Triman, Be...",
                          style: TextStyle(
                              color: Color(0xff22577A)
                          ),
                        ),
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(0xff22577A),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xffABB6DC),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xff22577A),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                          "Welcome, Achmed Fidel\nLaki Laki | 36 Tahun\nTidak ada riwayat penyakit",
                          style: TextStyle(
                            color: Color(0xff22577A),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Early Detection, Better Protection",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Stay Informed, Stay Healthy!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Image(
                              image: Image.asset("images/HomePage/heart.png").image,
                              width: 200,
                          ),
                        ),
                      ],
                    ),
                    showMore ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                          '''- Drink at least 8 cups of water daily.
            - Prioritize 7–8 hours of sleep each night.
            - Get moving: aim for at least 30 minutes of exercise most days.
            - Choose fresh fruits and vegetables over processed foods.
            - Manage stress through relaxation and mindfulness.
            - Schedule regular health check-ups — early detection saves lives!''',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ) : SizedBox.shrink(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2D3568),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          setState(() {
                            showMore = !showMore;
                          });
                        },
                        child: Text(
                          showMore ? "Show Less" : "Show More",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Articles",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff22577A),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff22577A)),
                          onPressed: () {
                            // Navigate to Health Tips page
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 320,
                      child: FutureBuilder(
                        future: GetArticlesController().fetchArticles(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}"));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No articles found"));
                          }
                          final articles = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              final article = articles[index];
                              return ArticleListTile(
                                article: article,
                                onTap: () {
                                  context.goNamed(
                                    'article',
                                    extra: article,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
