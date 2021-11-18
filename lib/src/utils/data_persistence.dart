import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:openim_enterprise_chat/src/models/call_records.dart';
import 'package:openim_enterprise_chat/src/models/login_certificate.dart';
import 'package:openim_enterprise_chat/src/utils/sp_util.dart';
import 'package:sprintf/sprintf.dart';

class DataPersistence {
  static const _FREQUENT_CONTACTS = "%s_frequentContacts";
  static const _CALL_RECORDS = "%s_callRecords";
  static const _LOGIN_INFO = 'loginCertificate';
  static const _AT_USER_INFO = '%s_atUserInfo';
  static const _SERVER = "server";

  DataPersistence._();

  static LoginCertificate? getLoginCertificate() {
    return SpUtil.parseObject(
        _LOGIN_INFO, (v) => LoginCertificate.fromJson(v.cast()));
  }

  static Future<bool?> putLoginCertificate(LoginCertificate info) {
    return SpUtil.putObject(_LOGIN_INFO, info);
  }

  static String getKey(String key) {
    return sprintf(key, [OpenIM.iMManager.uid]);
  }

  /// 常用联系人
  static List<String> getFrequentContacts() {
    return SpUtil.getStringList(getKey(_FREQUENT_CONTACTS));
  }

  /// 常用联系人
  static Future<bool?> putFrequentContacts(List<String> uidList) {
    return SpUtil.putStringList(getKey(_FREQUENT_CONTACTS), uidList);
  }

  static Future<bool?> addCallRecords(CallRecords records) {
    var list = SpUtil.getObjectList(getKey(_CALL_RECORDS)) ?? [];
    list.insert(0, records.toJson());
    return SpUtil.putObjectList(getKey(_CALL_RECORDS), list);
  }

  static Future<bool?> putCallRecords(List<CallRecords> list) {
    return SpUtil.putObjectList(getKey(_CALL_RECORDS), list);
  }

  static List<CallRecords> getCallRecords() {
    return SpUtil.parseObjectList(
      getKey(_CALL_RECORDS),
      (v) => CallRecords.fromJson(v.cast()),
    );
  }

  static Future<bool?> putAtUserMap(String gid, Map<String, String> atMap) {
    return SpUtil.putObject(sprintf(_AT_USER_INFO, [gid]), atMap);
  }

  static Map? getAtUserMap(String gid) {
    return SpUtil.getObject(sprintf(_AT_USER_INFO, [gid]));
  }

  static void removeAtUserMap(String gid) {
    SpUtil.remove(sprintf(_AT_USER_INFO, [gid]));
  }

  static Future<bool?> putServerConfig(Map<String, String> config) {
    return SpUtil.putObject(_SERVER, config);
  }

  static Map? getServerConfig() {
    return SpUtil.getObject(_SERVER);
  }
}
