
import 'package:flutter/material.dart';
import 'package:projectname33/page/network/ApiCall.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 3),
      () => ApiCall().getUserToken().then((token) => {
            if (token != null &&
                token.trim().isNotEmpty)
              {
                debugPrint("token: "+token),
                Navigator.of(context).pushReplacementNamed('/homenew')}
            else
              {Navigator.of(context).pushReplacementNamed('/login')}
          }),
      // () => Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginScreen()),
      //     )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use Scaffold also in order to provide material app widgets
      body: Container(
          decoration: new BoxDecoration(
              color: Colors.white
          ),
          child: Center(
            child: Image(
              image: AssetImage("assets/images/logo_1.png"),
              height:MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/2,
              fit: BoxFit.contain,
            ),
          )),
    );
  }
}
