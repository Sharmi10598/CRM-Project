import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/loginUserApi/login_user_api.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/Login/login_api.dart';
//import 'package:ultimate_bundle/src/furney/src/Api/loginUserApi/login_user_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/login_sap/login_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/custom_elevatedBtn.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/widgets/header_image.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_elevated_button.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_loading_indicator.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_shake_transtition.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_text_button.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/custom_text_form_field.dart';

import '../Setting/SettingPage.dart';

part 'screens/sign_in_screen.dart';
part 'widgets/body_section.dart';
part 'widgets/build_forgot_password_button.dart';
part 'widgets/build_sign_in_button.dart';
part 'widgets/build_sign_up_button.dart';
part 'widgets/header_section.dart';
