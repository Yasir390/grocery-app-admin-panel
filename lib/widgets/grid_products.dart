import 'package:admin_grocery_app/widgets/product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../consts/consts.dart';
import '../services/utils.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key,  this.crossAxisCount=4,  this.childAspectRatio=1,  this.isInMain=true});

  final int crossAxisCount;
  final double childAspectRatio;
 final bool isInMain;
  @override
  Widget build(BuildContext context) {
   final width = MediaQuery.of(context).size.width;
   double crossAspectRatio(){
      if(width<600){
        return 1.2;
      }
      else if(width<1100){
        return 0.9;
      }
      else{
        return 1.2;
      }
    }
    crossAxisCount(){
      if(width<600){
        return 2;
      }
      else if(width<800){
        return 3;
      }
      else if(width<1400){
        return 4;
      }
      else{
        return 5;
      }
    }

    Size size = Utils(context).getScreenSize;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: ( context,  snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: SpinKitFadingCube(color: Colors.black,),
          );
        }
       else if(snapshot.hasError){
            return const Center(child: Text('Snapshot has error'));
        }
       else if(!snapshot.hasData){
            return const Center(child: Text('Snapshot has no data'));
        }
       else if(snapshot.hasData){
            return    GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: isInMain && snapshot.data!.docs.length>4
                  ? 4
                  : snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:crossAxisCount(),
               childAspectRatio:crossAspectRatio(), // Width is x times the height
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
              ),

              itemBuilder: (context, index) {
                return  ProductWidget(id: snapshot.data!.docs[index]['id'],);
              },
            );
        }
       else{
         return const Center(child: Text('Something wrong'));
        }

      },
    )
    ;
  }
}
