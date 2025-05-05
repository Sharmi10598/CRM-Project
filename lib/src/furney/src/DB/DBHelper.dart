// ignore_for_file: file_names, omit_local_variable_types, prefer_single_quotes, require_trailing_commas, unawaited_futures
import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckOutPost/CheckOutPostApi.dart';
import 'package:ultimate_bundle/SalesApp/Api/CheckinApi/CheckInApi.dart';
import 'package:ultimate_bundle/SalesApp/Model/GetActivities/GetAprvActivityModel.dart';
import 'package:ultimate_bundle/SalesApp/Model/ProjectModel/ProjectModel.dart';
import 'package:ultimate_bundle/SalesApp/Pages/Checkout/CheckOutPage.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/CusTomerModal.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/GetApprovedCust.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/ItemModal.dart';
import 'package:ultimate_bundle/src/furney/src/DB/DBModal/NotificationModelDB.dart';
import 'package:ultimate_bundle/src/furney/src/Modal/service_layer_modal/item_modal/mainsubModal/subModal.dart';
import 'package:ultimate_bundle/src/furney/src/widgets/Drawer.dart';

class DataBaseHelper {
  static Future<Database> createDB() async {
    final String path = await getDatabasesPath();
    //  print("path: "+path);
    return openDatabase(join(path, 'CRMV1.db'),
        onCreate: (database, version) async {
      await database.execute('''
           create table $tablename(
             CusId integer primary key autoincrement,
             ${Columns.bPCode} varchar not null,
             ${Columns.bPName} varchar not null,
             ${Columns.billTo} varchar not null,
             ${Columns.currency} varchar not null,
             ${Columns.cusRefNo} varchar not null,
             ${Columns.docDate} varchar not null,
             ${Columns.gPApprovalReq} varchar not null,
             ${Columns.orderRecDate} varchar not null,
             ${Columns.orderRecTime} varchar not null,
             ${Columns.postDate} varchar not null,
             ${Columns.remarks} varchar not null,
             ${Columns.salesEmp} varchar not null,
             ${Columns.selectOrderType} varchar not null,
             ${Columns.shipTo} varchar not null,
             ${Columns.status} varchar not null,
             ${Columns.validUntil} varchar not null)
        ''');

      await database.execute('''
           create table $itemTable(
             ItemId integer primary key autoincrement,
             ${ItemColumn.cusID} integer,
             ${ItemColumn.itemCode} varchar not null,
             ${ItemColumn.itemName} varchar not null,
             ${ItemColumn.price} varchar not null,
             ${ItemColumn.qty} varchar not null,
             ${ItemColumn.tax} varchar not null,
             ${ItemColumn.discount} varchar not null,
             ${ItemColumn.total} varchar not null,
             ${ItemColumn.taxCode} varchar not null,
             ${ItemColumn.discounpercent} varchar not null,
             ${ItemColumn.valueAFDisc} varchar,
             ${ItemColumn.wareHouseCose} varchar not null,
             ${ItemColumn.taxCodeName} varchar not null,
             ${ItemColumn.cartoon} varchar not null,
             ${ItemColumn.deliveryDate} varchar,
             FOREIGN KEY (CusId) REFERENCES $tablename (CusId)
             )
        ''');
      await database.execute('''
          create table $approvedCustomerTable(
             APId integer primary key autoincrement,
             ${ApprovedCustomer.CardCode} varchar,
             ${ApprovedCustomer.CardName} varchar ,
             ${ApprovedCustomer.ClgCode} integer,
             ${ApprovedCustomer.Details} varchar ,
             ${ApprovedCustomer.Name} varchar,
             ${ApprovedCustomer.status} varchar,
             ${ApprovedCustomer.slpCode} varchar
             )
        ''');
      await database.execute('''
          create table $postCheckInModel(
             PId integer primary key autoincrement,
             ${PostCheckInModel.clgcode} varchar,
             ${PostCheckInModel.StartDate} varchar ,
             ${PostCheckInModel.StartTime} varchar,
             ${PostCheckInModel.ActivityDate} varchar ,
             ${PostCheckInModel.ActivityTime} varchar,
             ${PostCheckInModel.U_Latitude} varchar,
             ${PostCheckInModel.U_Longitude} varchar,
             ${PostCheckInModel.U_CheckedIn} varchar,
             ${PostCheckInModel.U_CheckinAdd} varchar, 
             ${PostCheckInModel.status} varchar
             )
        ''');
      await database.execute('''
          create table $postFiles(
             FId integer primary key autoincrement,
             ${PostFilesModel.filePath} varchar,
             ${PostFilesModel.clgcode} integer    
             )
        ''');
      await database.execute('''
          create table $postCheckOutModel(
             PCOId integer primary key autoincrement,
             ${PostCheckOut.CloseDate} varchar,
             ${PostCheckOut.Closed} varchar ,
             ${PostCheckOut.Duration} Numeric,
             ${PostCheckOut.EndTime} Integer ,
             ${PostCheckOut.Notes} varchar,
             ${PostCheckOut.UAdvFormt} varchar,
             ${PostCheckOut.UAdvertise} varchar,
             ${PostCheckOut.UStatus} varchar ,
             ${PostCheckOut.U_BrandContr} varchar ,
             ${PostCheckOut.U_BrandinPromo} varchar ,
             ${PostCheckOut.U_COLatitude} varchar ,
             ${PostCheckOut.U_COLongitude} varchar ,
             ${PostCheckOut.U_Complaints} varchar ,
             ${PostCheckOut.U_Link1} varchar ,
             ${PostCheckOut.U_Link2} varchar ,
             ${PostCheckOut.U_Link3} varchar ,
             ${PostCheckOut.U_Link4} varchar ,
             ${PostCheckOut.U_NxtFollowup} varchar ,
             ${PostCheckOut.U_OrdProsValue} Numeric ,
             ${PostCheckOut.U_PPComp} varchar ,
             ${PostCheckOut.U_Products} varchar ,
             ${PostCheckOut.U_PymntVal} Numeric ,
             ${PostCheckOut.U_Remarks1} varchar ,
             ${PostCheckOut.U_Remarks2} varchar ,
             ${PostCheckOut.clgCode} integer ,
             ${PostCheckOut.U_Project} varchar ,
             ${PostCheckOut.U_Customer} varchar ,
             ${PostCheckOut.U_Consultant} varchar ,
            ${PostCheckOut.U_CheckOutAdd} varchar ,
             ${PostCheckOut.U_Subgroup} varchar 
             )
        ''');
      await database.execute('''
          create table $tableNotification(
             NId integer primary key autoincrement,
             ${Notification.docEntry} int not null,
             ${Notification.title} varchar not null,
             ${Notification.imgurl} varchar not null,
             ${Notification.description} varchar not null,
             ${Notification.receiveTime} varchar not null,
             ${Notification.seenTime} varchar not null,
             ${Notification.naviScn} varchar not null
             )         
        ''');

      await database.execute('''
          create table $subGroupModel(
             SubGId integer primary key autoincrement,
             ${SubGroupModel.code} varchar not null,
             ${SubGroupModel.name} varchar not null,
             ${SubGroupModel.selected} varchar not null
             )         
        ''');
      await database.execute('''
          create table $projectModel(
             APJTId integer primary key autoincrement,
             ${GetProjectModel.projectName} varchar not null
             )         
        ''');
    }, version: 1);
  }

