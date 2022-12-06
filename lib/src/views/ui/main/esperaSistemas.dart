import 'package:SOP/src/business_logic/blocs/main/events/mainEvent.dart';
import 'package:SOP/src/business_logic/blocs/main/mainBloc.dart';
import 'package:SOP/src/business_logic/blocs/main/states/mainState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndicadorProgressoCircularUIMain extends StatefulWidget {
  @override
  State<IndicadorProgressoCircularUIMain> createState() =>
      _IndicadorProgressoCircularUIMain();
}

class _IndicadorProgressoCircularUIMain
    extends State<IndicadorProgressoCircularUIMain> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red[900]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        () =>
            BlocProvider.of<MainBloc>(context).add(MainGetConnectionSuccess()));
  }
}
