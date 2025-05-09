import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckOutPost/CheckOutNextFolowPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckOutPost/CheckOutPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/CheckInApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/FileUploadApi/FileUploadApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetAprvActivityModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetCheckedInModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkout/CheckOutPage.dart';
import 'package:ultimate_bundle/helpers/LocalNotification.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/helpers/textstyle.dart';
import 'package:ultimate_bundle/helpers/uikit_model.dart';
import 'package:ultimate_bundle/src/appVersion.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/InPaymentChartapi/IncomingPaymentApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/local_api/notes_api/notesapi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_details_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/approvals_api/approvals_patch_api.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/getSeriesApi/seriesApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/login_sap/sapLoginAPI.dart';
import 'package:ultimate_bundle/src/furney/src/Api/service_layer_api/sap_user_id/sapUserApi.dart';
import 'package:ultimate_bundle/src/furney/src/Api/url/url.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBHelper.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/InPaymentChartModal/InPaymentChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/SalesChart_modal/SalesChart_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/VolumeChartModal/VolumeChartModal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/local_modal/notes_modal/notes_modal.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/approvals_modal/approvals_modal.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/src/helpers/screens.dart';
import 'package:ultimate_bundle/src/furney/src/models/home_Menu.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/home/widgets/quick_menu.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notes/screen/notes_details.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/appBar.dart';

import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/src/pages/bottom_navigation_bar/bottom_navigation_bar_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';

part 'screens/home_screen.dart';
part 'widgets/build_label_section.dart';
part 'widgets/build_scrollable_list.dart';
part 'widgets/build_swiper.dart';
part 'widgets/build_vertical_list.dart';
