// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news/constant/api.dart';
// import 'package:news/model/latest_news_model.dart';
// import 'latest_news_event.dart';
// import 'latest_news_state.dart';
// import 'package:http/http.dart' as http;

// class LatestNewsBloc extends Bloc<LatestNewsEvent, LatestNewsState> {
//   LatestNewsBloc() : super(LatestNewsInitial()) {
//     on<FetchLatestNews>(_onFetchLatestNews);
//   }

//   Future<void> _onFetchLatestNews(
//       FetchLatestNews event, Emitter<LatestNewsState> emit) async {
//     emit(LatestNewsLoading());

//     try {
//       final response = await http.get(Uri.parse(Api.baseUrl));

//       if (response.statusCode == 200) {
//         final parsedJson = json.decode(response.body);

//         if (parsedJson is Map<String, dynamic> &&
//             parsedJson['status'] == 'success') {
//           if (parsedJson['results'] is List) {
//             final LatestNews data = latestNewsFromJson(response.body);
//             print(response.body);
//             print(response.statusCode);
//             emit(LatestNewsLoaded(data));
//           } else {
//             emit(const LatestNewsError('Expected a list of results.'));
//           }
//         } else {
//           emit(const LatestNewsError('Unexpected response format.'));
//         }
//       } else {
//         emit(LatestNewsError('Failed to load news: ${response.reasonPhrase}'));
//       }
//     } catch (e) {
//       emit(LatestNewsError('An error occurred: $e'));
//     }
//   }
// }
