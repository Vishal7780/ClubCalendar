import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' as neu;

import '../../../../styles.dart';

Widget customButton(
    {required String title, required Function callFunction, required context}) {
  bool isPressed = false;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: neu.NeumorphicButton(
      style: neu.NeumorphicStyle(
        lightSource: neu.LightSource.top,
        shadowLightColorEmboss: Styles.backgroundColor,
        shadowLightColor: Styles.backgroundColor,
        boxShape: neu.NeumorphicBoxShape.roundRect(
          BorderRadius.circular(
              MediaQuery.of(context).size.height * 0.0387820513),
        ),
        color: Colors.black12,
        intensity: 1,
        shape:
            !isPressed ? neu.NeumorphicShape.flat : neu.NeumorphicShape.concave,
        depth: isPressed
            ? -4.9687
            : 4.9687, //MediaQuery.of(context).size.height*0.023,
        oppositeShadowLightSource: false,
      ),
      onPressed: (){callFunction();},
      child: Container(
                      
                      child: Row(
                        children: [
                          
                          Flexible(
                            child: Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Styles.fontColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    ),
  );
}
