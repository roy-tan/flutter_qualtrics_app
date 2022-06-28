import 'package:flutter/material.dart';
import 'package:qualtrics_digital_flutter_plugin/qualtrics_digital_flutter_plugin.dart';

void main() => runApp(const FlutterTestApp());

class FlutterTestApp extends StatelessWidget {
  const FlutterTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Test App',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('FlutterTestApp'),
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: const [InterceptDetails()],
                ),
              ));
            })));
  }
}

class InterceptDetails extends StatefulWidget {
  const InterceptDetails({Key? key}) : super(key: key);

  @override
  _InterceptDetailsState createState() => _InterceptDetailsState();
}

class _InterceptDetailsState extends State<InterceptDetails> {
  String brandId = '';
  String zoneId = '';
  String interceptId = '';

  final _brandIdController = TextEditingController();
  final _zoneIdController = TextEditingController();
  final _interceptIdController = TextEditingController();
  final _resultTextFieldController = TextEditingController();
  final _extRefIdTextFieldController = TextEditingController();
  final _stringCustomPropertyKeyController = TextEditingController();
  final _stringCustomPropertyValueController = TextEditingController();
  final _numberCustomPropertyKeyController = TextEditingController();
  final _numberCustomPropertyValueController = TextEditingController();
  final _viewNameController = TextEditingController();
  final _dateNameKeyController = TextEditingController();

  var qualtrics = QualtricsDigitalFlutterPlugin();

  @override
  Widget build(BuildContext context) {
    _brandIdController.text = "techsalesemea";
    _zoneIdController.text = "ZN_2rx1pNJP9FCYCPk";
    _interceptIdController.text =
        "SI_2lAUQ2hOB30opaS"; //Mobile Embedded Short Feedback
    //_interceptIdController.text =
    "SI_eFeJWgP0xaS5SNU"; //Mobile Sample App Feedback
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField("brandId", _brandIdController),
                  const SizedBox(width: 10.0),
                  _getTextField("zoneId", _zoneIdController),
                  const SizedBox(width: 10.0),
                  _getTextField("interceptId", _interceptIdController)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('interceptId', textAlign: TextAlign.center)),
                  _getDropdownButton()
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField("extRefId", _extRefIdTextFieldController),
                  const SizedBox(width: 10.0),
                  _getTextButton(
                      "InitializeWithExtRefId", _initializeWithExtRefId)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextButton("InitializeProject", _initializeProject),
                  const SizedBox(width: 10.0),
                  _getTextButton("EvaluateProject", _evaluateProject),
                  const SizedBox(width: 10.0),
                  _getTextButton("Display", _display)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextButton("EvaluateIntercept", _evaluateIntercept),
                  const SizedBox(width: 10.0),
                  _getTextButton("DisplayIntercept", _displayIntercept),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField(
                      "StringKey", _stringCustomPropertyKeyController),
                  const SizedBox(width: 10.0),
                  _getTextField(
                      "StringValue", _stringCustomPropertyValueController),
                  const SizedBox(width: 10.0),
                  _getTextButton("SetString", _setString)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField(
                      "NumberKey", _numberCustomPropertyKeyController),
                  const SizedBox(width: 10.0),
                  _getTextField(
                      "NumberValue", _numberCustomPropertyValueController),
                  const SizedBox(width: 10.0),
                  _getTextButton("SetNumber", _setNumber)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField("DateKey", _dateNameKeyController),
                  const SizedBox(width: 10.0),
                  _getTextButton("SetDateTime", _setDateTime)
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTextField("viewName", _viewNameController),
                  const SizedBox(width: 10.0),
                  _getTextButton("RegisterViewVisit", _registerViewVisit)
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      child: TextField(
                          key: const Key("resultBox"),
                          enabled: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          minLines: 3,
                          controller: _resultTextFieldController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          )))
                ]),
          ],
        ));
  }

  Widget _getTextField(String hintText, TextEditingController controller) {
    return Flexible(
        child: TextField(
      controller: controller,
      key: Key(hintText),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: hintText,
      ),
    ));
  }

  Widget _getTextButton(String buttonText, Function() onPress) {
    return TextButton(
        onPressed: onPress, child: Text(buttonText), key: Key(buttonText));
  }

  Future<void> _initializeProject() async {
    var initResults = await qualtrics.initializeProject(
        _brandIdController.text, _zoneIdController.text);
    _resultTextFieldController.text = initResults.toString();
  }

  Future<void> _initializeWithExtRefId() async {
    var initResults = await qualtrics.initializeProjectWithExtRefId(
        _brandIdController.text,
        _zoneIdController.text,
        _extRefIdTextFieldController.text);
    _resultTextFieldController.text = initResults.toString();
  }

  Future<void> _evaluateProject() async {
    String result = "";
    var evaluateProjectResult = await qualtrics.evaluateProject();
    for (var interceptId in evaluateProjectResult.keys) {
      var targetingResult =
          evaluateProjectResult[interceptId]!.cast<String, String>();
      var passed = targetingResult["passed"];
      var surveyUrl = targetingResult["surveyUrl"];
      result = '$result\n$interceptId: passed: $passed surveyUrl: $surveyUrl';
    }
    _resultTextFieldController.text = result;
  }

  Future<void> _display() async {
    var displayed = await qualtrics.display();
    _resultTextFieldController.text = displayed.toString();
  }

  Future<void> _evaluateIntercept() async {
    String result = "";
    _interceptIdController.text = ddInterceptId;
    var evaluateInterceptResult =
        await qualtrics.evaluateIntercept(_interceptIdController.text);
    result =
        '${evaluateInterceptResult["interceptId"]}: passed: ${evaluateInterceptResult["passed"]}, surveyUrl: ${evaluateInterceptResult["surveyUrl"]}';
    _resultTextFieldController.text = result;
  }

  Future<void> _displayIntercept() async {
    _interceptIdController.text = ddInterceptId;
    var displayed =
        await qualtrics.displayIntercept(_interceptIdController.text);
    _resultTextFieldController.text = displayed.toString();
  }

  Future<void> _setString() async {
    await qualtrics.setString(_stringCustomPropertyKeyController.text,
        _stringCustomPropertyValueController.text);
  }

  Future<void> _setNumber() async {
    await qualtrics.setNumber(_numberCustomPropertyKeyController.text,
        double.parse(_numberCustomPropertyValueController.text));
  }

  Future<void> _setDateTime() async {
    await qualtrics.setDateTime(_dateNameKeyController.text);
  }

  Future<void> _registerViewVisit() async {
    await qualtrics.registerViewVisit(_viewNameController.text);
  }

  String ddInterceptId = "SI_2lAUQ2hOB30opaS";
  Widget _getDropdownButton() {
    return DropdownButton<String>(
      value: ddInterceptId,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      hint: Text("interceptId"),
      onChanged: (String? newValue) {
        setState(() {
          ddInterceptId = newValue!;
        });
      },
      items: <String>['SI_2lAUQ2hOB30opaS', 'SI_eFeJWgP0xaS5SNU']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
