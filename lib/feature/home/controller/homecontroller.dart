import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hypnohand/core/model/performanceModel.dart';
import 'package:hypnohand/feature/home/repository/homerepository.dart';
final homeControllerProvider=Provider((ref) => HomeController(homeRepository: ref.watch(homeRepositoryProvider), ref: ref));
final getBannerFuture=FutureProvider((ref) => ref.watch(homeControllerProvider).getBanners());
final getPerformance=FutureProvider((ref) => ref.watch(homeControllerProvider).getPerformance());
final getPerformQuery=FutureProvider((ref) => ref.watch(homeControllerProvider).getPerforms());
class HomeController{
  final HomeRepository _homeRepository;
  final Ref _ref;
  HomeController({required HomeRepository homeRepository,required Ref ref}):_homeRepository=homeRepository,_ref=ref;

  Future<List<String>> getBanners(){
    return _homeRepository.getBanner();

  }
  Future<List<PerformanceModel>> getPerformance(){
    return _homeRepository.getPerformance();
  }
  Future<QuerySnapshot> getPerforms(){
    return _homeRepository.getPerfromQuery();
  }


}