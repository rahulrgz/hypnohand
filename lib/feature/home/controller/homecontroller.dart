import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:hypnohand/feature/home/repository/homerepository.dart';
import 'package:hypnohand/model/settingmodel.dart';

import '../../../model/announcementmodel.dart';
import '../../../model/courseModel.dart';
import '../../../model/performanceModel.dart';
import '../../../model/reviewmodel.dart';

final homeControllerProvider=Provider((ref) => HomeController(homeRepository: ref.watch(homeRepositoryProvider), ref: ref));
final getBannerFuture=StreamProvider.autoDispose((ref) => ref.watch(homeControllerProvider).getBannnerss());
final getPerformance=FutureProvider((ref) => ref.watch(homeControllerProvider).getPerformance());
final  getReview=FutureProvider((ref) => ref.watch(homeControllerProvider).getReview());

///chabnge
final getPerformQuery=FutureProvider((ref) => ref.watch(homeControllerProvider).getPerforms());
final getCourseList=StreamProvider((ref) => ref.watch(homeControllerProvider).getCourseList());
final getCoursebysearch=StreamProvider.family((ref,String name) => ref.watch(homeControllerProvider).getCoursebySearch(name));
final getannounce=FutureProvider((ref) => ref.watch(homeControllerProvider).getannounce());
class HomeController{
  final HomeRepository _homeRepository;
  final Ref _ref;
  HomeController({required HomeRepository homeRepository,required Ref ref}):_homeRepository=homeRepository,_ref=ref;

  Future<List<String>> getBanners(){
    return _homeRepository.getBanner();

  }
  Future<List<ReviewModel>> getReview(){
    return _homeRepository.getReview();
  }
  Stream<SliderSetting> getBannnerss(){
    return _homeRepository.getbanners();
  }
  Future<List<PerformanceModel>> getPerformance(){
    return _homeRepository.getPerformance();
  }
  Future<QuerySnapshot> getPerforms(){
    return _homeRepository.getPerfromQuery();
  }
  Stream<List<CourseModel>>getCourseList(){
    return _homeRepository.getcoursesbystream();
  }
  Stream<List<CourseModel>>getCoursebySearch(String name){
    return _homeRepository.getcoursebysearch(name);
  }
  Future<List<AnnouncementModel>> getannounce(){
    return _homeRepository.getAnnounce();
  }



}