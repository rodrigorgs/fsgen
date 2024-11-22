import 'package:serverpod/serverpod.dart';
import 'package:template_server/src/generated/protocol.dart';

class TaskEndpoint extends Endpoint {
  Future<List<Task>> find(Session session) async {
    return await Task.db.find(session, orderBy: (x) => x.id);
  }

  Future<Task?> findById(Session session, int id) async {
    return await Task.db.findById(session, id);
  }

  Future<Task> insert(Session session, Task task) async {
    return await Task.db.insertRow(session, task);
  }

  Future<void> update(Session session, Task task) async {
    await Task.db.updateRow(session, task);
  }

  Future<void> delete(Session session, Task task) async {
    await Task.db.deleteRow(session, task);
  }
}
