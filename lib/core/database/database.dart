import 'package:postgres/postgres.dart';

class DatabaseConfig {

  PostgreSQLConnection database = PostgreSQLConnection(
        '192.168.1.10',
        5432,
        'eternodb',
        username: 'ndprtm',
        password: 'App211196',
      );

  Future<PostgreSQLConnection> getConnection() async {
    if(database.isClosed){
      await database.open();
    }

    return database;
  }
}
