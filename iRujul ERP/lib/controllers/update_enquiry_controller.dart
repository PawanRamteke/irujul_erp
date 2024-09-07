import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/followup_stage_model.dart';
import 'package:irujul_erp/models/lost_reason_model.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';

import '../models/enquiry_list_model.dart';
import '../utils/app_manager.dart';

class UpdateEnquiryController extends GetxController {
  TextEditingController followUpStage = TextEditingController();
  TextEditingController lostReason = TextEditingController();
  TextEditingController followUpDate = TextEditingController();
  TextEditingController followUpTime = TextEditingController();
  TextEditingController nextFollowUpDate = TextEditingController();
  TextEditingController nextFollowUpTime = TextEditingController();
  TextEditingController expectedClosureDate = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController progress = TextEditingController();

  AppRepository appRepository = AppRepository();
  List<String> leadCategory = [];
  List<FollowUpStageModel> followupStages = [];
  List<LostReasonModel> lostReasons = [];
  EnquiryListModel? model;
  RxString selectedFollowupStageId = "".obs;
  RxString selectedLostReasonId = "".obs;

  getLeadCategoryApi() async {
    dynamic response = await appRepository.getRecordsAPI("lead_category");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      leadCategory = list.map((element) => element["Name"].toString()).toList();
    }
  }

  getFollowUpStageApi() async {
    dynamic response = await appRepository.getRecordsAPI("follow_up_stage");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      followupStages = list.map((element) => FollowUpStageModel.fromJson(element)).toList();
    }
  }

  getLostReasonApi() async {
    dynamic response = await appRepository.getLostReasonApi();
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      lostReasons = list.map((element) => LostReasonModel.fromJson(element)).toList();
    }
  }

  showLeadCategoryDropDown() {
    AppManager.shared.showActionSheet(leadCategory,"Select Category", (index) => {
      category.text = leadCategory[index]
    });
  }

  showFollowupStagesDropDown() {
    List<String> list = followupStages.map((model) => model.name ?? "").toList();
    AppManager.shared.showActionSheet(list,"Select Follow Up Stage", (index) {
      followUpStage.text = list[index];
      selectedFollowupStageId.value = followupStages[index].iD ?? "";
      progress.text = followupStages[index].percentage ?? "";
      lostReason.text = "";
      selectedLostReasonId.value = "";
    });
  }

  showLostReasonDropDown() {
    List<String> list = lostReasons.map((model) => model.text ?? "").toList();
    AppManager.shared.showActionSheet(list,"Select Lost Reason", (index) {
      lostReason.text = list[index];
      selectedLostReasonId.value = lostReasons[index].value ?? "";
    });
  }

  _validate() {
    if(selectedFollowupStageId.isEmpty) {
      AppManager.showToast("Please select follow up stage");
      return false;
    }
    if(selectedFollowupStageId == "5" && selectedLostReasonId.isEmpty) {
      AppManager.showToast("Please select lost reason");
      return false;
    }
    if(nextFollowUpDate.text.isEmpty)  {
      AppManager.showToast("Please select Next follow up date");
      return false;
    }
    if(nextFollowUpTime.text.isEmpty)  {
      AppManager.showToast("Please select Next follow up time");
      return false;
    }
    if(expectedClosureDate.text.isEmpty)  {
      AppManager.showToast("Please select expected closure date");
      return false;
    }
    if(category.text.isEmpty)  {
      AppManager.showToast("Please select category");
      return false;
    }
    if(progress.text.isEmpty)  {
      AppManager.showToast("Please enter progress");
      return false;
    }
    if(remark.text.isEmpty)  {
      AppManager.showToast("Please enter remark");
      return false;
    }
    return true;
  }

  updateEnquiryApi() async {
    if(!_validate()) {
      return false;
    }
    dynamic request = {
      "module": "enquiry",
      "TXNID": model?.header?.iD ?? "",
      "VisibleTo":"",
      "Category": category.text,
      "FollowUpBy": AppManager.shared.loginModel?.defaultExecutive,
      "FollowUpDate": AppManager.shared.convertDateFormat(followUpDate.text, "dd/MM/yyyy", "yyyy-MM-dd"),
      "FollowUpTime": "${followUpTime.text}:00",
      "Remark": remark.text ?? "",
      "NxtFollowUpBy": AppManager.shared.loginModel?.defaultExecutive,
      "NxtFollowUpDate":AppManager.shared.convertDateFormat(nextFollowUpDate.text, "dd/MM/yyyy", "yyyy-MM-dd"),
      "NxtFollowUpTime": "${nextFollowUpTime.text}:00",
      "ProgressPercentage": progress.text,
      "ExpectedClosureDate": AppManager.shared.convertDateFormat(expectedClosureDate.text, "dd/MM/yyyy", "yyyy-MM-dd"),
      "StageID": selectedFollowupStageId.value,
      "LostReason" : selectedLostReasonId.value,
    };

    dynamic response =  await appRepository.updateEnquiryAPI(request);
    if(response != null && response["status"] == 200) {
      AppManager.showToast(response["message"]);
      return true;
    } else {
      AppManager.showToast("Something is wrong!. Please try again.");
      return false;
    }
  }


}