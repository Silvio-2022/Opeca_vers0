
import 'package:SOP/src/business_logic/blocs/splash/splashBloc.dart';
import 'package:SOP/src/business_logic/blocs/splash/states/SplashState.dart';
import 'package:SOP/src/views/ui/Splash/unicaoWidgetsSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashscrem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Splashscrem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  throw UnimplementedError();
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: BlocProvider.of<SplashBloc>(context),
        builder: (context, state) {
          if (state is SplashExecutedState) {
            Future.delayed(
                Duration(seconds: 1),
                () =>
                    BlocProvider.of<SplashBloc>(context).inicioTempo(context));
          }

          return UnicaoWidgetsSplash();
        },
      ),
    );
  }
}
