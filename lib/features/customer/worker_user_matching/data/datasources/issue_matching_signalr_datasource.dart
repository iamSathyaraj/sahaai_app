

import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';

class IssueMatchingSignalRDataSource {
  final String hubUrl;
  final Future<String?> Function() getToken;

  HubConnection? _connection;
  final _statusController = StreamController<int>.broadcast();
  final _workerController = StreamController<Map<String, dynamic>>.broadcast();

  IssueMatchingSignalRDataSource({
    required this.hubUrl,
    required this.getToken,
  });

  /// Connect to SignalR hub for a specific issue
//   Future<void> connect(String issueId) async {
//     if (_connection != null &&
//         _connection!.state == HubConnectionState.Connected) {
//       return;
//     }

//     try {
//       final token = await getToken();
//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token available');
//       }

//       final options = HttpConnectionOptions(
//         accessTokenFactory: () async => token,
//       );

//       _connection = HubConnectionBuilder()
//           .withUrl(hubUrl, options: options)
//           .withAutomaticReconnect()
//           .build();

//       // Status change events
//       _connection!.on('ServiceRequestStatusChanged', (args) {
//         try {
//           if (args == null || args.isEmpty) return;
//           final statusInt = args.first as int;
//           _statusController.add(statusInt);
//         } catch (e) {
//           _statusController.addError(Exception('Bad status payload: $e'));
//         }
//       });

//       // Worker accepted events
//       _connection!.on('WorkerAccepted', (args) {
//         try {
//           if (args == null || args.isEmpty) return;
//           final json = Map<String, dynamic>.from(args.first as Map);
//           _workerController.add(json);
//         } catch (e) {
//           _workerController.addError(Exception('Bad worker payload: $e'));
//         }
//       });

//       // // Connection closed handling
//       // _connection!.onclose((error) {
//       //   if (error != null) {
//       //     _statusController.addError(Exception('Connection closed: $error'));
//       //   }
//       // });

// // Connection closed handling
// _connection!.onclose((Exception? error) {
//   if (error != null) {
//     _statusController.addError(Exception('Connection closed: $error'));
//   }
// });


//       // Start connection
//       await _connection!.start();
      
//       // Join specific issue room/group
//       await _connection!.invoke('JoinIssue', args: [issueId]);
      
//     } catch (e) {
//       throw Exception('Failed to connect SignalR: $e');
//     }
//   }

Future<void> connect(String issueId) async {
  if (_connection != null &&
      _connection!.state == HubConnectionState.Connected) {
    return;
  }

  try {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token available');
    }

    final options = HttpConnectionOptions(
      accessTokenFactory: () async => token,
    );

    _connection = HubConnectionBuilder()
        .withUrl(hubUrl, options: options)
        .withAutomaticReconnect()
        .build();

    _connection!.on('ServiceRequestStatusChanged', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final statusInt = args.first as int;
        _statusController.add(statusInt);
      } catch (e) {
        _statusController.addError(Exception('Bad status payload: $e'));
      }
    });

    _connection!.on('WorkerAccepted', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final json = Map<String, dynamic>.from(args.first as Map);
        _workerController.add(json);
      } catch (e) {
        _workerController.addError(Exception('Bad worker payload: $e'));
      }
    });

 

    await _connection!.start();
    await _connection!.invoke('JoinIssue', args: [issueId]);
    
  } catch (e) {
    throw Exception('Failed to connect SignalR: $e');
  }
}


  Stream<int> statusStream(String issueId) => _statusController.stream;

  Stream<Map<String, dynamic>> workerStream(String issueId) => 
      _workerController.stream;

  /// Disconnect and cleanup
  Future<void> disconnect() async {
    try {
      await _connection?.stop();
    } finally {
      _connection = null;
    }
  }

  HubConnectionState? get connectionState => _connection?.state;

  /// Is currently connected
  bool get isConnected => 
      _connection?.state == HubConnectionState.Connected;
}
