class AppSettings {

  static final AppSettings _appSettings = AppSettings._();

  String? notesBox;
  String? isGridViewKey;
  String? indexCountKey;

  String colorBlack74 = '272727';
  String colorBlack70 = '313335';

  String colorWhite10 = '3D3D3D';
  String colorWhite38 = '858585';
  String colorWhite54 = 'A2A2A2';
  String colorWhite70 = 'B6B6B6';
  String colorWhite84 = 'DFDFDF';

  String colorRed = 'A8223A';
  String colorOrange = 'BB5E25';
  String colorYellow = 'CC9D27';
  String colorGreen = '19A046';
  String colorTurquoise = '22C4AE';
  String colorBlue = '227BB4';
  String colorPurple = '7B3BAE';
  String colorPink = 'AE3B7F';

  factory AppSettings() {
    return _appSettings;
  }

  AppSettings._();

}