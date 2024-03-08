import 'dart:convert';

import 'package:pugau/Data/Api/API_URLs.dart';
import 'package:http/http.dart' as http;
import 'package:pugau/Data/Model/add_to_card_customization_product_model.dart';
import 'package:pugau/Data/Model/addtocart_product_model.dart';
import 'package:pugau/Data/Model/apply_coupon_model.dart';
import 'package:pugau/Data/Model/cash_on_delivery_model.dart';
import 'package:pugau/Data/Model/customization_model.dart';
import 'package:pugau/Data/Model/delivery_charge_model.dart';
import 'package:pugau/Data/Model/get_cart_proodeuct_model.dart';
import 'package:pugau/Data/Model/get_oder_model.dart';
import 'package:pugau/Data/Model/restaurant_coupon_model.dart';
import 'package:pugau/Data/Model/restaurent_review_model.dart';
import 'package:pugau/Data/Model/restaurent_reviewadd_model.dart';
import 'package:pugau/Data/Model/restorance_details_model.dart';
import 'package:pugau/Data/Model/status_order_model.dart';
import 'package:pugau/widget/customSnakebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRestaurentOrder {
  AddToCartProductModelClass? addToCartProductModelClass;
  AddToCartCustomizationModelClass? addToCartCustomizationModelClass;
  CustomizationModel? customizationModel;
  GetCartProductModel? getCartProductModel;
  RestaurentReviewModel? restaurentReviewModel;
  RestaurentReviewAddModel? restaurentReviewAddModel;
  bool isrestaurantReviewGet = false;
  RestaurantCouponModel? restaurantCouponModel;
  List<CouponDetails>? coupon = [];
  ApplyCouponModel? applyCouponModel;
  String? useridpass;
  RestoranceDeatilsModel? restoranceDeatilsModel;
  DeliveryChargeModel? deliveryChargeModel;
  CashOnDeliveryModel? cashOnDeliveryModel;
  StatusOrderModel? statusOrderModel;
  GetOrderModel? getOrderModel;

  Future<GetOrderModel?>getOrderView(String orderId) async {

     Map orderView = {
      'order_id': orderId,

    };


    print("getOrderView====${orderView}");
     var headers = {
       'Accept': 'application/json',
       'Content-Type': 'application/json'
     };
     var request = http.Request('GET', Uri.parse(AppContent.BASE_URL + AppContent.getOrder));
     request.body = json.encode(orderView);
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       String responseBody = await response.stream.bytesToString();
       Map<String, dynamic> jsonResponse = json.decode(responseBody);

print("getOrderRestorant=======${jsonResponse}");
       getOrderModel = GetOrderModel.fromJson(jsonResponse);

       return getOrderModel;
     }
     else {

     return null;

     }

  }

  Future<StatusOrderModel?>statusOrder(String orderId,String userId) async {

    Map statusOrderView = {

      'user_id':userId,
      'order_id':orderId,

    };

    print("statusOrderView====${statusOrderView}");

    final response = await http.post(Uri.parse(AppContent.BASE_URL + AppContent.statusOrder), body: statusOrderView);
    var res = jsonDecode(response.body);
    print("statusOrder======${res}");
    if(response.statusCode==200){
      statusOrderModel= StatusOrderModel.fromJson(res);


      print("orderid=====${statusOrderModel!.data!.id}");

      return statusOrderModel;
    }
    else
    {
      return null;
    }
  }




  Future<bool>cancelOrder(String orderId,String userId) async {

    Map cancelOrderView = {
      'order_id':orderId,
      'user_id':userId,


    };

    print("cancelOrderView====${cancelOrderView}");

    final response = await http.post(Uri.parse(AppContent.BASE_URL + AppContent.orderCancel), body: cancelOrderView);
    var res = jsonDecode(response.body);
print("res=====${res}");
    if(response.statusCode==200)
    {

      if(res['success']==true){
        return true;
      }
      else
      {
        return false;
      }

    }else{
      print("get20");
      return false;
    }
  }









  Future<bool>getCashOnDelivery(String orderId,String paymentStatus,String paymentDetail) async {

    Map cashOnDeliveryOrder = {
      'order_id':orderId,
      'payment_status':paymentStatus,
      'payment_detail':paymentDetail,

    };

    final response = await http.post(Uri.parse(AppContent.BASE_URL + AppContent.paymentUpdate), body: cashOnDeliveryOrder);
    var res = jsonDecode(response.body);

    if(response.statusCode==200)
    {

      if(res['success']==true){
        return true;
      }
      else
      {
        return false;
      }

    }else{
      print("get20");
      return false;
    }
  }



  Future<CashOnDeliveryModel?> getCashOnDeliveryOrder(
      String userId,
      String total,
      String phone,
      String addressId,
      String userDetailId,
      String paymentMode,
      String deliveryCharge,
      String orderType,
      String timeSchedule,
      String orderDesc,
      String weatherCharge,
      String userDistance,
      String userName,
      String userPhone,
      String call,
      String packingCharge,
    String serviceCharge,
    String governmentTax,
      String nightCharge,
      String smallOrderCharge,
      String festivalCharge,
      String coupanDiscount,
      String extraOrderCharge,


      ) async {
    Map cashOnDeliveryView = {
      'user_id': userId,
      'total': total,
      'phone': phone,
      'address_id': addressId,
      'user_detail_id': userDetailId,
      'payment_mode': paymentMode,
      'delivery_charge': deliveryCharge,
      'order_type': orderType,
      'time_schedule': timeSchedule,
      'order_desc': orderDesc,
      'weather_charge': weatherCharge,
      'km': userDistance,
      'user_name': userName,
      'user_phone': userPhone,
      'call': call,
      'packing_charge':packingCharge,
      'service_charge':serviceCharge,
      'government_tax':governmentTax,
      'night_charge':nightCharge,
      'small_order_charge':smallOrderCharge,
      'festival_charge':festivalCharge,
      'coupan_discount':coupanDiscount,
      'extra_order_charge':extraOrderCharge,




    };
print("cashOnDeliveryView===${cashOnDeliveryView}");
    final response = await http.post(Uri.parse(AppContent.BASE_URL + AppContent.order), body: cashOnDeliveryView);


    var res = jsonDecode(response.body);
    print("res======${res}");
    if(response.statusCode==200){
      cashOnDeliveryModel=CashOnDeliveryModel.fromJson(res);


      print("orderid=====${cashOnDeliveryModel!.data!.id}");

      return cashOnDeliveryModel;
    }
    else
      {
        return null;
      }


  }

  Future<DeliveryChargeModel?> getDeliveryCharge(
      String userLatitude,
      String userLongitude,
      String restaurantLatitude,
      String restaurantLongitude,
      String cityId,
      String orderAmount) async {
    print("deliveryCharge 1");
    Map deliveryChargeView = {
      'user_lati': userLatitude,
      'user_long': userLongitude,
      'restro_lati': restaurantLatitude,
      'restro_long': restaurantLongitude,
      'city_id': cityId,
      'order_amount': orderAmount,
    };
    print("deliveryCharge 10===${deliveryChargeView}");
    final response = await http.post(
        Uri.parse(AppContent.BASE_URL + AppContent.calculateDeliveryCharge),
        body: deliveryChargeView);
    print("deliveryCharge 100");
    var res = jsonDecode(response.body);
    print("rescharge====${res}");
    if (response.statusCode == 200) {
      print("deliveryCharge 1000");
      deliveryChargeModel = DeliveryChargeModel.fromJson(res);

      // deliveryDistance=deliveryChargeModel!.data!.km.toString();
      // deliveryCharge=deliveryChargeModel!.data!.deliveryCharge.toString();
      // print("deliveryCharge===${deliveryCharge}");
      return deliveryChargeModel;
    } else {
      return null;
    }
  }

  Future<RestoranceDeatilsModel?> getRestaurantDetail(
      String restaurantId) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.get_restaurant_detail);
    var response = await http.post(url, body: {'restaurant_id': restaurantId});
    print('Response  status: ${response.statusCode}');
    print('Response restorance body: ${response.body}');
    if (response.statusCode == 200) {
      var restorancedetailedata = jsonDecode(response.body);
      restoranceDeatilsModel =
          RestoranceDeatilsModel.fromJson(restorancedetailedata);
      if (restoranceDeatilsModel != null) {
        return restoranceDeatilsModel;
      }
    } else {
      print("Check and try againe restorancedetaile");
      return null;
    }
  }

  getPreferences() async {
    final pref = await SharedPreferences.getInstance();

    useridpass = pref.getString('user_id');

    return useridpass;
  }

  Future<GetCartProductModel?> getCartProduct(String? userid) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.getCart);
    print("topasss");
    Map getCartMap = {'user_id': userid};
    print("getCartMap===${getCartMap}");

    print("topasss2");
    var response = await http.post(url, body: getCartMap);
    print("topasss3");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var getProductData = jsonDecode(response.body);

      if (getProductData['status'] == true) {
        print("stusok");
        getCartProductModel = GetCartProductModel.fromJson(getProductData);

        return getCartProductModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> customisationProduct(
      String menuId, String subMenuId) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.customisation);
    Map customisation = {'menu_id': menuId, 'submenu_id': subMenuId};
    print("customisation=====${customisation}");

    var response = await http.post(url, body: customisation);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var customizationData = jsonDecode(response.body);
      if (customizationData['success'] == true) {
        print("customizationModelview3");
        customizationModel = CustomizationModel.fromJson(customizationData);
        var customizationDetailView = customizationData['data'];
        var customizationGroupedAttributes =
            customizationData['data']['grouped_attributes'];
        var customizationKeysName =
            customizationGroupedAttributes.keys.toList();

        customizationGroupedAttributes.keys.toList();

        print("keys_name=====${customizationKeysName}");
        print(
            "keys_name=====${customizationGroupedAttributes[customizationKeysName[0]].length}");
        //  print("customizationModelview get======${customizationModel!.data!.attributes![0].pivot!.qty}");
        //showCustomSnackBar("${customizationModel!.message}");
        return {
          'keys_name': customizationKeysName,
          'customizationModel': customizationDetailView,
          'customizationGroupedAttributes': customizationGroupedAttributes
        };
      } else {
        //showCustomSnackBar("${customizationModel!.message}");
      }
    } else {
      // showCustomSnackBar("${customizationModel!.message}");
    }
    return null;
  }

  Future<AddToCartProductModelClass?> restaurentAddQuantity(String? userid,
      String? submenuId, String? price, String qty, String? size) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.addToCart);

    Map addToCartProduct = {
      'user_id': userid,
      'submenu_id': submenuId,
      'price': price,
      'qty': qty,
      'customAttrName[]': size,
    };

    print("addToCartProduct======${addToCartProduct}");
    var response = await http.post(url, body: addToCartProduct);
    print("responseAddtocart=====${response.body}");

    print("responece========${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      // List<dynamic> responseData = jsonDecode(response.body);

      //   Map responseData = jsonDecode(response.body);
      print("responseData====${responseData}");

      if (responseData[0] != null) {
        print("1");
        print("IN");
        print("responseDataget=====${jsonDecode(response.body)}");

        Map<String, dynamic> productData = responseData[0];
        print("productData======${productData}");
        addToCartProductModelClass =
            AddToCartProductModelClass.fromJson(productData);
        print(
            "addToCartProductModelClass====${addToCartProductModelClass!.qty}");
        return addToCartProductModelClass;
      } else {
        print("10");
        return null;

        print("out");
      }
    } else {
      print("error api data not get");
      return null;
    }
  }

  restaurentCartItemDelete() {}

  Future<AddToCartCustomizationModelClass?> restaurentCustomizationAddQuantity(
      String? userid,
      String? submenuId,
      String? price,
      String qty,
      String? size,
      String getListoneTitle,
      String getListtwoTitle) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.addToCart);
    print("size========${size}");
    print("size========${getListoneTitle}");
    print("size========${getListtwoTitle}");
    Map addToCartProduct = {
      'user_id': userid,
      'submenu_id': submenuId,
      'price': price,
      'qty': qty,
      'customAttrName[0]': size,
    };
    Map addToCartProductOne = {
      'user_id': userid,
      'submenu_id': submenuId,
      'price': price,
      'qty': qty,
      'customAttrName[0]': size,
      'customAttrName[1]': getListoneTitle,
    };
    Map addToCartProductTwo = {
      'user_id': userid,
      'submenu_id': submenuId,
      'price': price,
      'qty': qty,
      'customAttrName[0]': size,
      'customAttrName[1]': getListoneTitle,
      'customAttrName[2]': getListtwoTitle,
    };
    Map addToCartProductThree = {
      'user_id': userid,
      'submenu_id': submenuId,
      'price': price,
      'qty': qty,
      'customAttrName[0]': size,
      'customAttrName[1]': getListtwoTitle,
    };

    print(
        "addToCartCustomizationProduct======${getListoneTitle != "" && getListtwoTitle != "" ? addToCartProductTwo : getListoneTitle != "" ? addToCartProductOne : getListtwoTitle != "" ? addToCartProductThree : addToCartProduct}");
    var response = await http.post(url,
        body: getListoneTitle != "" && getListtwoTitle != ""
            ? addToCartProductTwo
            : getListoneTitle != ""
                ? addToCartProductOne
                : getListtwoTitle != ""
                    ? addToCartProductThree
                    : addToCartProduct);

    print("responseAddtocart=====${response.body}");

    print("responece========${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      // List<dynamic> responseData = jsonDecode(response.body);

      //   Map responseData = jsonDecode(response.body);
      print("responseData====${responseData}");

      if (responseData[0] != null) {
        print("1");
        print("IN");
        print("responseDataget=====${jsonDecode(response.body)}");

        Map<String, dynamic> productData = responseData[0];
        print("productData======${productData}");
        addToCartCustomizationModelClass =
            AddToCartCustomizationModelClass.fromJson(productData);
        print(
            "addToCartProductModelClass====${addToCartCustomizationModelClass!.qty}");
        return addToCartCustomizationModelClass;
      } else {
        print("10");
        return null;

        print("out");
      }
    } else {
      print("error api data not get");
      return null;
    }
  }

  // viewRestaurentCart(userid) async {
  //   var url = Uri.parse(AppContent.BASE_URL + AppContent.viewCart);
  //   Map viewCartProduct = {
  //     'user_id': userid,
  //   };
  //   var response = await http.post(url, body: viewCartProduct);
  //   print("viewCartProduct=====${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     var viewCartDProduct = jsonDecode(response.body);
  //
  //     if (viewCartProduct['status'] == 200) {
  //
  //
  //
  //
  //     }
  //   }
  // }
  Future<RestaurentReviewModel?> restaurantReviewGet(String sellerId) async {
    isrestaurantReviewGet = true;
    var url = Uri.parse(AppContent.BASE_URL + AppContent.restaurantReview);

    var response = await http.post(url, body: {'seller_id': sellerId});

    print("isrestaurantReviewGetresponse=====${response.body}");

    if (response.statusCode == 200) {
      isrestaurantReviewGet = false;

      restaurentReviewModel =
          RestaurentReviewModel.fromJson(jsonDecode(response.body));
      return restaurentReviewModel;
    } else {
      isrestaurantReviewGet = false;
      return null;
    }
  }

  Future<RestaurentReviewAddModel?> restaurantReviewAdd(
      String userId, String restaurantId, String rating, String comment) async {
    Map RestaurantReviewMap = {
      'user_id': userId,
      'restaurant_id': restaurantId,
      'rating': rating,
      'comment': comment,
    };

    print("RestaurantReviewMap===${RestaurantReviewMap}");

    var url = Uri.parse(AppContent.BASE_URL + AppContent.restaurantReviewAdd);

    var response = await http.post(url, body: RestaurantReviewMap);

    print("responce======${response.body}");
    if (response.statusCode == 200) {
      restaurentReviewAddModel =
          RestaurentReviewAddModel.fromJson(jsonDecode(response.body));
      return restaurentReviewAddModel;
    } else {
      return null;
    }
  }

  Future<List<CouponDetails>?> getRestorantCoupon(
      String restaurantId, String cityId) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.getCoupon);
    print(" widget.id=====${restaurantId}");
    print(" widget.id=====${cityId}");
    var response = await http.post(url,
        body: {'restaurant_mart_id': restaurantId, 'city_id': cityId});
    print('Response RestorantCoupon status: ${response.statusCode}');
    print('Response RestorantCoupon body: ${response.body}');

    if (response.statusCode == 200) {
      var restaurantCouponView = jsonDecode(response.body);
      coupon = RestaurantCouponModel.fromJson(restaurantCouponView).data;

      print("restaurantCouponModel======${coupon}");

      return coupon;
    } else {
      return null;
    }
  }

  Future<ApplyCouponModel?> applyCoupan(
      String coupancode, String amount) async {
    var url = Uri.parse(AppContent.BASE_URL + AppContent.applyCoupon);
    var response = await http
        .post(url, body: {'coupancode': coupancode, 'amount': amount});

    if (response.statusCode == 200) {
      var applyCouponGet = jsonDecode(response.body);
      if (applyCouponGet['success'] == true) {
        return applyCouponModel;
      } else {
        // showCustomSnackBar(applyCouponGet['message']);
        return applyCouponModel;
      }
    } else {
      showCustomSnackBar("error");
      return applyCouponModel;
    }
  }
}
