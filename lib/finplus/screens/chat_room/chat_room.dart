import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/smart_refresh/custom_smart_refresh.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chat_room_controller.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return GetBuilder<ChatRoomController>(
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Obx(
            () => c.isShowSearch.value
                ? TextFormField(
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm',
                    ),
                    onFieldSubmitted: c.onSubmitSearch,
                  )
                : const Text(
                    'Nhóm chat',
                  ),
          ),
          actions: [
            IconButton(
              onPressed: c.onIconSearchPress,
              icon: Obx(
                () => SvgPicture.asset(
                  c.isShowSearch.value
                      ? SvgIcon.close_icon
                      : SvgIcon.search_icon,
                  color: theme.background,
                ),
              ),
            ),
            IconButton(
              onPressed: c.createChatRoomHandler,
              color: theme.background,
              icon: SvgPicture.asset(
                SvgIcon.add_icon,
                color: theme.background,
              ),
            ),
          ],
        ),
        body: Obx(
          () => c.searchRooms.isEmpty
              ? SizedBox(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          SvgIcon.no_data_icon,
                        ),
                        Spaces.box10,
                        const Text(
                          'Không có nhóm chat nào',
                        ),
                      ],
                    ),
                  ),
                )
              : CustomSmartRefresher(
                  controller: c.refreshController,
                  onRefresh: c.reload,
                  child: ListView.builder(
                    itemCount: c.searchRooms.length,
                    itemBuilder: (_, i) {
                      final item = c.searchRooms[i];
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: Spaces.a10,
                          child: Row(
                            children: [
                              const Avatar(
                                value: '',
                                size: 50,
                              ),
                              Spaces.boxW10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextDefine.P1_M,
                                          ),
                                        ),
                                        Spaces.boxW10,
                                        _buildTimeMessage(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            item.lastMsgTime,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spaces.boxH5,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Tin nhắn cuối cùng',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (item.msgCount != 0)
                                          Container(
                                            padding: Spaces.a4,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Colors.redAccent,
                                              shape: BoxShape.circle,
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                '${item.msgCount > 5 ? '5+' : item.msgCount}',
                                                style: TextDefine.P4_R.copyWith(
                                                  color: theme.background,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTimeMessage(DateTime time) {
    return Builder(
      builder: (context) {
        final colorTime = context.t.textDisable;
        if (DateTime.now().difference(time).inDays > 0)
          return Text(
            DateFormat('dd/MM/yyyy').format(time),
            style: TextDefine.P2_R.copyWith(
              color: colorTime,
            ),
          );
        return Text(
          DateFormat('HH:mm').format(time),
          style: TextDefine.P2_R.copyWith(
            color: colorTime,
          ),
        );
      },
    );
  }
}
