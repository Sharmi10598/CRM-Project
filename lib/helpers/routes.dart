import 'package:get/get.dart';
import 'package:ultimate_bundle/SalesApp/Pages/ApprovalVisit/ApprovalTask.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkin/CheckIn.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkin/CheckedInPage.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkin/Widgets/SelectCustomer.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkout/CheckOutPage.dart';
import 'package:ultimate_bundle/SalesApp/Pages/LocationApproval/LocationApproval.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/CreateVisit.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/PlaningPage.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/UnplannedVisit.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Planning/UpdatePlan.dart';
import 'package:ultimate_bundle/helpers/constants.dart';
import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/main.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/all_addressess.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/all_contacts.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvalsNew/approvalsNew.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/approvals_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/attachemants.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/bp_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/contact_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/item_details_approvals.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/item_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/price_list.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/regular_sales_price.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/activities/activities.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/activities/activities_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/activities/edit_activity.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/activities/more.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/opportunities/opportunities.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/opportunities/opportunities_info.dart';
import 'package:ultimate_bundle/src/furney/src/pages/approval/screens/transactions/special_prices/special_price.dart';
import 'package:ultimate_bundle/src/furney/src/pages/attendance/screen/attendance_screen.dart';
import 'package:ultimate_bundle/src/furney/src/pages/bottom_navigation_bar/bottom_navigation_bar_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/complaints/screens/complaints.dart';
import 'package:ultimate_bundle/src/furney/src/pages/contact_person/contact_person.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/screens/CustCreatePage.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/screens/customer_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/widget/all_addresses.dart';
import 'package:ultimate_bundle/src/furney/src/pages/customers/widget/all_contacts.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/screens/delivery.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/screens/deliveryDetails.dart';
import 'package:ultimate_bundle/src/furney/src/pages/delivery/widgets/delivery_items_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/depot_performance/screens/depot_performance.dart';
import 'package:ultimate_bundle/src/furney/src/pages/forgot_password/forgot_password_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/forgot_password_success/forgot_password_success_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/home/home_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/items/screen/items_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notes/screen/notes_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notes/screen/notes_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/notification/notification_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/others/screens/others.dart';
import 'package:ultimate_bundle/src/furney/src/pages/payment_from_customers/screens/payment_customer_screen.dart';
import 'package:ultimate_bundle/src/furney/src/pages/product/all_product_screen.dart';
import 'package:ultimate_bundle/src/furney/src/pages/reports/screens/reports.dart';
import 'package:ultimate_bundle/src/furney/src/pages/salesRep/screens/sales_rep_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/create_order.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/salesOrderNew.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/screens/sales_order_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/order_items_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_order/widget/showDetails/approvalsDetailsOrders.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/SalesQutDetails.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/create_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/quotations.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/salesQuotNew.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/screens/sales_quot_details.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/quotation_items.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sales_quot/widget/showdetails/Approvals_details_quot.dart';
import 'package:ultimate_bundle/src/furney/src/pages/showPdf/ShowPdf.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_in/sign_in_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/sign_up/sign_up_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/stocks_items/screens/stock_items_page.dart';
import 'package:ultimate_bundle/src/furney/src/pages/stocks_items/screens/stock_warehouse_page.dart';

