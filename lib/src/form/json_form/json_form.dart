import 'package:flutter/material.dart';
import 'package:he/src/form/json_form/default_styles.dart';
import 'package:he/src/form/json_form/form_model.dart';
import 'package:he/src/form/json_form/tools.dart';

class JsonForm extends StatefulWidget {
  const JsonForm({super.key, required this.model, required this.onSubmit});
  final FormModel model;
  final void Function(Map<String, String> allInputs) onSubmit;

  @override
  State<JsonForm> createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  late Map<String, String> textFields = {};
  late Map<String, String> selectedDropdowns = {};

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(4),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          width: widget.model.width,
          height: widget.model.height,
          child: Column(
            spacing: 10,
            children: [
              if (widget.model.formName != null)
                Text(
                  widget.model.formName!,
                  style: fromNameStyle,
                ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: widget.model.items
                      .map((e) => _formItemToWidget(e))
                      .toList(),
                ),
              )),
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(Size(100, 20)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey[300]),
                        padding: WidgetStatePropertyAll(
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        textStyle: WidgetStatePropertyAll(
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        widget.onSubmit(textFields..addAll(selectedDropdowns));
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _formItemToWidget(FormItem item) {
    switch (item.type) {
      case FormItemType.text:
        return Align(
          alignment: parseAlignment(item.align),
          child: Text(
            item.text ?? "",
            style: parseTextStyle(item.style, defaultStyle: textStyle),
          ),
        );
      case FormItemType.input:
        return Align(
          alignment: parseAlignment(item.align),
          child: SizedBox(
            height: 30,
            child: TextField(
              style: textStyle,
              onChanged: (value) {
                textFields[item.uniqueId!] = value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                hintText: item.text,
                hintStyle: hintStyle,
              ),
            ),
          ),
        );
      case FormItemType.dropdown:
        return Align(
          alignment: parseAlignment(item.align),
          child: SizedBox(
            height: 30,
            child: DropdownButtonFormField<String>(
              value: selectedDropdowns[item.uniqueId!] ?? item.dropdownItems[0],
              onChanged: (value) {
                setState(() {
                  selectedDropdowns[item.uniqueId!] = value!;
                });
              },
              items: item.dropdownItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 12)),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: '请选择',
                isDense: false,
                contentPadding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              icon: Container(
                width: 30,
                height: 30,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 20,
                  ),
                ),
              ),
              style: textStyle,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      case FormItemType.title:
        return Align(
          alignment: parseAlignment(item.align),
          child: Text(
            item.text ?? "",
            style: parseTextStyle(item.style, defaultStyle: titleStyle),
          ),
        );
      case FormItemType.row:
        return Align(
          alignment: parseAlignment(item.align),
          child: Row(
            spacing: 5,
            children: item.children.map((e) {
              return Expanded(
                flex: 1,
                child: _formItemToWidget(e),
              );
            }).toList(),
          ),
        );
    }
  }
}
