import 'package:covid_statistics/ui/widgets/app_colors.dart';
import 'package:covid_statistics/ui/widgets/view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  Widget _buttonSendMessage() {
    return Container(
      margin: EdgeInsets.only(right: View.x * 7, left: View.x * 2),
      child: TextButton.icon(
        onPressed: () async => await launch('sms:081212123119'),
        style: TextButton.styleFrom(
          minimumSize: Size(View.x * 10, View.y * 8),
          backgroundColor: lightblue2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(View.x * 5),
          ),
        ),
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
        label: Text(
          'Kirim Pesan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buttonContactUs() {
    return Container(
      margin: EdgeInsets.only(left: View.x * 7, right: View.x * 2),
      child: TextButton.icon(
        onPressed: () async => await launch('tel:119'),
        style: TextButton.styleFrom(
          minimumSize: Size(View.x * 10, View.y * 8),
          backgroundColor: red2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(View.x * 5),
          ),
        ),
        icon: Icon(
          Icons.call,
          color: Colors.white,
        ),
        label: Text(
          'Hubungi Kami',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _flexibleSpace() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: View.x * 100,
            padding: EdgeInsets.only(top: View.y * 3, left: View.x * 7),
            child: Text(
              'Siaga Covid',
              style: TextStyle(
                fontSize: View.x * 8,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: View.x * 100,
            margin: EdgeInsets.only(left: View.x * 7, top: View.y * 1),
            child: Text(
              'Anda merasakan gejala?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: View.x * 5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: View.x * 100,
            padding: EdgeInsets.only(left: View.x * 7, right: View.x * 7),
            child: Text(
              'Jika anda merasakan gejala covid-19, segera hubungi pelayanan medis terdekat',
              style: TextStyle(
                fontSize: View.x * 5,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: View.x * 100,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buttonContactUs(),
                ),
                Expanded(
                  flex: 1,
                  child: _buttonSendMessage(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(View.x * 30),
          bottomRight: Radius.circular(View.x * 30),
        ),
      ),
      leading: Container(),
      expandedHeight: View.y * 45,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 50,
      backgroundColor: darkblue,
      flexibleSpace: _flexibleSpace(),
      stretchTriggerOffset: 15,
    );
  }

  Widget _titlePrevention() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(View.x * 7),
        child: Text(
          'Protokol Kesehatan',
          style: TextStyle(
            fontSize: View.x * 5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _contentBox({String hint, String imagePath}) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(
          left: View.x * 5,
          right: View.x * 5,
        ),
        child: Column(
          children: [
            Container(
              child: Image.asset(imagePath),
            ),
            Container(
              child: Text(
                hint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: View.x * 3.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentPrevention() {
    return SliverToBoxAdapter(
      child: Container(
        width: View.x * 100,
        height: View.y * 20,
        child: Row(
          children: [
            _contentBox(
              hint: 'Menjaga jarak',
              imagePath: 'assets/images/distance.png',
            ),
            _contentBox(
              hint: 'Mencuci tangan',
              imagePath: 'assets/images/wash_hands.png',
            ),
            _contentBox(
              hint: 'Mengenakan masker',
              imagePath: 'assets/images/mask.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox() {
    return SliverToBoxAdapter(
      child: Container(
        height: View.y * 15,
        margin: EdgeInsets.only(
          left: View.x * 5,
          right: View.x * 5,
          bottom: View.x * 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(View.x * 5),
          color: darkblue,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/own_test.png',
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: View.x * 5,
                      ),
                      child: Text(
                        'Stay safe and keep healhty',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        bottom: View.x * 1,
                        right: View.x * 1,
                      ),
                      child: Text(
                        'Selalu patuhi protokol kesehatan, minum multivitamin bila perlu untuk menjaga daya tahan tubuh anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: View.x * 3.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _appBar(),
        _titlePrevention(),
        _contentPrevention(),
        _infoBox(),
      ],
    );
  }
}