  // pjct
  // subgrp
  static Future insertActiveProject(
    List<GetProjectData> values,
  ) async {
    final Database db = await createDB();
    final data = values.map((e) => e.toMap()).toList();
    final batch = db.batch();
    data.forEach((es) async {
      batch.insert(projectModel, es);
    });
    await batch.commit();
  }

  static Future<void> deleteActiveProject() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $projectModel;
    ''');
    // await db.close();
  }

  static Future<List<GetProjectData>> getActiveProject() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT * FROM $projectModel;
    ''');
    log(result.toList().toString());
    return List.generate(result.length, (i) {
      return GetProjectData(projectName: result[i]['projectName'].toString());
    });
  }

// subgrp
  static Future insertsubGroup(
    List<SubModalValue> values,
  ) async {
    final Database db = await createDB();
    final data = values.map((e) => e.toMap()).toList();
    final batch = db.batch();
    data.forEach((es) async {
      batch.insert(subGroupModel, es);
    });
    await batch.commit();
  }

  static Future<void> deleteSubGrp() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $subGroupModel;
    ''');
    // await db.close();
  }

  static Future<List<SubModalValue>> getSubGrp() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $subGroupModel;
''');
    log(result.toList().toString());
    return List.generate(result.length, (i) {
      return SubModalValue(
          code: result[i]['code'].toString(),
          name: result[i]['name'].toString(),
          selected: int.parse(result[i]['selected'].toString()));
    });
  }

  /// notifications

  Future insertNotification(
    List<NotificationModel2> values,
  ) async {
    final Database db = await createDB();
    final data = values.map((e) => e.toMap()).toList();
    final batch = db.batch();
    data.forEach((es) async {
      batch.insert(tableNotification, es);
    });
    await batch.commit();
  }

  Future<void> updateNotify(int id, String time) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
      UPDATE $tableNotification
    SET SeenTime = "$time" WHERE NId = $id;
    ''');
  }

  Future<void> deleteNotify(int id) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $tableNotification WHERE NId = $id;
    ''');
    // await db.close();
  }

  Future<void> deleteNotifyAll() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
      delete from $tableNotification;
    ''');
    // await db.close();
  }

  Future<List<NotificationModel2>> getNotification() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
SELECT * FROM $tableNotification;
''');
    log(result.toList().toString());
    return List.generate(result.length, (i) {
      return NotificationModel2(
        id: int.parse(result[i]['NId'].toString()),
        docEntry: int.parse(result[i]['DocEntry'].toString()),
        titile: result[i]['Title'].toString(),
        description: result[i]['Description'].toString(),
        receiveTime: result[i]['ReceiveTime'].toString(),
        seenTime: result[i]['SeenTime'].toString(),
        imgUrl: result[i]['ImgUrl'].toString(),
        naviScn: result[i]['NavigateScreen'].toString(),
      );
    });
  }

  Future<int?> getUnSeenNotificationCount() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery('''
    SELECT count(NId) from $tableNotification where SeenTime = '0';
    ''');
