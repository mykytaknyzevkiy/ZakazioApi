import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/category/CategoryModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class CategoryViewHolder extends StatelessWidget {
  final CategoryModel _category;
  final Function(CategoryModel)? _onEdit;

  const CategoryViewHolder(this._category, this._onEdit);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Image(
            width: 60,
            image: NetworkImage(_category.imageUrl != null
                ? fileUrl(_category.imageUrl!)
                : "https://cdn1.iconfinder.com/data/icons/condominium-juristic-management-filled-outline/64/resolving_problems-resolving-problems-512.png"),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          Text(
            _category.name,
            style: TextStyle(
              fontSize: 18
            )
          ),
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          (_onEdit != null)
          ? SmallButton(
              title: "Изменить",
              onPressed: () => _onEdit?.call(_category),
              isEnable: true)
          : Container()
        ],
      ),
    )
  );



}