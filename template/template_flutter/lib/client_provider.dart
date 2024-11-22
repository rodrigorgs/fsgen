import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_client/template_client.dart';

part 'client_provider.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  return Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
}
