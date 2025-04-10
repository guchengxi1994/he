enum FormItemType { title, text, input, dropdown, row }

FormItemType parseFormItemType(String type) {
  switch (type) {
    case 'title':
      return FormItemType.title;
    case 'text':
      return FormItemType.text;
    case 'input':
      return FormItemType.input;
    case 'dropdown':
      return FormItemType.dropdown;
    case 'row':
      return FormItemType.row;
    default:
      throw Exception('Unknown form item type: $type');
  }
}

class FormModel {
  final String? formName;
  final List<FormItem> items;
  final double height;
  final double width;

  FormModel(
      {required this.formName,
      required this.items,
      required this.height,
      required this.width});

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      height: json['height'],
      width: json['width'],
      formName: json['form-name'],
      items: (json['items'] as List)
          .map((item) => FormItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'form-name': formName,
        'height': height,
        'width': width,
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class FormItem {
  final FormItemType type;
  final String? style;
  final String? text;
  final String? align;
  final String? uniqueId;
  final List<FormItem> children;

  FormItem({
    required this.type,
    this.style,
    this.text,
    this.align,
    this.uniqueId,
    required this.children,
  }) {
    if (type == FormItemType.dropdown || type == FormItemType.input) {
      assert(uniqueId != null, "uniqueId is required for dropdown and input");
    }
    if (type == FormItemType.row) {
      assert(children.isNotEmpty, "children is required for row");
      if (children.isNotEmpty) {
        for (final i in children) {
          if (i.type == FormItemType.dropdown || i.type == FormItemType.input) {
            assert(i.uniqueId != null,
                "uniqueId is required for dropdown and input '${i.type}'");
          }
        }
      }
    }
  }

  /// Getter for dropdown options
  List<String> get dropdownItems {
    if (type == FormItemType.dropdown && text != null) {
      return text!.split(';').map((e) => e.trim()).toList();
    }
    return [];
  }

  factory FormItem.fromJson(Map<String, dynamic> json) {
    return FormItem(
      type: parseFormItemType(json['type']),
      style: json['style'],
      text: json['text'],
      align: json['align'],
      uniqueId: json['uniqueId'], // 从 JSON 读取时仍保留旧字段名
      children: (json['children'] as List)
          .map((child) => FormItem.fromJson(child))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'style': style,
        'text': text,
        'align': align,
        'uniqueId': uniqueId,
        'children': children.map((child) => child.toJson()).toList(),
      };
}
