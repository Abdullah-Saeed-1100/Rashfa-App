import 'package:flutter/material.dart';
import 'package:rashfa_app/model/juicesmodel.dart';
import 'package:rashfa_app/pages/item_info.dart';
import 'package:rashfa_app/constant/linkapi.dart';

class ItemCard extends StatelessWidget {
  // final void Function()? onTap;
  final JuiceModel juiceModel;
  const ItemCard({super.key, required this.juiceModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // same color background in theme
          color: const Color(0xFF212325),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
            )
          ]),
      // ================  content for Container ===============
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================  image ===============
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemInfo(
                            juiceModel: juiceModel,
                          )));
            },
            child: Container(
              // مايحتاج سويناهن في الصورة
              // width: 120,
              // height: 120,
              margin: const EdgeInsets.all(10),
              child: Image.network(
                "$linkImageRoot/${juiceModel.juicesImage}",
                // مايحتاج عرض تشل العرض حقها لأننا عطيناها contain
                // width: 120,
                height: 130,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // ================  Name Product ===============
          Text(
            "${juiceModel.juicesName}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          //
          const SizedBox(height: 8),
          // ==============   Description Product =============
          Text(
            "${juiceModel.juicesDescription}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
          //
          const SizedBox(height: 13),
          // ================  row Price and Add button ===============
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE57734),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "أضف الى السلة",
                    style: TextStyle(
                      fontSize: 11.5,
                      // fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                  // const Icon(
                  //   Icons.add,
                  //   size: 20,
                  //   color: Colors.white,
                  // ),
                  ),
              Text(
                "\$${juiceModel.juicesPrice}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
