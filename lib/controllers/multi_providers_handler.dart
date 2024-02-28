import 'package:matches/state_management/capo_azz_provider/capo_azz_provider.dart';
import 'package:matches/state_management/capo_euro_provider/capo_euro_provider.dart';
import 'package:matches/state_management/fasi_provider/fasi_provider.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/state_management/goal_veloce_provider/goal_veloce_provider.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/login_provider/login_provider.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:matches/state_management/setup_provider/setup_provider.dart';
import 'package:matches/state_management/team_rivelaz_provider/team_rivelaz_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/state_management/test_provider/test_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProvidersHandler {
  List<SingleChildWidget> getProvidersList() {
    return [
      ChangeNotifierProvider(
        create: (_) => TestProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SetupProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HttpProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MatchesProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MatchesFinProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TeamsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FasiProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GironiProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PointsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => GoalVeloceProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TeamRivelazProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CapoAzzProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CapoEuroProvider(),
      ),
    ];
  }
}
