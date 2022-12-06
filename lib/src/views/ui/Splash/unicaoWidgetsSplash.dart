import 'package:SOP/src/business_logic/blocs/splash/events/SplashEvent.dart';
import 'package:SOP/src/business_logic/blocs/splash/splashBloc.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:SOP/src/views/ui/Splash/indicadorProgressoCircularUI.dart';
import 'package:SOP/src/views/ui/Splash/splashLogoUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnicaoWidgetsSplash extends StatefulWidget {
  @override
  State<UnicaoWidgetsSplash> createState() => _UnicaoWidgetsSplashState();
}

class _UnicaoWidgetsSplashState extends State<UnicaoWidgetsSplash> {
  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration(seconds: 3), () => BlocProvider.of<SplashBloc>(context).add(SplashGetConnectionSuccess()));
    return BlocBuilder<SplashBloc, SplashState>(
        bloc: BlocProvider.of<SplashBloc>(context),
        builder: (context, state) {
          return Stack(
            children: [
              SplashLogoUI(),
              IndicadorProgressoCircularUI(),
            ],
          );
        });
  }
  @override
  initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3), () => BlocProvider.of<SplashBloc>(context).add(SplashProcessed()));
  }
}
