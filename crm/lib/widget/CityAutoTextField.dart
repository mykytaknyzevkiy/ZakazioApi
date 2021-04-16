import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/repository/AddressResponse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class CityAutoTextField extends StatefulWidget {
  final Function(CityModel? cityModel) onSelect;
  CityModel? selectedCity;

  CityAutoTextField(this.onSelect);

  @override
  State<StatefulWidget> createState() => _CityAutoTextField(onSelect, selectedCity);
}

class _CityAutoTextField extends State<CityAutoTextField>
    with WidgetsBindingObserver {
  final Function(CityModel? cityModel) onSelect;
  CityModel? selectedCity;

  final _addressRepository = AddressResponse();

  //final TextEditingController _typeAheadController = TextEditingController();

  final _list = BehaviorSubject<List<CityModel>>.seeded(null);

  final FocusNode _focusNode = FocusNode();

  late ZTextField _textField = ZTextField(
      hint: "Город",
      focusNode: _focusNode,
      txt: selectedCity?.name,
      onEdit: (txt) async {
        _list.add(null);
        final data = await _addressRepository.citySearch(txt);
        _list.add(data);
      });

  OverlayEntry? _overlayEntry;

  _CityAutoTextField(this.onSelect, this.selectedCity);

  /*@override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Введете название города",
            labelText: "Город",
        ),
        controller: _typeAheadController
      ),
      suggestionsCallback: (query) => _addressRepository.citySearch(query),
      itemBuilder: (context, CityModel cityModel) => ListTile(
        title: Text(cityModel.name),
        subtitle: Text(cityModel.region!.name),
      ),
      onSuggestionSelected: (CityModel city) {
        _typeAheadController.text = city.name;
        onSelect.call(city);
      },
    ),
  );*/

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(this._overlayEntry!);
      } else {
        this._overlayEntry?.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: LayerLink(),
        child: SizedBox(
          width: double.infinity,
          child: _textField,
        ),
      );

  OverlayEntry _createOverlayEntry() {
    final renderObj = context.findRenderObject();
    final renderBox = renderObj as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 2.0,
              width: size.width,
              child: Material(
                elevation: 4,
                child: _listData(),
              ),
            ));
  }

  @override
  void dispose() {
    _list.close();
    this._overlayEntry?.remove();
    super.dispose();
  }

  _listData() => StreamBuilder<List<CityModel>>(
      stream: _list,
      builder: (context, snapshot) {
        child() {
          if (!snapshot.hasData)
            return Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              ),
            );
          final data = snapshot.requireData;
          return ListView(
            shrinkWrap: true,
            children: List.generate(data.length + 1, (index) {
              if (index == 0) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      this._focusNode.unfocus();
                      this._textField.setText("");
                      this.onSelect(null);
                      // this._focusNode.
                    },
                    child: ListTile(title: Text("Закрыть/Очистить")),
                  ),
                );
              }
              final cityModel = data[index - 1];
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    this._focusNode.unfocus();
                    this._textField.setText(cityModel.name);
                    this.onSelect(cityModel);
                    // this._focusNode.
                  },
                  child: ListTile(
                    title: Text(cityModel.name),
                    subtitle: Text(cityModel.region!.name),
                  ),
                ),
              );
            }),
          );
        }

        return Container(
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 250),
          child: child(),
        );
      });
}
