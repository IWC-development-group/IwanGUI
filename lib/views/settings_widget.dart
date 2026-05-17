import 'package:flutter/material.dart';
import 'package:iwangui/styles/dark_theme.dart';
import 'package:iwangui/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingPageNavigator extends StatelessWidget {
  const SettingPageNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(builder:(context) => SettingPage())
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage ({super.key});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<TextEditingController> _textControllers = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    var model = Provider.of<SettingsViewModel>(context, listen: false);
    await model.loadConfig();
    _textControllers = [];
    for (var url in model.getUrls()) {
      _textControllers.add(TextEditingController(text: url));
    }
  }

  Future<void> _saveConfig(List<String> urls) async {
    var model = Provider.of<SettingsViewModel>(context, listen: false);
    model.setUrls(urls);
    await model.saveConfig();
  }

  void _deleteElement(int index) {
    setState(() {
      _textControllers.removeAt(index);
    });
  }

  void _addElement() {
    setState(() {
      _textControllers.add(TextEditingController(text: ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.right,
        thumbVisibility: true,
        interactive: true,
        controller: _scrollController,
        child: Consumer<SettingsViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: 
                    ListView.builder(
                      itemCount: _textControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 5),
                          child: 
                          Row(
                            children: [
                              Expanded(
                                child: 
                                  TextField(
                                    controller: _textControllers[index],
                                    decoration: InputDecoration(labelText: "URL"),
                                  )
                              ),
                              IconButton(
                                onPressed: (){
                                  _deleteElement(index);
                                }, 
                                style: DarkTheme.textButtonStyle,
                                icon: Icon(Icons.delete))
                            ]
                          )
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                    IconButton(
                      onPressed: (){
                        _addElement();
                      }, 
                      style: DarkTheme.textButtonStyle,
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: (){
                        List<String> urlList = [];
                        for (var controller in _textControllers) {
                          urlList.add(controller.text);
                        }
                        _saveConfig(urlList);
                      }, 
                      style: DarkTheme.textButtonStyle,
                      icon: Icon(Icons.save),
                    ),
                    IconButton(
                      onPressed: (){
                        _loadConfig();
                      }, 
                      style: DarkTheme.textButtonStyle,
                      icon: Icon(Icons.update),
                      )
                    ]
                  )
                ],
              );
            },
          )
      )
    );
  }
}