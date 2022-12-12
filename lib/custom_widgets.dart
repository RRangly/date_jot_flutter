import 'package:date_jot/account.dart';
import 'package:date_jot/custom_functions.dart';
import 'package:date_jot/custom_settings.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget inputBox(
    double width,
    double height,
    String assetImagePath,
    String textLocal,
    Color borderColor,
    double borderWidth,
    double horizontalPadding,
    double verticalPadding,
    double circleRadius,
    TextEditingController textECont,
  ) {
    if (assetImagePath == "null") {
      return SizedBox(
        width: width,
        height: height,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          controller: textECont,
          maxLines: 1,
          style: TextStyle(
            fontFamily: "WorkSans",
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            hintText: textLocal.toString(),
            hintStyle: TextStyle(
              fontFamily: "WorkSans",
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          controller: textECont,
          maxLines: 1,
          style: TextStyle(
            fontFamily: "WorkSans",
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: false,
            prefixIcon: Image(
              image: AssetImage(assetImagePath.toString()),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: width * 0.15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            hintText: textLocal.toString(),
            hintStyle: TextStyle(
              fontFamily: "WorkSans",
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
      );
    }
  }

  static Widget navigateButtonBuild(
    double width,
    double height,
    String textLocal,
    Widget wantedLocation,
    BuildContext context,
  ) {
    return FloatingActionButton.extended(
      onPressed: () async {
        CustomFunctions.navigateTo(context, wantedLocation);
      },
      label: Text(
        textLocal,
        style: const TextStyle(
          fontFamily: "WorkSans",
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.white,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 80),
    );
  }

  static Widget logoBG(double width, double height, double logoSize) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(35)),
        boxShadow: [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0.1,
              blurStyle: BlurStyle.normal)
        ],
      ),
      height: height * 0.165,
      width: height * 0.165,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image:
                const AssetImage("Assets/Images/UIElements/General/Logo.png"),
            width: logoSize * 1.3,
            height: logoSize * 1.3,
          ),
        ],
      ),
    );
  }

  static void topBar(
    BuildContext context,
    double width,
    double height,
  ) {
    final topOverLay = OverlayEntry(
      builder: (context) {
        return Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: CustomSettings.mainGreen,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(36)),
              ),
              width: width,
              height: height,
              child: Column(
                children: [
                  SizedBox(height: height * 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: width * 0.1),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.0),
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.menu,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.1),
                  Row(
                    children: [
                      SizedBox(width: width * 0.1),
                      Center(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(Account.pfpURL),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome Back",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "WorkSans",
                              color: Colors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            Account.email,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: "WorkSansBold",
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: width * 0.15),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.notifications_outlined,
                                size: 25,
                                color: CustomSettings.mainGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(topOverLay);
  }

  static void bottomOverLay(
    BuildContext context,
  ) {
    final bottomOverLay = OverlayEntry(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            return Align(
              alignment: Alignment(0, 1),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        //TODO: go to profile
                      },
                      icon: const Icon(Icons.person),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    IconButton(
                      onPressed: () {
                        //TODO: go to profile
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    IconButton(
                      onPressed: () {
                        //TODO: go to profile
                      },
                      icon: const Icon(Icons.home_outlined),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(bottomOverLay);
  }
}
