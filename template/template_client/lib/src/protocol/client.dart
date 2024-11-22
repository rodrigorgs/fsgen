/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:template_client/src/protocol/task.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointTask extends _i1.EndpointRef {
  EndpointTask(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  _i2.Future<List<_i3.Task>> find() =>
      caller.callServerEndpoint<List<_i3.Task>>(
        'task',
        'find',
        {},
      );

  _i2.Future<_i3.Task?> findById(int id) =>
      caller.callServerEndpoint<_i3.Task?>(
        'task',
        'findById',
        {'id': id},
      );

  _i2.Future<_i3.Task> insert(_i3.Task task) =>
      caller.callServerEndpoint<_i3.Task>(
        'task',
        'insert',
        {'task': task},
      );

  _i2.Future<void> update(_i3.Task task) => caller.callServerEndpoint<void>(
        'task',
        'update',
        {'task': task},
      );

  _i2.Future<void> delete(_i3.Task task) => caller.callServerEndpoint<void>(
        'task',
        'delete',
        {'task': task},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    example = EndpointExample(this);
    task = EndpointTask(this);
  }

  late final EndpointExample example;

  late final EndpointTask task;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'task': task,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
