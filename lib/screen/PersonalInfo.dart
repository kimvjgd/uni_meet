import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:uni_meet/screen/widget/age_bottom_sheet.dart';
import 'package:uni_meet/screen/widget/signup_button.dart';
import 'package:uni_meet/secret/univ_list.dart';

enum Gender { MAN, WOMAN }

class AuthInfoScreen extends StatefulWidget {
  @override
  State<AuthInfoScreen> createState() => _AuthInfoScreenState();
}

class _AuthInfoScreenState extends State<AuthInfoScreen> {
  var _isChecked = false;
  Gender _gender = Gender.MAN;
  bool complete = false;
  int age = 20;

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController _univController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: _size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _intro(),
                    _genderSelection("성별"),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _textFormField("닉네임", "future"),
                          _agePicker("나이"),
                          _univPicker("대학교"),
                          _textFormField("학과", "컴퓨터정보학부"),
                          _textFormField("MBTI", "ENTP"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: signup_button(
        size: _size, // 나중에 bool complete로 색전환 구현
      ),
    );
  }

  Padding _textFormField(String category, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(flex: 4, child: TextFormField()),
          ],
        ),
      ),
    );
  }

  Padding _univPicker(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: TypeAheadField<String>(
                  suggestionsCallback: (String pattern) {
                    return univList.where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  itemBuilder: (BuildContext context, itemData) {
                    return ListTile(
                      title: Text(itemData),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    setState(() {
                      this._univController.text = suggestion;
                    });
                  },
                  textFieldConfiguration:
                      TextFieldConfiguration(controller: this._univController),
                )),
          ],
        ),
      ),
    );
  }

  Padding _agePicker(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return AgeBottomSheet(age: age);
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(age.toString()),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Padding _genderSelection(String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(category),
                )),
            Expanded(flex: 4, child: _genderRadio()),
          ],
        ),
      ),
    );
  }

  Row _genderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _gender = Gender.MAN;
              });
            },
            child: ListTile(
              title: Text(
                "남자",
                style: TextStyle(
                    color: _gender == Gender.MAN ? Colors.blue : Colors.black),
              ),
              leading: Radio(
                value: Gender.MAN,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _gender = Gender.WOMAN;
              });
            },
            child: ListTile(
              title: Text("여자",
                  style: TextStyle(
                      color: _gender == Gender.WOMAN
                          ? Colors.blue
                          : Colors.black)),
              leading: Radio(
                value: Gender.WOMAN,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _intro() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Text("""
안녕하세요!👋
즐거운 만남을 위해
당신에 대해 알려주세요."""),
          ),
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [Text('asda')],
      ),
    );
  }
}
