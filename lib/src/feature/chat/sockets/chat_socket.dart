// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:studio_partner_app/src/res/base.dart';

// final socketServiceProvider = Provider((ref) => SocketService());

// class SocketService {
//   static final SocketService _instance = SocketService._internal();
//   factory SocketService() => _instance;
//   SocketService._internal();

//   IO.Socket? _socket;
//   bool _isConnected = false;
//   int _reconnectAttempts = 0;
//   final int _maxReconnectAttempts = 5;

//   /// ✅ Connects to the Socket.IO server
//   void connect(String userId) {
//     if (_isConnected || _socket?.connected == true) return;

//     String serverUrl = BasePaths.baseSocketUrl;
//     log("🔌 Connecting to Socket.IO: $serverUrl");

//     _socket = IO.io(serverUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false, // ✅ Correct way to disable auto-connect
//       'reconnection': true,
//       'reconnectionAttempts': _maxReconnectAttempts,
//       'reconnectionDelay': 2000, // Start with 2s delay
//     });

//     _socket?.connect();
//     _initializeEventHandlers(userId);
//   }

//   /// ✅ Handles all socket event listeners
//   void _initializeEventHandlers(String userId) {
//     _socket?.onConnect((_) {
//       _isConnected = true;
//       _reconnectAttempts = 0; // Reset attempts
//       log("✅ Connected to Socket.IO");
//       _socket?.emit('join', {"userId": userId});
//     });

//     _socket?.onDisconnect((_) {
//       _isConnected = false;
//       log("❌ Disconnected from Socket.IO");
//       _attemptReconnect();
//     });

//     _socket?.onError((data) {
//       log("⚠️ Socket Error: $data");
//       _attemptReconnect();
//     });

//     _socket?.onConnectError((err) {
//       log("⚠️ Connection Error: $err");
//       _attemptReconnect();
//     });

//     // 📩 New message received
//     _socket?.on("receive_message", (data) {
//       log("📩 New Message: $data");
//       _onNewMessage?.call(data);
//     });

//     // ⌨️ User typing event
//     _socket?.on("user_typing", (data) {
//       log("⌨️ User Typing: $data");
//       _onUserTyping?.call(data);
//     });

//     _socket?.on("user_stopped_typing", (data) {
//       log("🛑 User Stopped Typing: $data");
//       _onUserStoppedTyping?.call(data);
//     });

//     // ✅ Messages read
//     _socket?.on("messages_read", (data) {
//       log("✅ Messages Read: $data");
//       _onMessagesRead?.call(data);
//     });
//   }

//   /// ✅ Sends a message
//   void sendMessage(
//       String roomId, String senderId, String receiverId, String message) {
//     if (_socket?.connected ?? false) {
//       _socket?.emit("send_message", {
//         "roomId": roomId,
//         "senderId": senderId,
//         "receiverId": receiverId,
//         "text": message,
//       });
//     } else {
//       log("⚠️ Socket not connected. Message not sent.");
//     }
//   }

//   /// ✅ Handles typing events
//   void typingEvent(String roomId, String senderId, bool isTyping) {
//     if (_socket?.connected ?? false) {
//       _socket?.emit(isTyping ? "typing" : "stop_typing", {
//         "roomId": roomId,
//         "userId": senderId,
//       });
//     }
//   }

//   /// ✅ Marks messages as read
//   void markMessagesAsRead(String roomId, String userId) {
//     if (_socket?.connected ?? false) {
//       _socket?.emit("mark_as_read", {
//         "roomId": roomId,
//         "userId": userId,
//       });
//     }
//   }

//   /// ✅ Register callbacks for events
//   Function(Map<String, dynamic>)? _onNewMessage;
//   void onNewMessage(Function(Map<String, dynamic>) callback) {
//     _onNewMessage = callback;
//   }

//   Function(Map<String, dynamic>)? _onUserTyping;
//   void onUserTyping(Function(Map<String, dynamic>) callback) {
//     _onUserTyping = callback;
//   }

//   Function(Map<String, dynamic>)? _onUserStoppedTyping;
//   void onUserStoppedTyping(Function(Map<String, dynamic>) callback) {
//     _onUserStoppedTyping = callback;
//   }

//   Function(Map<String, dynamic>)? _onMessagesRead;
//   void onMessagesRead(Function(Map<String, dynamic>) callback) {
//     _onMessagesRead = callback;
//   }

//   /// ✅ Disconnects from the socket
//   void disconnect() {
//     _socket?.disconnect();
//     _socket = null;
//     _isConnected = false;
//     log("🚪 Disconnected from Socket.IO");
//   }

