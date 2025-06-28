import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../l10n/generated/openlist_native_ui_localizations.dart';
import 'package:openlist_global/openlist_global.dart';
import '../common/appInfo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String useremail = "";
  String usermobile = "";

  String userAvatar = "";

  late List<ListTile> _listTiles;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initListTiles();
    return Scaffold(
        extendBody: true, //底部NavigationBar透明
        extendBodyBehindAppBar: true, //顶部Bar透明
        appBar: AppBar(
          // shadowColor: Colors.transparent,
          toolbarHeight: 0,
          backgroundColor: Provider.of<CustomTheme>(context).isLightTheme()
              ? CustomThemes.light.primaryColor
              : CustomThemes.dark.primaryColor,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildHeader();
            }
            // if (index == _listTiles.length+1) {
            //   return buildYLHBanner();
            // }
            index -= 1;
            return _buildListTile(index);
          },
          separatorBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 50), // 添加左侧缩进
              child: TDDivider(),
            );
          },
          itemCount: _listTiles.length + 1,
        ));
  }

  Container _buildHeader() {
    return Container(
      color: Provider.of<CustomTheme>(context).isLightTheme()
          ? CustomThemes.light.primaryColor
          : CustomThemes.dark.primaryColor,
      height: 150.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  _initListTiles() {
    setState(() {
      _listTiles = <ListTile>[
        // ListTile(
        //   //第二个功能项
        //     title: Text(OpenlistNativeUiLocalizations.of(context).system),
        //     leading: Icon(TDIcons.system_2, color: Colors.blue),
        //     trailing: const Icon(Icons.arrow_right),
        //     onTap: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => SystemPage()));
        //     }),
        // ListTile(
        //   //第二个功能项
        //     title: Text(OpenlistNativeUiLocalizations.of(context).settings),
        //     leading: Icon(TDIcons.book_filled, color: Colors.orange),
        //     trailing: const Icon(Icons.arrow_right),
        //     onTap: () {
        //       String url = "$AListAPIBaseUrl/@manage/settings/site";
        //       if (Platform.isMacOS || Platform.isIOS) {
        //         launchURL(url);
        //         return;
        //       }
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => WebScreen(
        //             startUrl: url,
        //           )));
        //     }),
        // ListTile(
        //     //第二个功能项
        //     title: Text(OpenlistNativeUiLocalizations.of(context).docs),
        //     leading: Icon(TDIcons.book_filled, color: Colors.green),
        //     trailing: const Icon(Icons.arrow_right),
        //     onTap: () {
        //       String url = "https://alistgo.com/guide/";
        //       if (Platform.isMacOS || Platform.isIOS) {
        //         launchURL(url);
        //         return;
        //       }
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => WebScreen(
        //             startUrl: url,
        //           )));
        //     }),
        ListTile(
            //第二个功能项
            title: Text(OpenlistNativeUiLocalizations.of(context).about),
            leading: Icon(TDIcons.info_circle, color: Colors.purple),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              // open_mobile_service.run();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppInfoPage(
                        key: UniqueKey(),
                      )));
            }),
      ];
    });
  }

  ListTile _buildListTile(int index) {
    return _listTiles[index];
  }

  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }
}
