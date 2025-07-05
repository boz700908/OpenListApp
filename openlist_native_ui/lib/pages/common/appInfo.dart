import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:openlist_config/config/config.dart';
import 'package:openlist_native_ui/l10n/generated/openlist_native_ui_localizations.dart';
import 'package:openlist_utils/toast.dart';
import '../../widgets/goToUrl.dart';

class AppInfoPage extends StatefulWidget {
  AppInfoPage({required Key key}) : super(key: key);

  @override
  _AppInfoPageState createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  //APP名称
  String appName = "";

  //包名
  String packageName = "";

  //版本名
  String version = "";
  String aListVersion = "";

  //版本号
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    _getAppInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List _result = [];
    _result.add("${OpenlistNativeUiLocalizations.of(context).app_name}$appName");
    _result.add("${OpenlistNativeUiLocalizations.of(context).package_name}$packageName");
    _result.add("${OpenlistNativeUiLocalizations.of(context).version}$version");
    _result.add("AList ${OpenlistNativeUiLocalizations.of(context).version}$aListVersion");
    _result.add("${OpenlistNativeUiLocalizations.of(context).version_sn}$buildNumber");
    // _result.add("${OpenlistNativeUiLocalizations.of(context).icp_number}皖ICP备2022013511号-3A");

    final tiles = _result.map(
      (pair) {
        return ListTile(
          title: Text(
            pair,
          ),
        );
      },
    );
    List<ListTile> tilesList = tiles.toList();
//     tilesList.add(ListTile(
//       title: Text(
//         OpenlistNativeUiLocalizations.of(context).feedback_channels,
//         style: TextStyle(color: Colors.green),
//       ),
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
// //              return Text("${pair.iP}:${pair.port}");
//           return FeedbackPage(
//             key: UniqueKey(),
//           );
//         }));
//       },
//     ));
//     TODO 支持信息待修改更新，旧代码是其他项目移植过来的
//     tilesList.add(ListTile(
//       title: Text(
//           OpenlistNativeUiLocalizations.of(context).online_feedback,
//         style: TextStyle(color: Colors.green),
//       ),
//       onTap: () {
//         launchURL("https://github.com/OpenListApp/OpenListApp");
//       },
//     ));
//     tilesList.add(ListTile(
//       title: Text(
//         OpenlistNativeUiLocalizations.of(context).privacy_policy,
//         style: TextStyle(color: Colors.green),
//       ),
//       onTap: () {
//         goToURL(context, "https://github.com/OpenListApp/OpenListApp",
//             OpenlistNativeUiLocalizations.of(context).privacy_policy);
//       },
//     ));
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tilesList,
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text(OpenlistNativeUiLocalizations.of(context).app_info), actions: <Widget>[
      ]),
      body: ListView(children: divided),
    );
  }

  _getAppInfo() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });

    final dio = Dio(BaseOptions(
        baseUrl: AListAPIBaseUrl));
    String reqUri = "/api/public/settings";
    // String reqUri = "/api/auth/login/hash";
    try {
      final response = await dio.getUri(Uri.parse(reqUri));
      if (response.statusCode == 200 && response.data["code"] == 200) {
        //  登录成功
        Map<String, dynamic> data = response.data;
        print(data["data"]["token"]);
        setState(() {
          aListVersion = data["data"]["version"];
        });
        return;
      } else {
        //  登录失败
        show_failed("Login failed", context);
      }
    } catch (e) {
      //  登录失败
      show_failed("Login failed:${e.toString()}", context);
      print(e.toString());
      return;
    }
  }
}
