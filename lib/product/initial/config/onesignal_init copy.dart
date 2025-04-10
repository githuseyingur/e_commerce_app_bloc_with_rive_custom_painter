// import 'package:dersigo/product/initial/config/app_enviroment.dart';
// import 'package:dersigo/product/models/student_model.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class OnesignalInit {
//   OnesignalInit.initilaze() {
//     OneSignal.shared.setAppId(AppEnvironmentItems.onesignalAppId.value);
//     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//     OneSignal.shared.setRequiresUserPrivacyConsent(false);

// //! OneSignal Bildirim izni isteme
//     @override
//     Future<void> requestNotificationPermission() async {
//       PermissionStatus status = await Permission.notification.request();

//       if (status.isGranted) {
//         print('Bildirim izni verildi.');
//       } else if (status.isDenied) {
//         print('Bildirim izni reddedildi.');
//       } else if (status.isPermanentlyDenied) {
//         print('Bildirim izni kalıcı olarak reddedildi. Ayarlardan değiştirilebilir.');
//         //openAppSettings();
//       }
//     }

// //! OneSignal SMS numarası ayarlama
//     @override
//     Future<void> setSMSNumber() async {
//       OneSignal.shared.setSMSNumber(smsNumber: "05520702591").then((response) {
//         print("Onesignal Phone: $response");
//       }).catchError((error) {
//         print("Failed to set SMS Number with error: $error");
//       });
//     }

// //! OneSignal Email ayarlama
//     @override
//     Future<void> setEmail() async {
//       String _mail = student.email.toString();
//       print("onesignal email: $_mail");
//       OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//       OneSignal.shared.setAppId(AppEnvironmentItems.onesignalAppId.value);
//       //* Onesignal Set Email
//       OneSignal.shared.setEmail(email: _mail).then((results) {
//         print("OneSignal Email: ${_mail}");
//       }).catchError((error) {
//         print("OneSignalHata: " + error.toString());
//       });
//     }

//     //! Onesignal HandleSendNotification
//     Future<void> handleSendSilentNotification() async {
//       var deviceState = await OneSignal.shared.getDeviceState();

//       if (deviceState == null || deviceState.userId == null) return;

//       var playerId = deviceState.userId!;

//       print("PlayerId:$playerId}");
//     }

// //! Onesignal setNotificationOpenedHandler
//     @override
//     Future<void> setNotificationOpenedHandler() async {
//       OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//         print("setNotificationOpenedHandler: ${result.notification.title!}");
//         print("setNotificationOpenedHandler: ${result.notification.title!.toUpperCase()}");

//         var title = result.notification.title;
//         var message = result.notification.body;
//         //  MapEntry<String, dynamic> types = result.notification.additionalData!.entries.first; //! uygulamaya ait type türü olursa bu satırı aç örneğin bildiirm 1

//         //notificationController.addNotification(title: title!, message: message!, type: 2);

//         //! Bildirim sayfasını açacak kod eklenecek
//       });
//     }

// //! Onesignal setOnDidDismissInAppMessageHandler
//     @override
//     Future<void> setOnDidDismissInAppMessageHandler() async {
//       OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
//         print("OneSignal#onDidDismissInAppMessage: $message");
//       });
//     }

// //! Onesignal setNotificationWillShowInForegroundHandler
//     @override
//     Future<void> setNotificationWillShowInForegroundHandler() async {
//       OneSignal.shared.setNotificationWillShowInForegroundHandler((result) {
//         var title = result.notification.title;
//         var message = result.notification.body;
//         //  MapEntry<String, dynamic> types = result.notification.additionalData!.entries.first;

//         //    notificationController.addNotification(title: title!, message: message!, type: 2);

//         //! Bildirim sayfasını açacak kod eklenecek
//       });
//     }
//   }
// }
