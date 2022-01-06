import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissonRequestWidget extends StatefulWidget {
  final Permission permission;
  final List<String> permissionList;
  final bool isCloseApps;
  final String leftButtonText;

  PermissonRequestWidget(
      {required this.permission,
      required this.permissionList,
      this.leftButtonText = "在考虑一下",
      this.isCloseApps = false});

  @override
  _PermissonRequestWidget createState() {
    // TODO: implement createState
    return _PermissonRequestWidget();
  }
}

class _PermissonRequestWidget extends State<PermissonRequestWidget>
    with WidgetsBindingObserver {
  bool _isGoSetting = false;

  @override
  void initState() {
    super.initState();
    checkPermisson();

    //注册观察者
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermisson();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //注销观察者
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  ///[PermissionStatus.denied] 用户拒绝访问所请求的特性
  ///[PermissionStatus.granted] 用户被授予对所请求特性的访问权。
  ///[PermissionStatus.restricted] iOS 平台 用户拒绝这个权限
  ///[PermissionStatus.limited] 用户已授权此应用程序进行有限访问。
  ///[PermissionStatus.permanentlyDenied] 被永久拒绝
  void checkPermisson({PermissionStatus? status}) async {
    //存储权限
    Permission permission = widget.permission;

    status ??= await permission.status;
    if (status.isPermanentlyDenied) {
      //第二次申请用户拒绝
      showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
          isSetting: true);
    } else if (status.isDenied) {
      //用户第一次申请拒绝
      showPermissonAlert(widget.permissionList[0], "同意", permission);
    } else {
      //通过
      Navigator.of(context).pop(true);
    }
  }

  void showPermissonAlert(String msg, String rightStr, Permission permission,
      {bool isSetting = false}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Text(msg),
            ),
            actions: [
              //左边按钮
              CupertinoDialogAction(
                child: Text(widget.leftButtonText),
                onPressed: () {
                  if (widget.isCloseApps) {
                    closeApp();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              //右边按钮
              CupertinoDialogAction(
                child: Text(rightStr),
                onPressed: () {
                  //关闭弹框
                  Navigator.of(context).pop();
                  if (isSetting) {
                    //去设置中心
                    _isGoSetting = true;
                    openAppSettings();
                  } else {
                    //申请权限
                    _isGoSetting = false;
                    requestPermission(permission);
                  }
                },
              )
            ],
          );
        });
  }

  void requestPermission(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    //再次校验
    checkPermisson(status: status);
  }

  void closeApp() {
    //关闭应用的方法
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
