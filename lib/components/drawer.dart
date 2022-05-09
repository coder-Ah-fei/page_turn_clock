import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 抽屉
class MyDrawer extends StatefulWidget {

  final List? clocks;

  const MyDrawer({Key? key, this.clocks}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  createListTilesForClockFun() {
    int _currentClockIndex = Provider.of<TextStyleState>(context).clockIndex;
    List<ListTile> list = [];
    for (int i = 0; i < (widget.clocks?.length ?? 0); i++) {
      list.add(ListTile(
        title: Text(widget.clocks![i]['title'], style: TextStyle(fontSize: _currentClockIndex == i ? 20:16, color: Colors.white),),
        selected: _currentClockIndex == i,
        onTap: () {
          setState(() {
            Provider.of<TextStyleState>(context, listen: false).setClockIndex(i);
          });
        },
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController =
        TextEditingController(text: Provider.of<TextStyleState>(context).text);
    return Drawer(
      backgroundColor: const Color.fromARGB(215, 52, 52, 52),
      child: ListView(
        children: <Widget>[
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24,
            ),
            title: Text(
              '设置',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ExpansionTile(
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            title: const Text(
              '主题',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            children: [
              Container(
                height: 150,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: createListTilesForClockFun(),
                  ),
                ),
              ),
            ],
          ),
          // ExpansionTile(
          //   trailing: const Icon(
          //     Icons.keyboard_arrow_down,
          //     color: Colors.white,
          //   ),
          //   title: const Text(
          //     '声音设置',
          //     style: TextStyle(color: Colors.white, fontSize: 16),
          //   ),
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Switch(
          //         onChanged: (bool value) {
          //           Provider.of<TextStyleState>(context, listen: false)
          //               .setOpenSound(value);
          //         },
          //         value: Provider.of<TextStyleState>(context).openSound,
          //       ),
          //     ),
          //   ],
          // ),
          ExpansionTile(
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            title: const Text(
              '日期设置',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  onChanged: (bool value) {
                    Provider.of<TextStyleState>(context, listen: false)
                        .setShowDateText(value);
                  },
                  value: Provider.of<TextStyleState>(context).showDateText,
                ),
              ),
              BlockPicker(
                pickerColor: Provider.of<TextStyleState>(context).dateTextColor,
                onColorChanged: (v) {
                  Provider.of<TextStyleState>(context, listen: false)
                      .setDateTextColor(v);
                },
              ),
            ],
          ),
          ExpansionTile(
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            title: const Text(
              '时间设置',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            children: [
              BlockPicker(
                pickerColor: Provider.of<TextStyleState>(context).timeTextColor,
                onColorChanged: (v) {
                  Provider.of<TextStyleState>(context, listen: false)
                      .setTimeTextColor(v);
                },
              ),
            ],
          ),
          ExpansionTile(
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            title: const Text(
              '文字设置',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  onChanged: (bool value) {
                    Provider.of<TextStyleState>(context, listen: false)
                        .setShowText(value);
                  },
                  value: Provider.of<TextStyleState>(context).showText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                  ),
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  minLines: 3,
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.grey,
                                    filled: true,
                                  ),
                                  controller: _textEditingController,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 3,
                                  minLines: 3,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).unfocus();
                                    _textEditingController.text = v;
                                    Provider.of<TextStyleState>(context,
                                            listen: false)
                                        .setText(v);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ));
                  },
                ),
              ),
              BlockPicker(
                // MaterialPicker(
                pickerColor: Provider.of<TextStyleState>(context).textColor,
                onColorChanged: (v) {
                  Provider.of<TextStyleState>(context, listen: false)
                      .setTextColor(v);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
