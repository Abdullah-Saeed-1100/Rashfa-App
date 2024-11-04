import 'package:flutter/material.dart';
import 'package:rashfa_app/components/crud.dart';
import 'package:rashfa_app/constant/linkapi.dart';
import 'package:rashfa_app/pages/add_item.dart';
import 'package:rashfa_app/widgets/item_card.dart';
import 'package:rashfa_app/model/juicesmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Crud {
  Future getData() async {
    var response = await getRequest(linkViewjuices);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ====================  Button Add + ========================
      floatingActionButton: FloatingActionButton(
          splashColor: Colors.green,
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddItem()));
          }),
      // ======================  App Bar  ======================
      appBar: AppBar(
        title: const Text(
          "Rashfa",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.2),
        automaticallyImplyLeading: false,
      ),
      // ======================  Body  ===========================
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // textDirection: TextDirection.rtl,
              children: [
                // ========================  Text  =========================
                const Center(
                  child: Text(
                    "برّد على قلبك",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                // =========   الخط   =======
                const Divider(
                  indent: 60,
                  endIndent: 60,
                  thickness: 5,
                  color: Colors.orange,
                ),
                const SizedBox(height: 40),
                // ======================  Name List  =======================
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: const [
                      Icon(
                        Icons.filter_list,
                        size: 25,
                        color: Colors.white,
                      ),
                      Text(
                        "  جميع العصائر",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                // ========================  FutureBuilder  ================
                FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['status'] == "fail") {
                          return const Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: Center(
                                child: Text(
                              "لا يوجد عصائر",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 40,
                              ),
                            )),
                          );
                        }
                        // =================
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot
                              .data['data'].length, // Number of containers
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (1 / 1.45),
                            crossAxisCount: 2, // Number of columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                            crossAxisSpacing: 2.0, // Spacing between columns
                          ),
                          itemBuilder: (context, index) {
                            return ItemCard(
                              juiceModel: JuiceModel.fromJson(
                                  snapshot.data['data'][index]),
                            );
                          },
                        );
                      }
                      // ===================   الانتظار ====================
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.orange,
                            backgroundColor: Colors.orange[100],
                          )),
                        );
                      }
                      // =========== فشل الاتصال  ====================
                      return const Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Center(
                            child: Text(
                          "فشل الاتصال",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 40,
                          ),
                        )),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
