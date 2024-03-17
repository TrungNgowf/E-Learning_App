import 'package:e_learning_app/views/log_in/bloc/log_in_bloc.dart';
import 'package:e_learning_app/views/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static get allBlocProviders => [
        BlocProvider<LogInBloc>(
          create: (context) => LogInBloc(),
        ),
        BlocProvider(create: (context) => SignUpBloc()),
      ];
}