//   /// 🔄 Attempts reconnection with exponential backoff
//   void _attemptReconnect() {
//     if (_reconnectAttempts < _maxReconnectAttempts) {
//       _reconnectAttempts++;
//       int delay = 2000 * _reconnectAttempts; // Exponential backoff
//       log("🔄 Reconnecting in ${delay ~/ 1000}s...");

//       Future.delayed(Duration(milliseconds: delay), () {
//         if (!_isConnected) {
//           _socket?.connect();
//         }
//       });
//     } else {
//       log("❌ Max reconnection attempts reached. Please check your network.");
//     }
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:studio_partner_app/src/res/base.dart';

final socketServiceProvider = Provider((ref) => SocketService());

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;
  bool _isConnected = false;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;

  /// ✅ Connects to the Socket.IO server
  void connect(String userId) {
    if (_isConnected || (_socket?.connected ?? false)) return;

    String serverUrl = BasePaths.baseSocketUrl;
    log("🔌 Connecting to Socket.IO: $serverUrl");

    _socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': false,
    });

    _initializeEventHandlers(userId);
    _socket?.connect();
  }

  /// ✅ Handles all socket event listeners
  void _initializeEventHandlers(String userId) {
    _socket?.onConnect((_) {
      _isConnected = true;
      _reconnectAttempts = 0;
      log("✅ Connected to Socket.IO");
      _socket?.emit('join_room', {"userId": userId});
    });

    _socket?.onDisconnect((_) {
      _isConnected = false;
      log("❌ Disconnected from Socket.IO");
      _attemptReconnect(userId);
    });

    _socket?.onError((data) {
      log("⚠️ Socket Error: $data");
      _attemptReconnect(userId);
    });

    _socket?.onConnectError((err) {
      log("⚠️ Connection Error: $err");
      _attemptReconnect(userId);
    });

    _socket?.on("receive_message", (data) => _onNewMessage?.call(data));
    _socket?.on("user_typing", (data) => _onUserTyping?.call(data));
    _socket?.on(
        "user_stopped_typing", (data) => _onUserStoppedTyping?.call(data));
    _socket?.on("messages_read", (data) => _onMessagesRead?.call(data));
  }

  /// ✅ Sends a message
  void sendMessage(
      String roomId, String senderId, String receiverId, String message) {
    if (_isConnected) {
      _socket?.emit("send_message", {
        "roomId": roomId,
        "senderId": senderId,
        "receiverId": receiverId,
        "text": message,
      });
      log("📩 Message sent: $message");
    } else {
      log("⚠️ Socket not connected. Message not sent.");
    }
  }

  /// ✅ Handles typing events
  void typingEvent(String roomId, String senderId, bool isTyping) {
    if (_isConnected) {
      _socket?.emit(isTyping ? "typing" : "stop_typing", {
        "roomId": roomId,
        "userId": senderId,
      });
    }
  }

  /// ✅ Marks messages as read
  void markMessagesAsRead(String roomId, String userId) {
    if (_isConnected) {
      _socket?.emit("mark_as_read", {
        "roomId": roomId,
        "userId": userId,
      });
    }
  }

  /// ✅ Register callbacks for events
  Function(Map<String, dynamic>)? _onNewMessage;
  void onNewMessage(Function(Map<String, dynamic>) callback) =>
      _onNewMessage = callback;

  Function(Map<String, dynamic>)? _onUserTyping;
  void onUserTyping(Function(Map<String, dynamic>) callback) =>
      _onUserTyping = callback;

  Function(Map<String, dynamic>)? _onUserStoppedTyping;
  void onUserStoppedTyping(Function(Map<String, dynamic>) callback) =>
      _onUserStoppedTyping = callback;

  Function(Map<String, dynamic>)? _onMessagesRead;
  void onMessagesRead(Function(Map<String, dynamic>) callback) =>
      _onMessagesRead = callback;

  /// ✅ Disconnects from the socket
  void disconnect() {
    _socket?.disconnect();
    _socket = null;
    _isConnected = false;
    log("🚪 Disconnected from Socket.IO");
  }

  /// 🔄 Attempts reconnection with exponential backoff
  void _attemptReconnect(String userId) {
    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;
      int delay = 2000 * _reconnectAttempts;
      log("🔄 Reconnecting in ${delay ~/ 1000}s...");

      Future.delayed(Duration(milliseconds: delay), () {
        if (!_isConnected) {
          log("🔁 Attempting reconnect #$_reconnectAttempts");
          _socket?.connect();
        }
      });
    } else {
      log("❌ Max reconnection attempts reached. Please check your network.");
    }
  }
}
