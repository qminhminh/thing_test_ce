import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thingsboard_app/constants/assets_path.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/modules/dashboard/dashboard.dart'
    as dashboardUi;
import 'package:thingsboard_app/modules/dashboard/dashboards_grid.dart';
import 'package:thingsboard_app/modules/tenant/tenants_widget.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class HomePage extends TbContextWidget {
  HomePage(TbContext tbContext) : super(tbContext);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends TbContextState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var homeDashboard = tbContext.homeDashboard;
    var dashboardState = homeDashboard != null;
    return Scaffold(
      appBar: TbAppBar(
        tbContext,
        elevation: dashboardState ? 0 : 8,
        title: Center(
            child: Container(
                height: 24,
                child: SvgPicture.asset(ThingsboardImage.thingsBoardWithTitle,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn),
                    semanticsLabel: 'ThingsBoard Logo'))),
        actions: [
          if (tbClient.isSystemAdmin())
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                navigateTo('/tenants?search=true');
              },
            )
        ],
      ),
      body: Builder(builder: (context) {
        if (dashboardState) {
          return _buildHomeDashboardWithRetry(context, homeDashboard);
        } else {
          return _buildDefaultHome(context);
        }
      }),
    );
  }

  Widget _buildDashboardHome(
      BuildContext context, HomeDashboardInfo dashboard) {
    return HomeDashboard(tbContext, dashboard);
  }

  Widget _buildDefaultHome(BuildContext context) {
    if (tbClient.isSystemAdmin()) {
      return _buildSysAdminHome(context);
    } else {
      return DashboardsGridWidget(tbContext);
    }
  }

  Widget _buildHomeDashboardWithRetry(BuildContext context, HomeDashboardInfo? dashboard) {
    if (dashboard != null) {
      return _buildDashboardHome(context, dashboard);
    } else {
      return _buildHomeDashboardError(context);
    }
  }

  Widget _buildHomeDashboardError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Không thể tải dashboard',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Vui lòng kiểm tra kết nối mạng và thử lại',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              await tbContext.retryLoadHomeDashboard();
              setState(() {}); // Rebuild to show dashboard if loaded
            },
            icon: Icon(Icons.refresh),
            label: Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildSysAdminHome(BuildContext context) {
    return TenantsWidget(tbContext);
  }
}

class HomeDashboard extends TbContextWidget {
  final HomeDashboardInfo dashboard;

  HomeDashboard(TbContext tbContext, this.dashboard) : super(tbContext);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends TbContextState<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return dashboardUi.Dashboard(tbContext, home: true,
        controllerCallback: (controller) {
      controller.openDashboard(widget.dashboard.dashboardId!.id!,
          hideToolbar: widget.dashboard.hideDashboardToolbar);
    });
  }
}