List<GetPage> allRoutesFurney = [
  GetPage<dynamic>(
    name: FurneyRoutes.splash,
    page: () => const FurneySplashScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.allProduct,
    page: () => const FurneyAllProductScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.cart,
    page: () => const FurneyBottomNavigationBarScreen(initialIndex: 2),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.discover,
    page: () => const FurneyBottomNavigationBarScreen(initialIndex: 1),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.forgotPassword,
    page: () => const FurneyForgotPasswordScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.forgotPasswordSuccess,
    page: () => const FurneyForgotPasswordSuccessScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.home,
    page: () => const FurneyBottomNavigationBarScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.notification,
    page: () => const NotificationScreen(
      title: 'Notifications',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.profile,
    page: () => const FurneyBottomNavigationBarScreen(initialIndex: 4),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.search,
    page: () => const FurneyBottomNavigationBarScreen(initialIndex: 3),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.signIn,
    page: () => const FurneySignInScreen(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.signUp,
    page: () => const FurneySignUpScreen(),
  ),
  //new crt
  GetPage<dynamic>(
    name: FurneyRoutes.salesQuotes,
    page: () => const SalesQuot(),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.dashBoard,
    page: () => const FurneyHomeScreen(
      title: 'DashBoard',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.salesquotdetails,
    page: () => const SalesQtDetails(
      title: 'Quotation Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.attendance,
    page: () => const AttendancePage(
      title: 'Attendance',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.others,
    page: () => const Others(
      title: 'All Menu',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.salesorderdetails,
    page: () => const SalesOrderDetails(
      title: 'Order Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.approvals,
    page: () => const Approvals(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.approvalsInfo,
    page: () => const ApprovalsInfo(
      title: 'Approvals Info',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.iteminfo,
    page: () => const ItemInfo(
      title: 'Item Info',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.bpinfo,
    page: () => const BPInfo(
      title: 'BP Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.contactInfo,
    page: () => const ContactInfo(
      title: 'Contact Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.details,
    page: () => const DetailsPage(
      title: 'Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.priceList,
    page: () => const PriceListPage(
      title: 'Price List',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.attachments,
    page: () => const Attachments(
      title: 'Attachments',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.regularSalesPrice,
    page: () => const RegularSalesPrice(
      title: 'Regular Sales Price',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.allContacts,
    page: () => const AllContacts(
      title: 'All Contacts',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.alladdress,
    page: () => const AllAddresses(
      title: 'All Addresses',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.activities,
    page: () => const Activities(
      title: 'Activities',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.activitiesDetails,
    page: () => const ActivitiesDetails(
      title: 'Activities Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.editactivity,
    page: () => const EditActivity(
      title: 'Edit Activity',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.more,
    page: () => const More(
      title: 'More',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.specialPrices,
    page: () => const SpecialPrices(
      title: 'Special Prices',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.opportunities,
    page: () => const Opportunities(
      title: 'Opportunities',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.opportunitiesInfo,
    page: () => const OpportunitiesInfo(
      title: 'Opportunities Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.stockItem,
    page: () => const StockItem(
      title: 'Stock',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.stockWarehouse,
    page: () => const StockWarehouse(
      title: 'Stock',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.paymentCustomers,
    page: () => const PaymentCustomer(
      title: 'Payment Customers',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.deliveyPage,
    page: () => const DeliveryPage(
      title: 'Delivey Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.deliveyDetails,
    page: () => const DeliveryDetails(
      title: 'Delivey Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.complaintsPage,
    page: () => const ComplaintsPage(
      title: 'complaints',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.bpAllAddresses,
    page: () => const AllAdress(
      title: 'BP Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.bpAllContacts,
    page: () => const AllContact(
      title: 'BP Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.salesRep,
    page: () => const SalesRep(
      title: 'Sales Rep',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.creationDetails,
    page: () => const CreateDetails(
      title: 'Quotation Creation',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.itemDetails,
    page: () => const ItemsDetails(
      title: 'Item Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.contactpersons,
    page: () => const ContactPerson(
      title: 'Contact Persons',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.creationOrderDetails,
    page: () => const CreateOrderDetails(
      title: 'Order Creation',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.salesQuotItems,
    page: () => const SalesQuotItems(
      title: 'Item Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.salesOrderItems,
    page: () => const SalesOrderItems(
      title: 'Item Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.deliveryItemsdetails,
    page: () => const DeliveryItems(
      title: 'Item Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.notesPage,
    page: () => const NotesPage(
      title: 'Notes Page',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.notesDetails,
    page: () => const NotesDetails(
      title: 'Notes Details',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.newSalesQuot,
    page: () => const SalesQuotationNew(
      title: 'Sales Quotations',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.approvalsDetailsSalesQuot,
    page: () => const ApprovalsDetailsQuot(
      title: 'Approvals Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.newSalesOrders,
    page: () => const SalesOrderNew(
      title: 'Sales Orders',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.approvalsDetailsSalesOrders,
    page: () => const ApprovalsDetailsOrders(
      title: 'Approvals Info',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.approvalsNew,
    page: () => const ApprovalsNew(
      title: 'Approvals',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.showpdf,
    page: () => const ShowPdf(),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.reports,
    page: () => const Reports(
      title: 'Reports',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.depotperformance,
    page: () => const DepotPerformance(
      title: 'Depot Performance',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.planningPage,
    page: () => const PlanningPage(
      title: 'Site Visit Planner',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.approvalTask,
    page: () => const ApprovalTask(
      title: 'Approval Pending',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.checkoutPage,
    page: () => const CheckOutPage(
      title: 'Site Check-Out',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.createVisitPage,
    page: () => const CreateVisitPage(
      title: 'Visit Task Creation',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.checkin,
    page: () => const CheckinPage(
      title: 'Checkin',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.checkedin,
    page: () => const CheckedINPage(
      title: 'Checkedin',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.selectionCustomer,
    page: () => const SelectCustomerPage(
      title: 'Customers',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.customerpage,
    page: () => const CustomerPage(
      title: 'Customer',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.createCustomer,
    page: () => const CustomerCreatePage(
      title: 'Customer',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.locationApproval,
    page: () => const LocationApproval(
      title: 'Location Approval',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.updatePlan,
    page: () => const UpdateVisitPage(
      title: 'Location Approval',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.updatePlan,
    page: () => const UpdateVisitPage(
      title: 'Location Approval',
    ),
  ),

  GetPage<dynamic>(
    name: FurneyRoutes.unplannedVisit,
    page: () => const UnplannedVisitPage(
      title: 'Unplanned Visit',
    ),
  ),
  GetPage<dynamic>(
    name: FurneyRoutes.salesQtDetailss,
    page: () => const SalesDetailsQuot(),
    // title: 'Sales Quotation details',
  ),
];
