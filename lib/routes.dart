import 'package:matches/screens/capo_azz/capo_azz.dart';
import 'package:matches/screens/capo_euro/capo_euro.dart';
import 'package:matches/screens/gironi/girone_info.dart';
import 'package:matches/screens/gironi/gironi.dart';
import 'package:matches/screens/goal_veloce/goal_veloce.dart';
import 'package:matches/screens/login/login.dart';
import 'package:matches/screens/matches/match_info.dart';
import 'package:matches/screens/matches/matches.dart';
import 'package:matches/screens/matches_fin/match_fin_info.dart';
import 'package:matches/screens/matches_fin/matches_fin.dart';
import 'package:matches/screens/points_list/points_list.dart';
import 'package:matches/screens/signup/signup.dart';
import 'package:matches/screens/team_rivelaz/team_rivelaz.dart';
import 'package:matches/screens/teams/team_info.dart';
import 'package:matches/screens/teams/teams_list.dart';

var routes = {
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignupPage(),
  //***
  '/matches': (context) => const MatchesPage(),
  '/match_info': (context) => const MatchInfoPage(),
  //***
  '/matches_fin': (context) => const MatchesFinPage(),
  '/match_fin_info': (context) => const MatchFinInfoPage(),
  //***
  '/teams_list': (context) => const TeamsListPage(),
  '/team_info': (context) => const TeamInfoPage(),
  //***
  '/gironi': (context) => const GironiPage(),
  '/girone_info': (context) => const GironeInfoPage(),
  //***
  '/goal_veloce': (context) => const GoalVelocePage(),
  //***
  '/team_rivelaz': (context) => const TeamRivelazPage(),
  //***
  '/capo_euro': (context) => const CapoEuroPage(),
  //***
  '/capo_azz': (context) => const CapoAzzPage(),
  //***
  '/points_list': (context) => const PointsListPage()
};
