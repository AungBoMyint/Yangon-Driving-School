import 'package:get/get.dart';
import 'package:hammies_user/screen/admin/car_licence_price/bin/clp_binding.dart';
import 'package:hammies_user/screen/admin/car_licence_price/view/clp_view.dart';
import 'package:hammies_user/screen/admin/driving_licence_price/bin/dlp_binding.dart';
import 'package:hammies_user/screen/admin/driving_licence_price/view/dlp_management.dart';
import 'package:hammies_user/screen/admin/guideline_category/bin/gc_binding.dart';
import 'package:hammies_user/screen/admin/guideline_category/view/gc_view.dart';
import 'package:hammies_user/screen/admin/guideline_item/bin/gci_binding.dart';
import 'package:hammies_user/screen/admin/guideline_item/view/gci_view.dart';
import 'package:hammies_user/screen/admin/question_form/bin/question_form_binding.dart';
import 'package:hammies_user/screen/admin/question_form/view/question_form_view.dart';
import 'package:hammies_user/screen/admin/sub_question_management/bin/sub_question_management_binding.dart';
import 'package:hammies_user/screen/admin/sub_question_management/view/sub_question_management_view.dart';
import 'package:hammies_user/screen/course_form/bin/course_form_binding.dart';
import 'package:hammies_user/screen/course_form/view/course_form.dart';
import 'package:hammies_user/screen/login_screen.dart';
import 'package:hammies_user/screen/question5/bin/q_binding.dart';
import 'package:hammies_user/screen/reward_product_see_all.dart';
import 'package:hammies_user/screen/service_form/bin/service_form_binding.dart';
import 'package:hammies_user/screen/service_form/view/service_form_view.dart';
import 'package:hammies_user/screen/question5/view/tab_bar.dart';
import 'package:hammies_user/screen/user_history/bin/user_history_binding.dart';
import 'package:hammies_user/screen/user_history/view/user_history_view.dart';

import '../controller/home_controller.dart';
import '../intro_screen.dart';
import '../screen/admin/course_price/bin/course_price_binding.dart';
import '../screen/admin/course_price/view/course_price.dart';
import '../screen/admin/enrollment/bin/enrollment_binding.dart';
import '../screen/admin/enrollment/view/enrollment_data.dart';
import '../screen/car_licence_form/bin/car_licence_binding.dart';
import '../screen/car_licence_form/view/car_licence_view.dart';
import '../screen/check_out_screen.dart';
import '../screen/detail_screen.dart';
import '../screen/guideline/bin/guideline_binding.dart';
import '../screen/guideline/view/guideline_view.dart';
import '../screen/guideline_detail.dart/bin/guideline_detail_binding.dart';
import '../screen/guideline_detail.dart/view/guideline_detail_view.dart';
import '../screen/home_screen.dart';
import '../screen/purchase_screen.dart';
import '../screen/search_screen.dart';
import '../screen/user_profile_screen.dart';

const String introScreen = '/intro-screen';
const String homeScreen = '/home';
const String checkOutScreen = '/checkout';
const String detailScreen = '/detail';
const String uploadItemScreen = '/uploadItemScreen';
const String mangeItemScreen = '/manage-item';
const String purchaseScreen = '/purchase-screen';
const String blueToothScreen = '/bluetooth-screen';
const String searchScreen = '/searchScreen';
const String userProfileUrl = "/user_profile";
const String rewardProducts = "/reward_products";
const String loginScreen = "/login_screen";
const String courseFormScreen = "/course_form_screen";
const String serviceFormScreen = "/service_form_screen";
const String carLicenceFormScreen = "/car_licence_form_screen";
const String questionFormScreen = "/question_form_screen";
const String subQuestionManagementScreen = "/sub_question_management_screen";
const String questionTabScreen = "/question_tab_screen";
const String coursePriceScreen = "/course_price_screen";
const String enrollmentScreen = "/enrollment_screen";
const String carLicenceManagementScreen = "/car_licence_screen";
const String drivingLicenceManagementScreen = "/driving_licence_screen";
const String guideLineManagementScreen = "/guide_line_management_screen";
const String guideLineItemManagementScreen = "/guide_line_item_management_screen";
const String guideLineScreen = "/guide_line_screen";
const String guideLineDetailScreen = "/guide_line_detail_screen";
const String userHistoryScreen = "/user_history_screen";

HomeController controller = Get.find();
String redirectRoute() {
  if (controller.currentUser.value == null) {
    return loginScreen;
  } else {
    return homeScreen;
  }
}

List<GetPage> routes = [
  GetPage(
    name: introScreen,
    page: () => OnBoardingPage(),
  ),
  GetPage(
    name: homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: checkOutScreen,
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: detailScreen,
    page: () => DetailScreen(),
  ),
  GetPage(
    name: rewardProducts,
    page: () => RewardProductSeeAll(),
  ),
  GetPage(
    name: loginScreen,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: courseFormScreen,
    page: () => CourseForm(),
    binding: CourseFormBinding(),
  ),
   GetPage(
     name: serviceFormScreen,
     page: () => ServiceForm(),
     binding: ServiceFormBinding(),
   ),
   GetPage(
     name: carLicenceFormScreen,
     page: () => CarLicenceForm(),
     binding: CarLicenseService(),
   ),
   GetPage(
     name: questionFormScreen,
     page: () => QuestionFormView(),
     binding: QuestionFormBinding(),
   ),
   GetPage(
     name: subQuestionManagementScreen,
     page: () => SubQuestionManagementView(),
     binding: SubQuestionManagementBinding(),
   ),
   GetPage(
     name: questionTabScreen,
     page: () => QuestionTab(),
     binding: QuestionTabBinding(),
   ),
   GetPage(
     name: coursePriceScreen,
     page: () => CoursePriceView(),
     binding: CoursePriceBinding(),
   ),
   GetPage(
     name: enrollmentScreen,
     page: () => EnrollmentDataView(),
     binding: EnrollmentBinding(),
   ),
   GetPage(
     name: drivingLicenceManagementScreen,
     page: () => DLPriceManagement(),
     binding: DLPBinding(),
   ),
   GetPage(
     name: carLicenceManagementScreen,
     page: () => CLPManagement(),
     binding: CLPBinding(),
   ),
   GetPage(
     name: guideLineManagementScreen,
     page: () => GCView(),
     binding: GCBinding(),
   ),
   GetPage(
     name: guideLineItemManagementScreen,
     page: () => GCIView(),
     binding: GCIBinding(),
   ),
   GetPage(
     name: guideLineScreen,
     page: () => GuideLineView(),
     binding: GuideLineBinding(),
   ),
   GetPage(
     name: guideLineDetailScreen,
     page: () => GuideLineDetailView(),
     binding: GuideLineDetailBinding(),
   ),
   GetPage(
     name: userHistoryScreen,
     page: () => UserHistoryView(),
     binding: UserHistoryBinding(),
   ),
  // GetPage(
  //   name: uploadItemScreen,
  //   page: () => UploadItem(),
  //   binding: UploadBinding(),
  // ),
  // GetPage(
  //   name: mangeItemScreen,
  //   page: () => ManageItem(),
  //   binding: ManageBinding(),
  // ),
  GetPage(
    name: purchaseScreen,
    page: () => PurchaseScreen(),
  ),
  // GetPage(
  //   name: blueToothScreen,
  //   page: () => BlueToothPrintScreen(),
  // ),
  GetPage(
    name: searchScreen,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: userProfileUrl,
    page: () => UserProfileScreen(),
  ),
];
