// ignore_for_file: avoid_redundant_argument_values, avoid_print, unnecessary_lambdas

part of '../forgot_password_page.dart';

class _BodySection extends StatefulWidget {
  // final TextEditingController otp1= ;
  const _BodySection({
    Key? key,
  }) : super(key: key);
  @override
  _BodySectionState createState() => _BodySectionState();
}

class _BodySectionState extends State<_BodySection> {
  @override
  void dispose(){
    super.dispose();
    // ignore: unnecessary_statements
    mycontroller[0].dispose;
    mycontroller[1].dispose;
    mycontroller[2].dispose;
    mycontroller[3].dispose;
    mycontroller[4].dispose;
    mycontroller[5].dispose;
    mycontroller[6].dispose;
  }
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  final bool _isLoading = false;
  final bool _isLoading2 = false;
  bool visibleNPCnt = false;
  bool timmervisible = true;
  bool timmerRowVisible = true;
  bool progressVisible=false;
  bool _isLoadingRest = false;
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return
        //  Form(
        //   key:formkey ,
        //   child:
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: formkey[0],
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
                     SizedBox(
                  //  padding: const EdgeInsets.symmetric(
                      //  vertical: 8.0, horizontal: 30),
                      width:Screens.width(context) * 0.6,
                      height:Screens.heigth(context) * 0.08,
                    child: PinCodeTextField(
                     // backgroundColor:Colors.white,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.blue.shade600,//
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: Screens.heigth(context) * 0.07,
                        fieldWidth: Screens.width(context) * 0.12,
                        inactiveFillColor: Colors.white,

                        inactiveColor: theme.primaryColor,
                       // disabledColor: Colors.green,
                       activeFillColor: Colors.white,
                        activeColor: theme.primaryColor,
                        selectedColor:theme.primaryColor, //theme.disabledColor,
                        selectedFillColor: theme.disabledColor,
                      ),
                      cursorColor: theme.primaryColor,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      //errorAnimationController: errorController,
                      controller: mycontroller[6],
                      keyboardType: TextInputType.number,
                      
                      boxShadows:const [
                        BoxShadow(
                          offset:  Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print('Completed');
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          progressVisible = true;
                        });
                         Future.delayed(
                            const Duration(seconds: 3), isloadingFalse,);
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                      ///  print(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        print('Allowing to paste $text');
                      
                        return true;
                      },
                    ),),
          
              // SizedBox(
              //   width: Screens.width(context) * 0.1,
              // ),
              // Visibility(
              //   visible:progressVisible,
              //   child: Padding(
              //       padding:EdgeInsets.only(top:Screens.width(context) * 0.01,bottom: Screens.width(context) * 0.05),
              //       child:
              //       const CustomLoadingIndicator()
              //       ),
              // ),
            ],
          ),
        ), 
         SizedBox(height: Screens.heigth(context) * 0.04),
       Visibility(
            visible: timmerRowVisible,
         child:progressVisible==true?   
              Visibility(
                visible:progressVisible,
                child: Padding(
                    padding:EdgeInsets.only(top:Screens.width(context) * 0.01,bottom: Screens.width(context) * 0.05),
                    child:
                    const CustomLoadingIndicator(),
                    ),
              ):
         
          Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Visibility(
            visible: timmervisible,
            child: TweenAnimationBuilder<Duration>(
              
                duration: const Duration(minutes: 4),
              
                tween: Tween(begin: const Duration(minutes: 4), end: Duration.zero),
              
                onEnd: () {
              
            print('Timer ended');
              
                },
              
                builder: (BuildContext context, Duration value, Widget? child) {
              
            final minutes = value.inMinutes;
              
            final seconds = value.inSeconds % 60;
              
            return Padding(
              
              padding:  EdgeInsets.symmetric(vertical:  Screens.width(context) * 0.005),
              
              child: Text('$minutes:$seconds',
              
                       textAlign: TextAlign.center,
              
                       style:  TextStyle(
              
                       color: Colors.black,
              
                       fontWeight: FontWeight.bold,
              
                       fontSize:  Screens.width(context) * 0.055,),),);
              
            },),
          ),
             SizedBox(width: Screens.width(context) * 0.04),
             CustomShakeTransition(
            duration: const Duration(milliseconds: 3),
            child: InkWell(
              onTap: (){
                // print("hello");
              setState(() => timmervisible = false);
                 Future.delayed( const Duration(seconds: 1), resentTimer  );            
              },
              child: Text(
                // ignore: lines_longer_than_80_chars
                AppLocalizations.of(context)!
                    .resend_otp,
              
                style: GoogleFonts.poppins(
                  color: theme.primaryColor,
                  decoration: TextDecoration.underline,
                  textStyle: GoogleFonts.poppins(
                color:Colors.black54,
                fontSize:  Screens.width(context) * 0.042,
              //fontWeight: FontWeight.bold
              ),
                ),
                maxLines: 2,
              ),
            ),
          ),
         ],
       ),
       ),
        Visibility(
          visible:timmerRowVisible,
          child: SizedBox(height: Screens.heigth(context) * 0.04),),
        Visibility(
          visible: visibleNPCnt,
          child: Form(
            key:formkey[1],
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                CustomShakeTransition(
                  child: AutoSizeText(
                    'New Password', //AppLocalizations.of(context)!.forgot_password,
                    style: theme.textTheme.displayLarge,
                    maxLines: 1,
                  ),
                ),
                  
                  SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            CustomShakeTransition(
              duration: const Duration(milliseconds: 900),
              child: SizedBox(
                child: 
                // CustomTextFormField(
                //   obscureText:true,
                //   controller: mycontroller[4],
                //   borderType: BorderType.outline,
                //   hintText:
                //       "Enter Password", // AppLocalizations.of(context)!.enter_usercode,
                //   // textFieldType: TextFieldType.email,
                // ),
               TextFormField(
                                    validator: (value) {
                                      if (mycontroller[4].text !=  mycontroller[5].text) {
                                        return '*';
                                      }
                                      else if (mycontroller[4].text.isEmpty){
                                        return 'Please Enter Password';
                                      }
          
                                      return null;
                                    },
                                     obscureText:true,
                                    controller: mycontroller[4],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10,),
                                      // labelText: "ENTER Password",
                                      // labelStyle: TextStyle(
                                      //  // color: ,
                                      // ),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(8),
                                      //   borderSide:
                                      //       BorderSide(color: Colors.green),
                                      // ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
          
                                      // //focusborder
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
          
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    cursorColor: Colors.green,
                                  ),
              ),
            ),
            SizedBox(height: Screens.heigth(context) * 0.04),
            CustomShakeTransition(
              child: AutoSizeText(
                'Confirm Password', //AppLocalizations.of(context)!.forgot_password,
                style: theme.textTheme.displayLarge,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: Screens.heigth(context) * 0.01,
            ),
            CustomShakeTransition(
              duration: const Duration(milliseconds: 900),
              child: SizedBox(
                child:
                //  CustomTextFormField(
                //   obscureText:true,
                //   controller: mycontroller[5],
                //   borderType: BorderType.outline,
                //   hintText:
                //       "Enter Password", // AppLocalizations.of(context)!.enter_usercode,
                //   // textFieldType: TextFieldType.email,
                // ),
                   TextFormField(
                                    validator: (value) {
                                      if (mycontroller[4].text !=  mycontroller[5].text) {
                                        return '*';
                                      }
                                       else if (mycontroller[5].text.isEmpty){
                                        return 'Please Enter Password';
                                      }
          
                                      return null;
                                    },
                                     obscureText:true,
                                    controller: mycontroller[5],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10,),
                                      // labelText: "ENTER Password",
                                      // labelStyle: TextStyle(
                                      //  // color: ,
                                      // ),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(8),
                                      //   borderSide:
                                      //       BorderSide(color: Colors.green),
                                      // ),
                                        enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
          
                                      // //focusborder
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.grey),
                                      ),
          
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    cursorColor: Colors.green,
                                  ),
              ),
            ),
             SizedBox(
              height: Screens.heigth(context) * 0.04,
            ),
          
              //    ResetButton(
              //   isLoading: _isLoading2,
              //   onSendTap: () {
              //     FocusScope.of(context).requestFocus(FocusNode());
              //    // if (formKey[1].currentState!.validate()) {
              //       setState(() => _isLoading2 = true);
              //       Future.delayed(const Duration(seconds: 3),
              //           Get.back);
              //    // }
              //   },
              // ),
          
              CustomSpinkitdButton(
                  onTap: () {
                    if(formkey[1].currentState!.validate()){
                         // if( mycontroller[4].text ==  mycontroller[5].text){
                      setState(() => _isLoadingRest = true);
                    Future.delayed(const Duration(seconds: 2), Get.back);
                    //  () {
                    // //   setState(() => _isLoadingRest = false);
                    //   Get.back;
                    // });
                    }else{
                       const snackBar = SnackBar(content: Text("Password doesn't match"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  isLoading: _isLoadingRest,
                  labelLoading: AppLocalizations.of(context)!.reseting,
                  label: AppLocalizations.of(context)!.reset,
                ),
              ],
            ),
          ),
        ),
      
      ],
      // ),
    );
  }

  void isloadingFalse() {
   setState(() =>  progressVisible = false);
   setState(() => timmerRowVisible = false);
   setState(() =>visibleNPCnt = true);
  }

  void resentTimer(){
     setState(() => timmervisible = true);
     setState(() {
       FocusScope.of(context).requestFocus(FocusNode());
       mycontroller[6].text='';
     });
  }
}
