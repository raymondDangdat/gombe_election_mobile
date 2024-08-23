// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mide/Widgets/custom_text.dart';
// import 'package:mide/providers/notifications_provider.dart';
// import 'package:mide/resources/constants/color_constants.dart';
// import 'package:mide/resources/constants/dimension_constants.dart';
// import 'package:mide/resources/constants/font_constants.dart';
// import 'package:mide/resources/constants/image_constant.dart';
// import 'package:mide/ui/bottom_nav_screens/widgets/white_app_bar.dart';
// import 'package:mide/utils/functions.dart';
// import 'package:mide/widgets/custom_appbar.dart';
// import 'package:provider/provider.dart';
// import '../../../models/notification_model.dart';
// import '../../../widgets/long_divider.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final notificationsProvider =
//           Provider.of<NotificationsProvider>(context, listen: false);
//       notificationsProvider.getNotifications(
//           context: context, isGetAllTransactions: true);
//       notificationsProvider.updateHasNewNotification(false);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBgColor2,
//       appBar: whiteAppBar,
//       body: SafeArea(
//           top: false,
//           bottom: false,
//           child: Consumer<NotificationsProvider>(
//               builder: (ctx, notificationProvider, child) {
//             return Column(
//               children: [
//                 CustomAppbar(
//                   title: "Notifications",
//                   actionWidget: InkWell(
//                     onTap: () {
//                       notificationProvider.markAllAsRead();
//                     },
//                     child: const BodyTextPrimaryWithLineHeight(
//                       text: "Mark All as Read",
//                       textColor: mainColor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Expanded(
//                     child: notificationProvider.loadingNotifications
//                         ? const CupertinoActivityIndicator()
//                         : ListView.builder(
//                             itemCount:
//                                 notificationProvider.notificationList.length,
//                             itemBuilder: (context, index) {
//                               final notification =
//                                   notificationProvider.notificationList[index];
//                               return NotificationItem(
//                                 notification: notification,
//                                 markAsReadTap: () {
//                                   if (!notification.hasRead) {
//                                     notificationProvider.markNotificationAsRead(
//                                         index, notification);
//                                   }
//                                 },
//                               );
//                             }))
//               ],
//             );
//           })),
//     );
//   }
// }
//
// class NotificationItem extends StatelessWidget {
//   final VoidCallback markAsReadTap;
//   final NotificationData notification;
//   const NotificationItem(
//       {super.key, required this.notification, required this.markAsReadTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//           left: horizontalPadding.w, right: horizontalPadding.w, bottom: 10.h),
//       child: Container(
//         decoration: BoxDecoration(
//             color: whiteTextColor, borderRadius: BorderRadius.circular(12.r)),
//         padding:
//             EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 SvgPicture.asset(notificationItemIcon),
//                 const SizedBox(
//                   width: 3,
//                 ),
//                 BodyTextPrimaryWithLineHeight(
//                   text: notification.title,
//                   textColor: primaryTextColor,
//                   fontWeight: semiBoldFont,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 3,
//             ),
//             BodyTextPrimaryWithLineHeight(
//               text: notification.description,
//               textColor: const Color.fromRGBO(64, 68, 76, 1),
//             ),
//             const SizedBox(
//               height: 3,
//             ),
//             BodyTextPrimaryWithLineHeight(
//               text: notification.description,
//               textColor: const Color.fromRGBO(64, 68, 76, 1),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             const LongDivider(),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BodyTextPrimaryWithLineHeight(
//                   text: returnFormattedDate(notification.createdAt.toString()),
//                 ),
//                 InkWell(
//                   onTap: markAsReadTap,
//                   child: BodyTextPrimaryWithLineHeight(
//                       text: notification.hasRead ? 'Read' : "Mark as read",
//                       textColor: notification.hasRead
//                           ? const Color.fromRGBO(128, 131, 135, 1)
//                           : mainColor),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
