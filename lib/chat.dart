// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';


// class ChatDetailsScreen extends StatelessWidget {
//   var messageController = TextEditingController();
//   SocialUserModel userModel;
//   ChatDetailsScreen({this.userModel});
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         SocialLayoutCubit.get(context).getMessage(receiverId: userModel.uId);
//         return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 titleSpacing: 0.0,
//                 title: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20.0,
//                       backgroundImage: NetworkImage(userModel.image),
//                     ),
//                     SizedBox(
//                       width: 15.0,
//                     ),
//                     Text(userModel.name),
//                   ],
//                 ),
//               ),
//               body: ConditionalBuilder(
//                 condition: SocialLayoutCubit.get(context).messages.length >= 0,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (context,index)
//                           {
//                             var message = SocialLayoutCubit.get(context).messages[index];
//                             if(SocialLayoutCubit.get(context).userModel.uId == message.senderId)
//                               return buildMyMessage(message);
//                             return buildMessage(message);
//                           },
//                           separatorBuilder: (context,index) => SizedBox(height: 15.0),
//                           itemCount: SocialLayoutCubit.get(context).messages.length,
//                         ),
//                       ),
//                       Container(
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         decoration: BoxDecoration(
//                           border:
//                               Border.all(color: Colors.grey[300], width: 1.0),
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.only(
//                                     start: 5.0),
//                                 child: TextFormField(
//                                   controller: messageController,
//                                   decoration: InputDecoration(
//                                     hintText: 'type your message here ...',
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Colors.grey[300], width: 1.0),
//                                 color: Colors.blue[200],
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   if(messageController.text!=''){
//                                     SocialLayoutCubit.get(context).sendMessage(
//                                       receiverId: userModel.uId,
//                                       dateTime: DateTime.now().toString(),
//                                       text: messageController.text,
//                                     );
//                                     }
//                                     messageController.text='';
//                                 },
//                                 child: Icon(
//                                   IconBroken.Send,
//                                   size: 20.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 fallback: (context) =>
//                     Center(child: CircularProgressIndicator()),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget buildMessage(MessageModel model) => Align(
//         alignment: AlignmentDirectional.centerStart,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadiusDirectional.only(
//               bottomEnd: Radius.circular(10.0),
//               topEnd: Radius.circular(10.0),
//               topStart: Radius.circular(10.0),
//             ),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: 5.0,
//             horizontal: 10.0,
//           ),
//           child: Text(model.text),
//         ),
//       );

//   Widget buildMyMessage(MessageModel model) => Align(
//         alignment: AlignmentDirectional.centerEnd,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.blue.withOpacity(.2),
//             borderRadius: BorderRadiusDirectional.only(
//               bottomStart: Radius.circular(10.0),
//               topEnd: Radius.circular(10.0),
//               topStart: Radius.circular(10.0),
//             ),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: 5.0,
//             horizontal: 10.0,
//           ),
//           child: Text(model.text),
//         ),
//       );
// }