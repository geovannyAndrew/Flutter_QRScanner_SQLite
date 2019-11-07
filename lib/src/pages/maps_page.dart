import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite_flutter/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Scan>>(
        future: DBProvider.db.getAllScans(),
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
                onDismissed: (DismissDirection direction) async => await DBProvider.db.deleteScan(scan.id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scan.value),
                  trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              );
           },
          );
        },
      ),
    );
  }
}