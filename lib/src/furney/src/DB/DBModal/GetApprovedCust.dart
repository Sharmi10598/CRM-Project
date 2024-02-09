// ignore_for_file: file_names, prefer_final_locals, omit_local_variable_types, constant_identifier_names
const String approvedCustomerTable = 'ApprovedCustomer';

class ApprovedCustomer {
  static const String ClgCode = 'ClgCode';
  static const String CardCode = 'CardCode';
  static const String CardName = 'CardName';
  static const String Name = 'Name';
  static const String Details = 'Details';
  static const String status = 'status';
  static const String slpCode = 'slpCode';
}

const String postCheckInModel = 'PostCheckInModel';

class PostCheckInModel {
  static const String clgcode = 'clgcode';
  static const String ActivityDate = 'ActivityDate';
  static const String ActivityTime = 'ActivityTime';
  static const String StartDate = 'StartDate';
  static const String StartTime = 'StartTime';
  static const String U_Latitude = 'ULatitude';
  static const String U_Longitude = 'ULongitude';
  static const String U_CheckedIn = 'UCheckedIn';
  static const String U_CheckinAdd = 'UCheckinAdd';

  static const String status = 'status';
}

// check out
const String postFiles = 'postFiles';

class PostFilesModel {
  static const String filePath = 'filePath';
  static const String clgcode = 'clgcode';

  //static const String fileName = 'fileName';
}

const String postCheckOutModel = 'postCheckOut';

class PostCheckOut {
  static const String Notes = 'Notes';
  static const String U_NxtFollowup = 'UNxtFollowup';
  static const String U_COLatitude = 'UCOLatitude';
  static const String U_COLongitude = 'UCOLongitude';
  static const String UAdvertise = 'UAdvertise';
  static const String UAdvFormt = 'UAdvFormt';
  static const String U_Products = 'UProducts';
  static const String U_BrandContr = 'UBrandContr';
  static const String U_PPComp = 'UPPComp';
  static const String U_BrandinPromo = 'UBrandinPromo';
  static const String U_OrdProsValue = 'UOrdProsValue';
  static const String U_PymntVal = 'UPymntVal';
  static const String U_Complaints = 'UComplaints';
  static const String U_Remarks1 = 'URemarks1';
  static const String U_Remarks2 = 'URemarks2';
  static const String clgCode = 'clgCode';
  static const String Duration = 'Duration';
  static const String Closed = 'Closed';
  static const String CloseDate = 'CloseDate';
  static const String EndTime = 'EndTime';
  static const String UStatus = 'UStatus';
  static const String U_Link1 = 'ULink1';
  static const String U_Link2 = 'ULink2';
  static const String U_Link3 = 'ULink3';
  static const String U_Link4 = 'ULink4';
  static const String U_Project = 'UProject';
  static const String U_Customer = 'UCustomer';
  static const String U_Consultant = 'UConsultant';
  static const String U_Subgroup = 'USubgroup';
  static const String U_CheckOutAdd = 'UCheckOutAdd';
}

///

const String subGroupModel = 'subGroup';

class SubGroupModel {
  static const String name = 'name';
  static const String code = 'code';
  static const String selected = 'selected';
}

const String projectModel = 'activeProject';

class GetProjectModel {
  static const String projectName = 'projectName';
}
