import 'package:attendancer_final_code/backend/class_attendance_provider.dart';
import 'package:attendancer_final_code/backend/class_data_provider.dart';
import 'package:attendancer_final_code/backend/data_provider.dart';
import 'package:attendancer_final_code/configs/app_config.dart';
import 'package:attendancer_final_code/screens/class_attendance.dart';
import 'package:attendancer_final_code/screens/swipe_screen.dart';
import 'package:attendancer_final_code/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassList extends StatefulWidget {
  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  void initState() {
    Provider.of<BackEnd>(context, listen: false).getclass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BackEnd, ClassDataProvider, ClassAttendanceProvider>(
      builder: (context, data, classData, attendanceData, child) => data
                  .classList.length !=
              0
          ? GridView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.75,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: data.classList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (data.classList[index]['isdone'] == 0) {
                      classData.setClassData(data.classList[index]);
                      classData.buildStudentIdList();
                      classData.clearAttendance();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SwipeScreen();
                      }));
                    } else {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.warning),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('Warning'),
                                ],
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Attendance of this class for today is already done. Do you want to take more attendance?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    classData
                                        .setClassData(data.classList[index]);
                                    classData.buildStudentIdList();
                                    classData.clearAttendance();
                                    Navigator.of(context).pop();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SwipeScreen();
                                    }));
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  onLongPress: () {
                    attendanceData.setClassData(data.classList[index]);
                    attendanceData.buildStudentIdList();
                    attendanceData.getAttendanceByDate();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ClassAttendance();
                    }));
                  },
                  child: ClassListTile(
                    index: index,
                    data: data.classList,
                  ),
                );
              })
          : Center(child: MyText(text: "Add class to continue.", size: 20)),
    );
  }
}

class ClassListTile extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> data;

  const ClassListTile({Key key, this.index, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${data[index]['classname']}',
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: textStyle(24, FontWeight.normal, kFontColor)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Students: ${data[index]['end'] - data[index]['start'] + 1}",
                    style: textStyle(14, FontWeight.normal, kFontColor)),
                Icon(
                  Icons.add,
                  size: 14,
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: data[index]['isdone'] == 0
              ? Colors.green[300]
              : Colors.grey[400]),
    );
  }
}
