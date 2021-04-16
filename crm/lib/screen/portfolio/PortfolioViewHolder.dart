import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/PortfolioModel.dart';

class PortfolioViewHolder extends StatelessWidget {
  final PortfolioModel _portfolioModel;

  const PortfolioViewHolder(this._portfolioModel);

  @override
  Widget build(BuildContext context) => Card(
    elevation: 4,
    child: Container(
      width: 300,
      height: 270,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
              image: CachedNetworkImageProvider(fileUrl(_portfolioModel.wallpaper), imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
              //gaplessPlayback: true,
              //filterQuality: FilterQuality.high,
              //isAntiAlias: true,
              fit: BoxFit.cover,
              width: 300,
              height: 190),
          Padding(
            padding: EdgeInsets.all(24),
            child: SizedBox(
              width: 270,
              child: Text(_portfolioModel.label,
                  style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    ),
  );
}
