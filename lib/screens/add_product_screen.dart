import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../consts/flutter_toast.dart';
import '../controllers/menu_controller.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/button_widget.dart';
import '../widgets/header.dart';
import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';
import 'loading_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _groupValue = 1;
  bool isPiece = false;
  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();

    super.dispose();
  }
  bool isLoading = false;
 void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    String? imageUrl;
    if(isValid){
      _formKey.currentState!.save();
      if (_pickedImage == null) {
        GlobalMethods.showErrorDialog(
            content: 'Please pick up an image', context: context,);
        return;
      }
      final uId = const Uuid().v4(); //generate a random id
      try{
        setState(() =>isLoading = true);

        // upload image to firebase storage
        final ref = FirebaseStorage.instance.ref().child('userImages').child('$uId.jpg');
        if (kIsWeb) {
          await ref.putData(webImage);
        } else {
          await ref.putFile(_pickedImage!);
        }
        imageUrl = await ref.getDownloadURL(); // download image url from storage
       log('imgurl : ${imageUrl.toString()}');
        //upload data to firebase firestore
        await FirebaseFirestore.instance.collection('products').doc(uId).set(
            {
              'id':uId,
              'title':_titleController.text.toString(),
              'price':_priceController.text.toString(),
              'salePrice':0.1,
              'imageUrl':imageUrl.toString(),
              'productCategory':_catValue,
              'isOnSale':false,
              'isPiece':isPiece,
              'createdAt':Timestamp.now(),

            }).onError((error, stackTrace) =>
            GlobalMethods.showErrorDialog(context: context,
                content: error.toString())
        ).then((value) {
                  ToastMsg.toastMsg(msg: 'Uploaded Data');
                  clearForm();
        });
      }on FirebaseException catch(error){
        setState(() =>isLoading = false);

        GlobalMethods.showErrorDialog(
            context: context,
            content: error.message.toString());

      }
      catch(error){
        ToastMsg.toastMsg(msg: error.toString());
        setState(() =>isLoading = false);
      }finally{
        setState(() =>isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final textTheme = Theme.of(context).textTheme;
    final color = Utils(context).color;
    final scaffoldColor  = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1
        )
      )
    );
    return Scaffold(
      key: context.read<MenuControllerProvider>().getAddProductScaffoldKey,
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: isLoading,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if(Responsive.isDesktop(context))
              const Expanded(child: SideMenu()),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 5,
                child: SingleChildScrollView(
                    child: Column(

                    //  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Header(onTap: () {
                            context.read<MenuControllerProvider>().controlAddProductsMenu();
                          }, title: 'Add Products',
                          showSearchBox: false,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: size.width>650?650:size.width,
                          color: Theme.of(context).cardColor.withOpacity(0.4),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Product title'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _titleController,
                                    key: const ValueKey('Title'),
                                    validator: (value) {
                                     return value!.isEmpty ? 'Please enter a title':null;
                                    },
                                    decoration: inputDecoration,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex:2,
                                          child: FittedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Price in \$'),
                                            const SizedBox(height: 10,),
                                            SizedBox(
                                              width: 100,
                                              child: TextFormField(
                                                controller: _priceController,
                                                decoration: inputDecoration,
                                                key: const ValueKey('Price \$'),
                                                keyboardType: TextInputType.number,
                                                validator: (value) {
                                                  return value!.isEmpty?'Please enter price':null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9.]')
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20,),
                                            const Text('Product Category'),
                                            const SizedBox(height: 5,),
                                            _categoryDropDown(),
                                            const SizedBox(height: 10,),
                                            const Text('Measure unit'),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                const Text('KG'),
                                                Radio(
                                                value: 1,
                                                groupValue: _groupValue,
                                                activeColor: Colors.green,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _groupValue = 1;
                                                    isPiece = false;
                                                  });
                                                },
                                              ),
                                                const Text('Piece'),
                                                Radio(
                                                value: 2,
                                                groupValue: _groupValue,
                                                activeColor: Colors.green,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _groupValue = 2;
                                                    isPiece = true;
                                                  });
                                                },
                                              ),
                                            ],
                                            )
                                          ],
                                        ),
                                      ),
                                      ),
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: size.width > 650
                                                ? 350
                                                : size.width * 0.45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                            child: _pickedImage == null
                                                ? dottedBorder()
                                                : ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: kIsWeb
                                                    ? Image.memory(webImage, fit: BoxFit.fill,)

                                                    : Image.file(_pickedImage!, fit: BoxFit.fill,),
                                            )
                                        ),

                                      )),
                                  Expanded(
                                          flex: 1,
                                          child: FittedBox(
                                        child: Column(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _pickedImage = null;
                                                  webImage = Uint8List(8);
                                                });
                                              },
                                              child: Text('Clear Image',style: textTheme.titleLarge,),
                                            ),
                                            TextButton(
                                              onPressed: () {

                                              },
                                              child:  Text('Upload image',style: textTheme.titleLarge,),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ButtonWidget(
                                      buttonText: 'Clear Form',
                                      iconName: Icons.clear,
                                      onPressed: clearForm,
                                          backgroundColor: Colors.red,
                                    ),
                                        ButtonWidget(
                                      buttonText: 'Upload',
                                      iconName: Icons.upload,
                                      onPressed:  () {
                                        _uploadForm();
                                      } ,
                                          backgroundColor: Colors.green,
                                    ),
                                  ],
                                    ),
                                  )

                                ],
                              )),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  File? _pickedImage;
  Uint8List webImage = Uint8List(8); // its a data type for web image

  Future<void> pickImage()async{
    if(!kIsWeb){
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image != null){
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      }else{
        log('No image has been picked');
      }
    }

    else if(kIsWeb){
      final ImagePicker picker = ImagePicker();
      XFile? image= await picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        var f =await image.readAsBytes();
        setState(() {
          webImage = f;
         _pickedImage = File('a');
        });
      }else{
        log('No Image selected');
      }
    }else{
      log('Something went wrong');
    }
  }

  Widget dottedBorder(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6,7],
          borderType: BorderType.RRect,
          color: Theme.of(context).primaryColor,
          radius: const Radius.circular(12),
          child:  Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_outlined,
                color:Theme.of(context).primaryColor ,
                  size: 50,
                ),
                TextButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text('Choose an image',textAlign: TextAlign.center,),
                )
              ],
            ),
          )
      ),
    );
  }

 void clearForm()  {
    _priceController.clear();
    _titleController.clear();
    _catValue = 'Vegetables';
    _pickedImage = null;
    webImage = Uint8List(8);
    _groupValue = 1;
    isPiece = false;
    setState(() {
    });
  }

String _catValue = 'Vegetables';
  Widget _categoryDropDown(){
    return Container(
      height: kTextTabBarHeight,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8),
      child : DropdownButtonHideUnderline(

          child: DropdownButton<String>(

        value: _catValue,
        onChanged: (value) {
          log(_catValue);
          setState(() {
            _catValue = value!;
          });
        },
            style: Theme.of(context).textTheme.titleSmall,
            hint: const Text('Select a category'),
        items: const [
          DropdownMenuItem(
            value:'Vegetables' ,
              child: Text('Vegetables')
          ), DropdownMenuItem(
            value:'Fruits' ,
              child: Text('Fruits')
          ), DropdownMenuItem(
            value:'Grains' ,
              child: Text('Grains')
          ), DropdownMenuItem(
            value:'Nuts' ,
              child: Text('Nuts')
          ), DropdownMenuItem(
            value:'Herbs' ,
              child: Text('Herbs')
          ), DropdownMenuItem(
            value:'Spices' ,
              child: Text('Spices')
          ),
        ],
          ),
      ),
    );
  }
}
