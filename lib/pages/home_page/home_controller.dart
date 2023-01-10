import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/model/request_register.dart';
import 'package:flutter_blog/util/save/sp_util.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late UserEntity userInfo;

  ///浏览历史长度
  RxInt browseHistory = 0.obs;

  /// 更新用户信息，每次进入时更新
  void notifyUserInfo() {
    RequestRepository.getUserInfo(success: (data) {
      userInfo = data;
      SpUtil.notifyUserInfo(userInfo);
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    var info = SpUtil.getUserInfo();
    notifyBrowseHistory();
    if (info != null) {
      userInfo = info;
      update();
    }
  }

  ///更新历史记录长度
  void notifyBrowseHistory() {
    browseHistory.value = SpUtil.getBrowseHistoryLength();
  }
}
