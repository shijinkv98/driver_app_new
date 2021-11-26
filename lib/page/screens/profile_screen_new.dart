import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectname33/page/helper/apiparams.dart';
import 'package:projectname33/page/helper/apiurldata.dart';
import 'package:projectname33/page/helper/constants.dart';
import 'package:projectname33/page/network/ApiCall.dart';
import 'package:projectname33/page/network/response/profile_get_response.dart';
import 'package:projectname33/page/network/response/profile_update_response.dart';
import 'package:projectname33/page/network/response/vehicle_response.dart';
import 'package:projectname33/page/screens/loan_request.dart';
import 'package:provider/provider.dart';

import 'balance_screen_new.dart';
import 'balance_screen_new.dart';
import 'delivery_confirmation.dart';
import 'home_screen2.dart';
import 'loan_list_scrren.dart';
import 'order_details_new.dart';
class ProfileScreenNew extends StatefulWidget {
  List<Vehicle> categories=new List<Vehicle>();
  ProfileScreenNew({this.categories});
  @override
  _ProfileScreenState createState() => new _ProfileScreenState(categories: categories);
}

class _ProfileScreenState extends State<ProfileScreenNew> {
  ProfileGetResponse profileGetResponse;
  List<Vehicle> categories=new List<Vehicle>();
  _ProfileScreenState({this.categories});
  Details details;
  Vehicle vehicle;
  Vehicle dropdownValueVehicle;
  VehicleResponse vehicleResponse;
  String _value = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey();
  final GlobalKey<FormState> _emailKey = GlobalKey();
  final GlobalKey<FormState> _lastNameKey = GlobalKey();
  final GlobalKey<FormState> _firstNameKey = GlobalKey();
  final GlobalKey<FormState> _vehicleKey = GlobalKey();
  final GlobalKey<FormState> _genderKey = GlobalKey();
  String _selectedGender = " ";
  String _email;
  String _lastname;
  String _firstname;
  String _phone;
  String _vehicle;
  @override
  void initState() {
    super.initState();
    // getVehicleList();
    if(categories==null){
      categories=new List<Vehicle>();
      getVehicleList();
    }


  }
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0);
  TextEditingController emailController;
  Widget appBar(BuildContext context) {

    return AppBar(
      flexibleSpace: Container(
        color: colorPrimary,
      ),
      actions: [
        PopupMenuButton(
            color: Colors.white,
            elevation: 20,
            enabled: true,
            onSelected: (value) {
              setState(() {
                _value = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BalanceScreenNew()));
                  },
                  child: TextField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "COD balance",
                      hintStyle:
                      TextStyle(color: Colors.black, fontSize: 12),
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        size: 18,
                      ),
                      border: InputBorder.none,

                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    getAlertLogout(context);
                    Navigator.pop(context);
                  },
                  child: TextField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Logout",
                      hintStyle:
                      TextStyle(color: Colors.black, fontSize: 12),
                      prefixIcon: Icon(
                        Icons.logout,
                        size: 18,
                      ),
                      border: InputBorder.none,
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                    ),
                  ),
                ),
              ),
            ])
      ],
      title: Container(
        child: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          // if (
          // _phoneKey.currentState.validate() &&
          //         _firstNameKey.currentState.validate() &&
          //         _lastNameKey.currentState.validate()
          // // && _genderKey.currentState.validate()
          //     && _vehicleKey.currentState.validate()
          //
          //     )
          // {
            _phoneKey.currentState.save();
            _firstNameKey.currentState.save();
            _lastNameKey.currentState.save();
            _emailKey.currentState.save();
            if(dropdownValueVehicle==null)
            {
              ApiCall().showToast("Select Vehicle");
              return;
            }

            // _genderKey.currentState.save();
            // _vehicleKey.currentState.save();
            update(_firstname, _lastname, _phone, _vehicle, _email);
            // Navigator.of(context).pushReplacementNamed('/homenew');
          // }
        },
        child: Text("UPDATE",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final loanButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: colorPrimary,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/2-30,
        height: 80,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          NextPagePush(context, LoanRequest());
            // update(_firstname, _lastname, _phone, _vehicle, _email);

        },
        child: Text("APPLY  FOR  LOAN",
            textAlign: TextAlign.center,
            style: style.copyWith(letterSpacing: 0.8,
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final appliedLoan = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: colorPrimary,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/2-30,
        height: 80,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () {
          NextPagePush(context, LoanListScreen());
            // update(_firstname, _lastname, _phone, _vehicle, _email);

        },
        child: Text("APPLIED LOANS",
            textAlign: TextAlign.center,
            style: style.copyWith(letterSpacing: 0.8,
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    Widget getContent(){

      // emailController.text = profileGetResponse.details
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 25.0),
                getFirstName(),
                SizedBox(height: 15.0),
                getLastName(),
                SizedBox(height: 15.0),
                getEmail(),
                SizedBox(height: 15.0),
                getPhone(),
                SizedBox(height: 15.0),
                Container(
                  margin: EdgeInsets.only(left: 10,right:10,top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child:
                    DropdownButton<Vehicle>(
                      isExpanded: true,
                      value: dropdownValueVehicle,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 23,
                      isDense: true,
                      elevation: 0,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      underline: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      onChanged: (Vehicle data) {
                        setState(() {
                          dropdownValueVehicle = data;
                          // getUsedItemSubCategories(data.catId);
                          //selected=data;
                        });
                      },
                      hint:details.vehicletype == ""? Text("Select Vehicle"):Text(details.vehicletype),

                      items: categories.map<DropdownMenuItem<Vehicle>>((Vehicle value) {
                        return DropdownMenuItem<Vehicle>(
                          value: value,
                          child: Container(
                              width: MediaQuery.of(context).size.width-110,
                              child: Text(value.type,textAlign: TextAlign.start,)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(height: 15.0),
                getGender(),
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    loanButton,
                    appliedLoan
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }



    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      backgroundColor: Colors.white,
      appBar: appBar(context),

      body:
      FutureBuilder<ProfileGetResponse>(
        future: ApiCall().execute<ProfileGetResponse, Null>(PROFILE_DETAILS_URL, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            profileGetResponse = snapshot.data;
            details = profileGetResponse.details.length>0?profileGetResponse.details[0]:Null;

            return getContent();
          } else if (snapshot.hasError) {
            return
              enableDataHome();
              // errorScreen('Error: ${snapshot.error}');
          }
          else {
            return progressBar;
          }
        },
      ),



    );

  }
  Widget enableDataHome() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 80,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Text('OOPS!  NO INTERNET',style: TextStyle(color: colorPrimary,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5),
              Text('Please check your network connection',style: TextStyle(color: colorPrimary,fontSize: 20),),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 40,top:5,right: 40),
            child: FlatButton(onPressed: updateUI,color: colorPrimary,child: Text('Try Again',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),))
      ],
    ),
  );

  void updateUI(){
    setState(() {
      //You can also make changes to your state here.
    });
  }
  Widget getFirstName() {
    return Form(
        key: _firstNameKey,
        child: TextFormField(
          // controller: passwordController,
          style: style,
          validator: (value) {
            if (value.trim().isEmpty) {
              return 'This field is required';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _firstname = value;
          },
          textInputAction: TextInputAction.next,
          initialValue: details!=null?details.firstname:"",
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            hintText: "First name",
            labelText: "First name",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
        ));
  }

  Widget getLastName() {
    return Form(
        key: _lastNameKey,
        child: TextFormField(
          // controller: passwordController,
          style: style,
          validator: (value) {
            if (value.trim().isEmpty) {
              return 'This field is required';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _lastname = value;
          },
          textInputAction: TextInputAction.next,
          initialValue: details.lastname,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            hintText: "Last name",
            labelText: "Last name",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
        ));
  }

  Widget getEmail() {
    return Form(
        key: _emailKey,
        child: TextFormField(
          obscureText: false,
          enabled: false,
          onSaved: (value) {
            _email = value;
          },
          style: style,
          validator: (value) {
            if (value.trim().isEmpty) {
              return 'This field is required';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return 'Invalid email';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          initialValue: details!=null?details.email:"",
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            hintText: "Email",
            labelText: 'Email',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
        ));
  }

  Widget getPhone() {
    return Form(
        key: _phoneKey,
        child: TextFormField(
          style: style,
          enabled: false,
          validator: (value) {
            if (value.trim().isEmpty) {
              return 'This field is required';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _phone = value;
          },
          initialValue: details!=null?details.phone:"",
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            hintText: "Phone number",
            labelText: "Phone number",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
        ));
  }

  Future<void> update(String firstname, String lastname, String phone,
      String vehicle, String email) async {
    // _updateNotifier.isProgressShown = true;

    Map body = {
      // name,email,phone_number,password
      PHONE: phone,
      NAME: '$_firstname $_lastname',
      EMAIL: _email,
      FIRSTNAME:_firstname,
      LASTNAME: _lastname,
      UPDATE_VEHICLE:dropdownValueVehicle.id,
      GENDER: _selectedGender
    };
    ApiCall()
        .execute<ProfileUpdateResponse, Null>(MY_PROFILE_URL, body)
        .then((ProfileUpdateResponse result) {
      // _updateNotifier.isProgressShown = true;
      if (result.success == null) {
        if (result.message != null) ApiCall().showToast(result.message);
      }
      ApiCall().showToast(result.message != null ? result.message : "");
      if (result.success == "1") {
        ApiCall().showToast(result.message);
        NextPageReplacement(context, HomeScreenNew());
      }
    });
  }

  Widget getGender() {
    // details.gender == "Male"?_selectedGender = "Male":_selectedGender = "Female";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Gender (optional)',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: 'Male',
                groupValue: _selectedGender,
                activeColor: colorPrimary,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Male'),
              Radio(
                value: 'Female',
                activeColor: colorPrimary,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Female'),
              Radio(
                activeColor: colorPrimary,
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Other'),
            ],
          ),
        )
      ],
    );
  }

  void getVehicleList()
  {
    // _updateNotifier.isProgressShown = true;
    ApiCall()
        .execute<VehicleResponse, Null>(TYPE_OF_VEHICLE,null ).then((VehicleResponse result){
      // _updateNotifier.isProgressShown = false;
       ApiCall().showToast(result.message);
      if(result.success=="1")
      {
        categories=result.vehicle;
        // _updateNotifier.category=categories;
        // if(_categories.length!=0)
        //   {
        //   // dropdownValueCategory=_categories[0];
        //  //   categoryId=_categories[0].catId;
        //  //   getUsedItemSubCategories(_categories[0].catId);
        //   }

      }

    });
  }
}
