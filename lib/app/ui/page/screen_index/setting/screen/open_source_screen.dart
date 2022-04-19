import 'package:flutter/material.dart';
import 'package:uni_meet/secret/license.dart';

class OpneSourceScreen extends StatelessWidget {
  const OpneSourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "오픈소스 라이센스",
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: BackButton(
          color: Colors.grey[800],
        ),
      ),
      body: ListView(
        children: license
            .map((x) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('*  ${x[0]}'),
                      SizedBox(height: 20,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            color: Colors.grey.withOpacity(0.3), child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(x[1]),
                            )),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
            ))
            .toList(),
      ),
    );
  }
}
