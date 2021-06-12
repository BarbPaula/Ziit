import 'package:mysql1/mysql1.dart';

var settings = new ConnectionSettings(
    host: '162.214.174.120',
    port: 3306,
    user: 'barbpaul_root_app',
    password: 'mkti2@21',
    db: 'barbpaul_app_ziit');

getCon() async {
  return await MySqlConnection.connect(settings);
}
