import 'package:flutter/material.dart';

class MenuControllerProvider with ChangeNotifier{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addProductScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _ordersScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _editScaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;
  GlobalKey<ScaffoldState> get getGridScaffoldKey => _gridScaffoldKey;
  GlobalKey<ScaffoldState> get getAddProductScaffoldKey => _addProductScaffoldKey;
  GlobalKey<ScaffoldState> get getOrdersScaffoldKey => _ordersScaffoldKey;
  GlobalKey<ScaffoldState> get getEditsScaffoldKey => _editScaffoldKey;

  void controlDashboardMenu(){
    if(!_scaffoldKey.currentState!.isDrawerOpen){
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  void controlAllOrders(){
    if(!_ordersScaffoldKey.currentState!.isDrawerOpen){
      _ordersScaffoldKey.currentState!.openDrawer();
    }
  }
  void controlProductMenu(){
    if(!_gridScaffoldKey.currentState!.isDrawerOpen){
      _gridScaffoldKey.currentState!.openDrawer();
    }
  }
  void controlAddProductsMenu(){
    if(!_addProductScaffoldKey.currentState!.isDrawerOpen){
      _addProductScaffoldKey.currentState!.openDrawer();
    }
  }
  void controlEditScreen(){
    if(!_editScaffoldKey.currentState!.isDrawerOpen){
      _editScaffoldKey.currentState!.openDrawer();
    }
  }
}