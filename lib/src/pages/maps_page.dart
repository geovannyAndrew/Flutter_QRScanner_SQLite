import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/bloc/scans_bloc.dart';
import 'package:qrscanner_sqlite_flutter/src/models/scan_model.dart';
import 'package:qrscanner_sqlite_flutter/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {

  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Scan>>(
        stream: scansBloc.scansStream ,
        builder: (BuildContext context, AsyncSnapshot<List<Scan>> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final scans = snapshot.data;
          if(scans.isEmpty){
            return Center(
              child: Text('There is not information'),
            );
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              final scan = scans[index];
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (DismissDirection direction) async => await scansBloc.deleteScan(scan.id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scan.value),
                  subtitle: Text('#${scan.id}'),
                  trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  onTap: () => utils.launchScan(scan),
                ),
              );
           },
          );
        },
      ),
    );
  }
}