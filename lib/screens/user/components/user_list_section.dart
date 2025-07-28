import 'package:admin/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/user.dart';
import 'add_user_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';


class UserListSection extends StatelessWidget {
  const UserListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tất cả tài khoản",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Tài khoản"),
                    ),
                    DataColumn(
                      label: Text("Mật khẩu"),
                    ),
                    DataColumn(
                      label: Text("Ngày tạo"),
                    ),
                    DataColumn(
                      label: Text("Chỉnh sửa"),
                    ),
                    DataColumn(
                      label: Text("Xoá"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.Users.length,
                    (index) => userDataRow(
                      dataProvider.Users[index],
                      index + 1,
                      edit: () {
                        showAddUserForm(context, dataProvider.Users[index]);
                      },
                      delete: () {
                        //TODO: should complete call deleteUser
                        context.userProvider.deleteUser(dataProvider.Users[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow userDataRow(User UserInfo, int index, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(UserInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(UserInfo.password ?? '')),
      DataCell(Text(UserInfo.createdAt ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