//log(result.toList().toString());
    final int? count = Sqflite.firstIntValue(result);
    //  await db.close();
    return count;
  }

  static Future<void> insertAproveCust(List<GetActivityApvdData> values) async {
    final Database db = await createDB();
    await db.rawQuery(
        "delete from $approvedCustomerTable where slpCode = ${GetValues.slpCode}");
    final data = values.map((e) => e.toMap()).toList();

    final batch = db.batch();
    data.forEach((es) async {
      batch.insert(approvedCustomerTable, es);
    });
    await batch.commit();
    log("commiteddd222222...");
  }

  static Future<void> dltAprovcust() async {
    final Database db = await createDB();
    await db.rawQuery(
        "delete from $approvedCustomerTable where slpCode = ${GetValues.slpCode}");
  }

//delete aproved cut
  // static Future<void> dltApvCus()async{
  //  final Database db = await createDB();
  //  db.rawQuery("delete from $approvedCustomerTable where slpCode = ${GetValues.slpCode}");
  //  final List<Map<String, Object?>> result =
  //    await db.rawQuery("SELECT * FROM $postCheckInModel");
  //   log('result deleted' + result.toString());
  // }
  // checkin
  static Future<List<CheckinModel>> getAlreadyCheckin() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        "SELECT * FROM $postCheckInModel where ifnull(status,'')  != 'C' ORDER BY PId DESC limit 1");

    log("result: ${result.toList()}");
    return List.generate(result.length, (i) {
      return CheckinModel(
        clgcode: int.parse(result[i]['clgcode'].toString()),
        ActivityDate: result[i]['ActivityDate'].toString(),
        ActivityTime: result[i]['ActivityTime'].toString(),
        StartDate: result[i]['StartDate'].toString(),
        StartTime: result[i]['StartTime'].toString(),
        U_Latitude: result[i]['ULatitude'].toString(),
        U_Longitude: result[i]['ULongitude'].toString(),
        U_CheckedIn: result[i]['UCheckedIn'].toString(),
        status: result[i]['status'].toString(),
        U_CheckinAdd: result[i]['UCheckinAdd'].toString(),
      );
    });
  }

  static Future<void> dltAlrchkddata() async {
    final Database db = await createDB();
    await db.rawQuery("delete from $postCheckInModel");
  }

  static Future<List<GetActivityApvdData>> getApprovedCustData() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        "Select * from $approvedCustomerTable where ifnull(status,'') != 'yes' and slpCode = '${GetValues.slpCode}'");
    log("custom,er list: ${result.toList()}");
    return List.generate(result.length, (i) {
      return GetActivityApvdData(
          ClgCode: int.parse(result[i]['ClgCode'].toString()),
          CardCode: result[i]['CardCode'].toString(),
          CardName: result[i]['CardName'].toString(),
          Name: result[i]['Name'].toString(),
          Details: result[i]['Details'].toString());
    });
  }

  static Future<List<GetActivityApvdData>> getSlctCustData(int clgcode) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        "Select * from $approvedCustomerTable where ClgCode = $clgcode and slpCode = ${GetValues.slpCode}");
    return List.generate(result.length, (i) {
      return GetActivityApvdData(
          ClgCode: int.parse(result[i]['ClgCode'].toString()),
          CardCode: result[i]['CardCode'].toString(),
          CardName: result[i]['CardName'].toString(),
          Name: result[i]['Name'].toString(),
          Details: result[i]['Details'].toString(),
          status: result[i]['status'].toString());
    });
  }

  static Future<void> updateStatus(int clgcode) async {
    final Database db = await createDB();
    db.rawQuery(
        "update $approvedCustomerTable set status = 'yes'  where ClgCode = $clgcode and slpCode = ${GetValues.slpCode}");
  }

  static Future<void> updateStatuschecdin(int clgcode) async {
    final Database db = await createDB();
    db.rawQuery(
        "update $postCheckInModel set status = 'C'  where clgcode = $clgcode");
  }

  static Future<int> insertPostCheckin(CheckinModel values) async {
    final Database db = await createDB();
    await db.rawQuery(
        "delete from $postCheckInModel where clgcode = ${values.clgcode}");
    final id = await db.insert(postCheckInModel, values.toMap());
    // print("inserted id: $id");
    final List<Map<String, Object?>> result =
        await db.rawQuery("Select * from $postCheckInModel");
    log("Result ${result.toList()}");
    return id;
  }

  static Future<List<CheckinModel>> getPostCheckinData() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        "Select * from $postCheckInModel where ifnull(status,'') != 'C' and UCheckedIn = 'Yes'");
    return List.generate(result.length, (i) {
      return CheckinModel(
        clgcode: int.parse(result[i]['clgcode'].toString()),
        ActivityDate: result[i]['ActivityDate'].toString(),
        ActivityTime: result[i]['ActivityTime'].toString(),
        StartDate: result[i]['StartDate'].toString(),
        StartTime: result[i]['StartTime'].toString(),
        U_Latitude: result[i]['ULatitude'].toString(),
        U_Longitude: result[i]['ULongitude'].toString(),
        U_CheckedIn: result[i]['UCheckedIn'].toString(),
        U_CheckinAdd: result[i]['UCheckinAdd'].toString(),
        status: result[i]['status'].toString(),
      );
    });
  }

  static Future<List<CheckinModel>> getAllPostCheckinData() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery("Select * from $postCheckInModel");
    return List.generate(result.length, (i) {
      return CheckinModel(
        clgcode: int.parse(result[i]['clgcode'].toString()),
        ActivityDate: result[i]['ActivityDate'].toString(),
        ActivityTime: result[i]['ActivityTime'].toString(),
        StartDate: result[i]['StartDate'].toString(),
        StartTime: result[i]['StartTime'].toString(),
        U_Latitude: result[i]['ULatitude'].toString(),
        U_Longitude: result[i]['ULongitude'].toString(),
        U_CheckedIn: result[i]['UCheckedIn'].toString(),
        U_CheckinAdd: result[i]['UCheckinAdd'].toString(),
        status: result[i]['status'].toString(),
      );
    });
  }

  /// check out
  static Future<int> insertPostCheckOut(CheckOutModel values) async {
    final Database db = await createDB();
    await db.rawQuery(
        "delete from $postCheckOutModel where clgCode = ${values.clgCode}");
    final id = await db.insert(postCheckOutModel, values.toMap());
    // print("inserted id: $id");
    final List<Map<String, Object?>> result =
        await db.rawQuery("Select * from $postCheckOutModel");
    log("Result ${result.toList()}");
    return id;
  }

  static Future<void> insertFiles(List<FilesPostData> values) async {
    final Database db = await createDB();
    await db.rawQuery("delete from $postFiles");
    final data = values.map((e) => e.toMap()).toList();

    final batch = db.batch();
    data.forEach((es) async {
      batch.insert(postFiles, es);
    });
    await batch.commit();
    log("commited Files...");
  }

  static Future<List<FilesPostData>> getFileData(int code) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery("Select * from $postFiles where clgcode = $code");
    log("Files: ${result.toList()}");
    return List.generate(result.length, (i) {
      return FilesPostData(
          filePath: result[i]['filePath'].toString(),
          clgcode: int.parse(result[i]['clgcode'].toString()));
    });
  }

  static Future<List<CheckOutModel>> getPostCheckoutData(int clgCode) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db
        .rawQuery("Select * from $postCheckOutModel where clgCode = $clgCode");
    log("check out Data: ${result.toList()}");
    return List.generate(result.length, (i) {
      return CheckOutModel(
        clgCode: int.parse(result[i]['clgCode'].toString()),
        closed: result[i]['Closed'].toString(),
        duration: double.parse(result[i]['Duration'].toString()),
        notes: result[i]['Notes'].toString(),
        closedate: result[i]['CloseDate'].toString(),
        durationType: result[i]['DurationType'].toString(),
        endTime: result[i]['EndTime']
            .toString(), //int.parse(result[i]['EndTime'].toString()),
        uAdvFormt: result[i]['UAdvFormt'].toString(),
        uAdvertise: result[i]['UAdvertise'].toString(),
        uBrandContr: result[i]['UBrandContr'].toString(),
        uBrandinPromo: result[i]['UBrandinPromo'].toString(),
        uCOLatitude: result[i]['UCOLatitude'].toString(),
        uCOLongitude: result[i]['UCOLongitude'].toString(),
        uCheckedIn: result[i]['UCheckedIn'].toString(),
        uComplaints: result[i]['UComplaints'].toString(),
        uLink1: result[i]['ULink1'].toString(),
        uLink2: result[i]['ULink2'].toString(),
        uLink3: result[i]['ULink3'].toString(),
        uLink4: result[i]['ULink4'].toString(),
        uNxtFollowup: result[i]['UNxtFollowup'].toString(),
        uOrdProsValue: double.parse(result[i]['UOrdProsValue'].toString()),
        uPPComp: result[i]['UPPComp'].toString(),
        uProducts: result[i]['UProducts'].toString(),
        uPymntVal: double.parse(result[i]['UPymntVal'].toString()),
        uRemarks1: result[i]['URemarks1'].toString(),
        uRemarks2: result[i]['URemarks2'].toString(),
        ustatus: result[i]['UStatus'].toString(),
        uConsultant: result[i]['UConsultant'].toString(),
        uProject: result[i]['UProject'].toString(),
        uCustomer: result[i]['UCustomer'].toString(),
        uSubgroup: result[i]['USubgroup'].toString(),
        uCheckOutAdd: result[i]['UCheckOutAdd'].toString(),
      );
    });
  }

  static Future<void> deleteALL() async {
    final Database db = await createDB();
    await db.rawQuery("delete from $postFiles");
    await db.rawQuery("delete from $postCheckOutModel");
    await db.rawQuery(
        "delete from $approvedCustomerTable where slpCode = ${GetValues.slpCode}");
    await db.rawQuery("delete from $postCheckInModel");
  }

  static Future<void> deleteFileCheckout(int clgcode) async {
    final Database db = await createDB();
    await db.rawQuery("delete from $postFiles where clgcode = $clgcode");
  }

  static Future<void> deletePostedCheckout(int clgcode) async {
    final Database db = await createDB();
    await db
        .rawQuery("delete from $postCheckOutModel where clgCode = $clgcode");
  }

  static Future<void> deletePostedCheckin(int clgcode) async {
    final Database db = await createDB();
    await db.rawQuery(
        "delete from $approvedCustomerTable where clgcode = $clgcode and slpCode = ${GetValues.slpCode}");
  }

  static Future<void> deleteApproved(int clgcode) async {
    final Database db = await createDB();
    await db.rawQuery("delete from $postCheckInModel where ClgCode = $clgcode");
  }

  static Future<void> checkdataHave() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery("Select * from $approvedCustomerTable");
    log("customer ${result.toList()}");
    final List<Map<String, Object?>> result2 =
        await db.rawQuery("Select * from $postCheckInModel");

    log("check in ${result2.toList()}");

    final List<Map<String, Object?>> result3 =
        await db.rawQuery("Select * from $postCheckOutModel");

    log("check out ${result3.toList()}");

    final List<Map<String, Object?>> result4 =
        await db.rawQuery("Select * from $postFiles");

    log("Files ${result4.toList()}");
  }

  static Future<int> insertData(Documents values, String tableName) async {
    final Database db = await createDB();
    final id = await db.insert(tableName, values.toMap());
    // print("inserted id: $id");
    return id;
  }

  static Future<int> insertItemData(
    ItemDocuments items,
    String itemTable,
  ) async {
    final Database db = await createDB();
    final id = await db.insert(itemTable, items.toMap());
    print("inserted item id: $id ...");
    return id;
  }

  static Future<void> deleteData(
      String cusID, String custable, String itemtable) async {
    final Database db = await createDB();
    final id = await db.rawQuery(
      "DELETE FROM $custable WHERE CusId='$cusID'",
    );
    final id2 = await db.rawQuery(
      "DELETE FROM $itemtable WHERE CusId='$cusID'",
    );
    print("deletedd id: $id");
    print("deletedd id: $id2");
  }

  static Future<List<Documents>> getCustData() async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.query(tablename);
    // PageState.cst = result;
    // var result = await db.
    print(result.toList());

    return List.generate(result.length, (i) {
      return Documents(
          cusID: result[i]['CusId'].toString(),
          billTo: result[i]['BillTo'].toString(),
          bPCode: result[i]['BPCode'].toString(),
          bPName: result[i]['BPName'].toString(),
          currency: result[i]['Currency'].toString(),
          cusRefNo: result[i]['CusRefNo'].toString(),
          docDate: result[i]['DocDate'].toString(),
          status: result[i]['Status'].toString(),
          gPApprovalReq: result[i]['GPApprovalReq'].toString(),
          orderRecDate: result[i]['OrderRecDate'].toString(),
          orderRecTime: result[i]['OrderRecTime'].toString(),
          postDate: result[i]['PostDate'].toString(),
          remarks: result[i]['Remarks'].toString(),
          salesEmp: result[i]['SalesEmp'].toString(),
          selectOrderType: result[i]['SelectOrderType'].toString(),
          shipTo: result[i]['ShipTo'].toString(),
          validUntil: result[i]['ValidUntil'].toString());
    });
  }

  static Future<List<ItemDocuments>> getItems(
      String cusTable, String cusID, String itemTable) async {
    final Database db = await createDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
        'select B.ItemCode, B.ItemName, B.Price ,B.Qty ,B.DisCount,B.ValueAFDisc,B.Total,B.WareHouseCose,B.Tax,B.TaxCode,B.Discounpercent,B.TaxCodeName,B.DeliveryDate from $cusTable A inner join $itemTable B on A.CusId=B.CusId WHERE A.CusId=$cusID');
    // PageState.cst = result;
    // var result = await db.
    log(result.toList().toString());

    return List.generate(result.length, (i) {
      return ItemDocuments(
        cusID: result[i]['CusId'].toString(),
        discounpercent: result[i]['Discounpercent'].toString(),
        discount: result[i]['DisCount'].toString(),
        itemCode: result[i]['ItemCode'].toString(),
        itemName: result[i]['ItemName'].toString(),
        price: result[i]['Price'].toString(),
        qty: result[i]['Qty'].toString(),
        tax: result[i]['Tax'].toString(),
        deliveryDate: result[i]['DeliveryDate'].toString(),
        taxCode: result[i]['TaxCode'].toString(),
        total: result[i]['Total'].toString(),
        wareHouseCose: result[i]['WareHouseCose'].toString(),
        taxCodeName: result[i]['TaxCodeName'].toString(),
        carton: result[i]['cartoon'].toString(),
        valueAFDisc: double.parse(result[i]['ValueAFDisc'].toString()),
      );
    });
  }
}

//    CusId integer FOREIGN KEY REFERENCES CustomerDetails(CusId),
//FOREIGN KEY (CusId) REFERENCES $tablename (CusId) ON DELETE NO ACTION ON UPDATE NO ACTION,
