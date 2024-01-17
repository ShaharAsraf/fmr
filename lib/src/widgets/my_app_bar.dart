import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmr/src/blocs/ui/ui_bloc_provider.dart';
import 'package:fmr/src/style/colors.dart';
import 'package:fmr/src/utils/consts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _renderAppBarContent(context),
    );
  }

  Widget _renderAppBarContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _renderThemeButton(context),
        ],
      ),
    );
  }

  Widget _renderThemeButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: UIBlocProvider.of(context).isDarkMode,
        builder: (context, isDark, child) {
          return Row(
            children: [
              const Icon(CupertinoIcons.sun_max, color: dayColor),
              Switch(
                value: isDark,
                onChanged: (value) {
                  UIBlocProvider.of(context).onModeChange(value);
                },
                activeTrackColor: scaffoldBackground,
                activeColor: primaryColor,
                inactiveTrackColor: Colors.white,
              ),
              Icon(CupertinoIcons.moon_fill, color: isDark ? darkNightColor : lightNightColor),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
