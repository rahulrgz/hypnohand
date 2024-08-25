import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hypnohand/feature/single_course/repository/singleCourse_repository.dart';

// final userProvier = StateProvider<UserModel?>((ref) => null);

final singleCourseControllerProvider = StateProvider(
        (ref) => SingleCourseController(
        singleCourseRepository: ref.watch(SingleCourseRepositoryProvider), ref: ref,
        ),
);

class SingleCourseController {
  final SingleCourseRepository _singleCourseRepository;
  final Ref _ref;

  SingleCourseController({required SingleCourseRepository singleCourseRepository, required Ref ref})
      : _singleCourseRepository = singleCourseRepository,
        _ref = ref;

  // onPaymentSuccess({required String price,required double discount,required String courseName,required String subName,required Map<dynamic,dynamic>response,required WidgetRef ref}){
  //   _singleCourseRepository.onPaymentSuccess(price: price, discount: discount, courseName: courseName, subName: subName, response: response);
  // }

}