import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_lander/src/bean/User.dart';
import 'package:mobile_lander/src/net/DioUtils.dart';
import 'package:mobile_lander/src/net/http_helper.dart';
import 'package:mobile_lander/src/page/common/UserHelper.dart';
import 'package:mobile_lander/src/page/common/controller.dart';
import 'package:mobile_lander/src/utils/ToastUtils.dart';

import 'bg/bubble_widget.dart';
import 'custom_textfield_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

const String _TAG = "_TestPageState";

class _LoginPageState extends State<LoginPage> {
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _userNameFocusNode = new FocusNode();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  TextEditingController _userNameEditingController =
      new TextEditingController();

  //控制密码显示
  bool _passwordShow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            //第一层背景
            buildBackgroundWidget(),
            //第二层气泡
            Positioned(child: BubbleWidget()),
            //第三层 高斯模糊
            buildFilterWidget(),
            //第四层logo
            buildPositionedLogo(),
            //第五层输入层
            Positioned(
              bottom: 60,
              left: 60,
              right: 60,
              child: Column(
                children: [
                  //手机号
                  TextFieldWidget(
                    hintText: "手机号",
                    submit: (value) {
                      if (value.length != 11) {
                        ToastUtils.showToast("请输入11位手机号");
                        FocusScope.of(context).requestFocus(_userNameFocusNode);
                        return;
                      }
                      //手机号码框失去焦点
                      _userNameFocusNode.unfocus();
                      //密码框获得焦点
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    focusNode: _userNameFocusNode,
                    prefixIconData: Icons.phone,
                    controller: _userNameEditingController,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //密码
                  TextFieldWidget(
                    hintText: "密码",
                    submit: (value) {
                      if (value.length < 6) {
                        ToastUtils.showToast("请输入6位以上密码");
                        //密码框重新获取焦点
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                        return;
                      }
                      //手机输入框失去焦点
                      _userNameFocusNode.unfocus();
                      //密码输入框失去焦点
                      _passwordFocusNode.unfocus();

                      submitFunction();
                    },
                    focusNode: _passwordFocusNode,
                    prefixIconData: Icons.lock_open_outlined,
                    suffixIconData:
                        _passwordShow ? Icons.visibility : Icons.visibility_off,
                    obscureText: _passwordShow,
                    controller: _passwordEditingController,
                    onTap: () {
                      setState(() {
                        _passwordShow = !_passwordShow;
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //登录
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      child: Text(
                        "登录",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        submitFunction();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //注册
                  Container(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      child: Text(
                        "注册",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            //第六层
            buildCloseWidget(context)
          ],
        ),
      ),
    );
  }

  ///第六层 关闭按钮
  Positioned buildCloseWidget(BuildContext context) {
    return Positioned(
      left: 10,
      top: 64,
      child: CloseButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  //第一层背景
  Positioned buildBackgroundWidget() {
    return Positioned.fill(
        child: Container(
      //线性渐变
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightBlueAccent.withOpacity(0.3),
            Colors.blue.withOpacity(0.3)
          ])),
    ));
  }

  //插入一层 高斯模糊
  Positioned buildFilterWidget() {
    return Positioned.fill(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(
        color: Colors.white.withOpacity(0.3),
      ),
    ));
  }

  //第三层logo
  Positioned buildPositionedLogo() {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Row(
        //水平居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "logo",
            child: Material(
              color: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  "assets/image/app_icon.png",
                  width: 33,
                  height: 33,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "欢迎登录",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  void submitFunction() async {
    //获取用户名
    String userName = _userNameEditingController.text;
    //获取密码
    String passWord = _passwordEditingController.text;

    if (userName.trim().length != 11) {
      ToastUtils.showToast("请输入11位手机号码");
      return;
    }

    if (passWord.trim().length < 6) {
      ToastUtils.showToast("请输入6位密码");
      return;
    }

    Map<String, dynamic> map = {
      "mobile": userName,
      "password": passWord,
    };

    //网络请求  发起post请求
    // ResponseInfo responseInfo = await DioUtils.instance
    //     .postRequest(url: HttpHelper.login, formDataMap: map);

    //模拟登录成功
    ResponseInfo responseInfo =
        await Future.delayed(Duration(milliseconds: 1000), () {
      return ResponseInfo(data: {
        "userName": "测试数据",
        "age": 22,
      });
    });
    //响应成功
    if (responseInfo.success) {
//解析数据
      User user = User.formMap(responseInfo.data);
//内存保存数据
      UserHelper.getInstance.user = user;
      //提示框
      ToastUtils.showToast("登陆成功");
//关闭当前页
      Navigator.of(context).pop(true);
      //发送消息更新我的页面显示内容
      loginStreamController.add(0);
    } else {
      ToastUtils.showToast(responseInfo.message);
    }
  }
}
