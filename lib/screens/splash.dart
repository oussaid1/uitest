import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/main.dart';
import '../appassets.dart';
import '../glass_widgets.dart';
import '../responssive.dart';
import '../theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const AuthPage();
}

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'test@gmail.com');
  final passController = TextEditingController(text: 'ssdd1122');
  final registerFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: 'test');
  final confirmPassController = TextEditingController(text: 'ssdd1122');
  final emailfocusNode = FocusNode();
  final passwordfocusNode = FocusNode();
  final usernamefocusNode = FocusNode();
  final confirmPassfocusNode = FocusNode();
  final registerFormfocusNode = FocusNode();

  bool _obscurepass = true;
  bool _obscureconfirmpass = true;
  bool _canLogin = false;
  bool _canRegister = false;

  final _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return const App();
    //   }));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(child: buildLefttSide(context))
                else
                  const SizedBox.shrink(),
                Expanded(child: buildRightSide(context)),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: AppAssets.logoTm),
          ],
        ),
      ),
    );
  }

  buildRightSide(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: MThemeData.background,
      ),
      //color: MThemeData.secondaryColor,

      //color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BluredContainer(
              width: 400,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.white.withOpacity(isSignIn ? 0.2 : 0),
                      child: MaterialButton(
                          elevation: 0,
                          // color: Colors.white.withOpacity(isSignIn ? 1 : 0.5),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          onPressed: () {
                            setState(() {
                              isSignIn = true;
                            });
                            _pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          child: Text(
                            "Login",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 20,
                                      color: !isSignIn
                                          ? MThemeData.hintColor
                                          : MThemeData.white,
                                    ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.white.withOpacity(!isSignIn ? 0.2 : 0),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isSignIn = false;
                          });
                          _pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          "Sign Up",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                    color: isSignIn
                                        ? MThemeData.hintColor
                                        : MThemeData.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BluredContainer(
                height: isSignIn
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.7,
                //height: MediaQuery.of(context).size.height * 0.5,
                width: 400,
                child: PageView(
                  pageSnapping: true,
                  allowImplicitScrolling: false,
                  controller: _pageController,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              buildEmail(context),
                              const SizedBox(
                                height: 20,
                              ),
                              buildPassword(context),
                              const SizedBox(
                                height: 20,
                              ),
                              buildSignInButton(context),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Form(
                          key: registerFormKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              buildUserName(context),
                              const SizedBox(height: 20),
                              buildEmail(context),
                              const SizedBox(height: 20),
                              buildPassword(context),
                              const SizedBox(height: 20),
                              buildConfirmPassword(context),
                              const SizedBox(height: 20),
                              buildSignUpButton(context),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildLefttSide(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(0),
          //   topRight: Radius.circular(0),
          // ),
          color: MThemeData.surface),
      height: MediaQuery.of(context).size.height,
      //color: Theme.of(context).colorScheme.primary,
      child: BluredContainer(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Welcome To Smart Tech-Store ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                Text('Manage Your Sales Wisely & Smart',
                    style: Theme.of(context).textTheme.subtitle2!),
                //const AppInfoWidget(),
              ],
            ),
            SizedBox(
                height: 400,
                width: 400,
                child: Image.asset(
                  AppAssets.splashLeftPng,
                  height: 400,
                  width: 400,
                )),
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: ElevatedButton(
        focusNode: registerFormfocusNode,
        style: MThemeData.raisedButtonStyleSave,
        onPressed: !_canLogin
            ? null
            : () {
                if (loginFormKey.currentState!.validate()) {
                  // BlocProvider.of<LoginBloc>(context).add(LoginRequestedEvent(
                  //     loginCredentials: LoginCredentials(
                  //         email: emailController.text.trim(),
                  //         password: passController.text.trim())));
                  //log('login button pressed event dispatched');
                  // auth.signIn(email: email, password: pass).then(
                  //       (value) => Navigator.pushReplacementNamed(context, '/'),
                  //     );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const App();
                  }));
                }
              },
        child: const Text(
          'Sign In',
        ),
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        style: MThemeData.raisedButtonStyleSave,
        onPressed: !_canRegister
            ? null
            : () {
                if (registerFormKey.currentState!.validate()) {
                  setState(() {
                    _canLogin = false;
                    _canRegister = false;
                  });
                  // BlocProvider.of<SignUpBloc>(context).add(
                  //   SignUpRequestedEvent(
                  //     signUpCredentials: SignUpCredentials(
                  //       username: usernameController.text.trim(),
                  //       email: emailController.text.trim(),
                  //       password: passController.text.trim(),
                  //     ),
                  //   ),
                  // );

                  log('sign up button pressed event dispatched');
                }
              },
        child: const Text(
          'Sign Up',
          //style: Theme.of(context).textTheme.headline3!.copyWith(
          // color: MThemeData.white,
        ),
      ),
    );
  }

  Widget buildUserName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        // style: Theme.of(context).textTheme.subtitle1!.copyWith(
        //       color: Theme.of(context).colorScheme.onSurface,
        //     ),
        onChanged: (value) => setState(() {
          _canRegister = value.isNotEmpty;
        }),
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "enter a unique name".tr();
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MThemeData.primaryColor),
          ),
          hintText: 'enter your username here',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          labelText: 'Username',
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.highlight_remove_sharp,
              size: 18,
            ),
            onPressed: () => usernameController.clear(),
          ),
        ),
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (value) => setState(
          () => _canLogin = value.isNotEmpty,
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "insert a valid email".tr();
          }
          return null;
        },
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(passwordfocusNode),
        autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MThemeData.primaryColor),
          ),
          hintText: 'enter your email here',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          labelText: 'Email',
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.highlight_remove_sharp,
              size: 18,
            ),
            onPressed: () => emailController.clear(),
          ),
        ),
      ),
    );
  }

  Widget buildPassword(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: passController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        focusNode: passwordfocusNode,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "insert a valid password".tr();
          }
          return null;
        },
        obscureText: _obscurepass,
        // focusNode: emailfocusNode,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(registerFormfocusNode),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: !_obscurepass
                ? const Icon(Icons.visibility_off_sharp,
                    size: 18, color: MThemeData.hintColor)
                : const Icon(
                    Icons.visibility_outlined,
                    size: 18,
                    color: MThemeData.hintColor,
                  ),
            onPressed: () {
              setState(() {
                _obscurepass = !_obscurepass;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MThemeData.primaryColor),
          ),
          hintText: 'enter your password here',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          labelText: 'PassWord',
          // suffix: IconButton(
          //   icon: const Icon(
          //     Icons.highlight_remove_sharp,
          //     size: 18,
          //   ),
          //   onPressed: () => passController.clear(),
          // ),
        ),
      ),
    );
  }

  Widget buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        // style: Theme.of(context).textTheme.subtitle1!.copyWith(
        //       color: Theme.of(context).colorScheme.onSurface,
        //     ),
        controller: confirmPassController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "insert a valid password".tr();
          }
          if (text != passController.text) {
            return "passwords do not match".tr();
          }
          return null;
        },
        obscureText: !_obscureconfirmpass,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: _obscureconfirmpass
                ? const Icon(Icons.visibility_off_sharp,
                    size: 18, color: MThemeData.hintColor)
                : const Icon(
                    Icons.visibility_outlined,
                    size: 18,
                    color: MThemeData.hintColor,
                  ),
            onPressed: () {
              setState(() {
                _obscureconfirmpass = !_obscureconfirmpass;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MThemeData.primaryColor),
          ),
          hintText: 'confirm your password here',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          labelText: 'Confirm Password',
          // suffix: IconButton(
          //   icon: const Icon(
          //     Icons.highlight_remove_sharp,
          //     size: 18,
          //   ),
          //   onPressed: () => confirmPassController.clear(),
          // ),
        ),
      ),
    );
  }
}
