import 'package:SOP/src/business_logic/blocs/aprovarReprovar/aprovarReprovarBloc.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/events/aprovarReprovarEvent.dart';
import 'package:SOP/src/business_logic/blocs/aprovarReprovar/states/aprovarReprovarState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressoCircularUI extends StatefulWidget {
  @override
  State<ProgressoCircularUI> createState() =>
      _IndicadorProgressoCircularUIState();
}

class _IndicadorProgressoCircularUIState extends State<ProgressoCircularUI> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AprovarReprovarBloc, AprovarReprovarState>(
        bloc: BlocProvider.of<AprovarReprovarBloc>(context),
        builder: (context, state) {
          return Scaffold(
          resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                //leading: RetrocederButton(telaRetroceder: 'aprovarReprovar'),
                elevation: 4.0,
                backgroundColor: Colors.red[900],
                /*title: Text(state.a.dados[0].valor +'                ' +state.a.operationId, // ${id}
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )*/
                centerTitle: true,
              ),
            body: Align(
              alignment: Alignment.bottomRight,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        () => BlocProvider.of<AprovarReprovarBloc>(context)
            .add(LoadAprovarReprovarEvent()));
  }
}
