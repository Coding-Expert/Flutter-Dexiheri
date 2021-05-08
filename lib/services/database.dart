import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/models/eggrafaTimologisis.dart';
import 'package:dexiheri/app/models/eggrafo.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/models/user.dart';
import 'package:dexiheri/services/api_path.dart';
import 'package:dexiheri/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Future<void> createUser(Xristis xristis);
  Future<void> setEggrafo(Eggrafo eggrafo);
  Future<void> setEggrafoTimologisis(EggrafoTimologisis eggrafoTimologisisData);
  Future<void> deleteJEggrafoTimologisis(EggrafoTimologisis eggrafoTimologisis);
  Stream<List<EggrafoTimologisis>> eggrafaTimologisisStream();
  Stream<List<Job>> jobsStream();
  Stream<List<Xristis>> xristisStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) => _service.setData(
        path: APIpath.job(uid, job.id),
        data: job.toJson(),
      );

  @override
  Future<void> deleteJob(Job job) => _service.deleteData(
        path: APIpath.job(uid, job.id),
      );

  @override
  Future<void> setEggrafo(Eggrafo eggrafo) => _service.setData(
        path: APIpath.eggrafo(uid, '11'),
        data: eggrafo.toMap(),
      );

  @override
  Future<void> setEggrafoTimologisis(
          EggrafoTimologisis eggrafoTimologisisData) =>
      _service.setData(
        path: APIpath.eggrafoTimologisi(uid, eggrafoTimologisisData.id),
        data: eggrafoTimologisisData.toMap(),
      );

  @override
  Stream<List<EggrafoTimologisis>> eggrafaTimologisisStream() => _service.collectionStream(
      path: APIpath.eggrafaTimologisi(uid),
      builder: (data, documentId) => EggrafoTimologisis.fromMap(data, documentId));

  @override
  Future<void> deleteJEggrafoTimologisis(EggrafoTimologisis eggrafoTimologisis) => _service.deleteData(
    path: APIpath.eggrafoTimologisi(uid, eggrafoTimologisis.id),
  );


  @override
  Future<void> createUser(Xristis xristis) => _service.setData(
        path: APIpath.xristis(uid),
        data: xristis.toMap(),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIpath.jobs(uid),
      builder: (data, documentId) => Job.fromMap(data, documentId));

  @override
  Stream<List<Xristis>> xristisStream() => _service.collectionStream(
      path: APIpath.xristis(uid),
      builder: (data, documentId) => Xristis.fromMap(data, documentId));
}
