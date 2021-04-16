import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/repository/AddressResponse.dart';
import 'package:zakazy_crm_v2/widget/CityAutoTextField.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

// ignore: must_be_immutable
class CitySelectWidget extends StatefulWidget {
  _CitySelectWidgetState? _state;

  final bool? hasCard;
  final bool? hasPading;

  CitySelectWidget({this.hasCard, this.hasPading});

  @override
  State<StatefulWidget> createState() {
    _state = _CitySelectWidgetState(hasCard ?? true, hasPading ?? true);

    return _state!;
  }

  CityModel? selectedCity() => _state?.selectedCity();
}

class _CitySelectWidgetState extends State<CitySelectWidget> {
  CityModel? _selectedCity;

  final _addressResponse = AddressResponse();

  bool isError = false;

  final hasCard;
  final hasPading;

  final _cityList = BehaviorSubject<List<CityModel>>.seeded([]);

  _onSearch(String text) async {
    final data = await _addressResponse.citySearch(text);
    if (text.isNotEmpty) {
      _cityList.add(data);
    } else {
      if (data.length > 5) {
        _cityList.add(data.sublist(0, 5));
      } else {
        _cityList.add(data);
      }
    }
  }

  @override
  void initState() {
    _onSearch("");
    super.initState();
  }

  _CitySelectWidgetState(this.hasCard, this.hasPading);

  @override
  void dispose() {
    _cityList.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: hasCard ? 4 : 0,
        child: Padding(
          padding: EdgeInsets.all(hasPading ? 24 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Выберите город",
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CityAutoTextField((city) => _selectedCity = city),
              Divider(
                height: 30,
                color: Colors.transparent,
              ),
              isError
                  ? Text(
                      "Необходимо выбрать город",
                      style: TextStyle(color: Colors.redAccent),
                    )
                  : Container()
            ],
          ),
        ),
      );

  _data() {
    return StreamBuilder<List<CityModel>>(
      stream: _cityList,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return _list(snapShot.requireData);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _list(List<CityModel> list) => SizedBox(
        width: 300,
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(4.0),
          constraints: BoxConstraints(minHeight: 50.0),
          isSelected: cityToggleData(list),
          direction: Axis.vertical,
          onPressed: (index) {
            setState(() {
              _selectedCity = list[index];
              isError = false;
            });
          },
          children: List.generate(list.length, (index) => cityRow(list[index])),
        ),
      );

  List<bool> cityToggleData(List<CityModel> list) {
    return list.map((e) => _selectedCity?.id == e.id).toList();
  }

  Widget cityRow(CityModel cityModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cityModel.name),
        VerticalDivider(
          width: 10,
        ),
        Text(
          cityModel.code.toString(),
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  CityModel? selectedCity() {
    if (_selectedCity == null) {
      setState(() {
        isError = true;
      });
    }

    return _selectedCity;
  }
}
