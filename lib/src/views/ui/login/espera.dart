import 'package:SOP/src/business_logic/blocs/login/events/loginEvent.dart';
import 'package:SOP/src/business_logic/blocs/login/loginBloc.dart';
import 'package:SOP/src/business_logic/blocs/login/states/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndicadorProgressoCircularUI extends StatefulWidget {
  @override
  State<IndicadorProgressoCircularUI> createState() => _IndicadorProgressoCircularUIState();
}

class _IndicadorProgressoCircularUIState extends State<IndicadorProgressoCircularUI> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFF3b98d4)),
            ),
          ),
        );
      }
    );
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () => BlocProvider.of<LoginBloc>(context).add(LoginValidatingCredentials()));
  }
}