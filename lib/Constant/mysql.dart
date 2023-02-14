import 'package:mysqli/mysqli.dart';

class Mysql {
  static String host = 'localhost',
          user = 'root',
          password = '',
          db = 'vigenesia';
  static int port = 21;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings {
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
  return await MySqlConnection.connect(settings);
    }
  }
}