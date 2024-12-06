import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feauters/weather/presentation/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.addListener(() => EasyDebounce.debounce(
          'debouncer',
          Duration(milliseconds: 500),
          () => _updateWeather(city: _textEditingController.text),
        ));

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          /// SEARCH INPUT
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            height: 54.0,
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: 'Search'),
            ),
          ),

          /// BODY
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              if (state is WeatherLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is WeatherLoadedState) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// CITY NAME
                      Text(
                        state.response.location.name,
                        style: TextStyle(fontSize: 24.0),
                      ),

                      /// TEMPERATURE
                      Text(
                        '${state.response.current.temp_c.toString()} C°',
                        style: TextStyle(fontSize: 44.0),
                      ),
                    ]);
              }

              if (state is WeatherFailureState) {
                return Center(child: Text(state.message));
              }

              return Container();
            }),
          ),
        ]),
      ),
    );
  }

  // MARK: FUNCTION'S

  void _updateWeather({required String city}) =>
      BlocProvider.of<WeatherBloc>(context)
          .add(WeatherFetchEvent(city: city.isEmpty ? 'Omsk' : city));
}
