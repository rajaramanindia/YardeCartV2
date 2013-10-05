using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Data;
using System.ServiceModel;
using System.ServiceModel.Web;
using YardeCartData;
using YardeCartDataAccess;

namespace YardeCartServiceApp
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IYardService" in both code and config file together.
    [ServiceContract]
    public interface IYardeCartServices
    {
        #region .. USER REGISTER ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "LoginAdmin")]
        string LoginAdmin(LoginDetails loginDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "LoginUser")]
        string LoginUser(LoginDetails loginDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddRegistration")]
        int AddRegistration(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.Bare, RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ConfirmRegistration")]
        bool ConfirmRegistration(int userId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ForgotPassword")]
        DataTable ForgotPassword(string userEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddBank")]
        void AddBank(BankDetails bankDetials);

        #endregion

        #region .. POST AD ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddAdPost")]
        int AddAdPost(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddAdImageDetails")]
        string AddAdImageDetails(AdImageDetails adimageDetails);

        [OperationContract]
        [WebInvoke(Method = "DELETE", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AdPostDeleteById")]
        void AdPostDeleteById(UserAdpost uAdpost);

        #endregion

        #region .. SELECT USER ..

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllProfile")]
        string SelectAllProfile();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AvailableUser")]
        string AvailableUser(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AvailableMail/{strEmail}")]
        string AvailableMail(string strEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetUserName")]
        DataTable GetUserName(int intUserId);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectProfile/{userId}")]
        string SelectProfile(string userId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserProfile")]
        DataTable SelectUserProfile(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchUsers")]
        DataTable SearchUsers(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserByEmail/{strEmail}")]
        string SelectUserByEmail(string strEmail);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserPurchases/{strUserid}")]
        string SelectUserPurchases(string strUserid);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateActivation")]
        void UpdateActivation(UserAct userAct);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserBlockStatus")]
        void UpdateUserBlockStatus(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserDeleteStatus")]
        void UpdateUserDeleteStatus(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserPassword")]
        void UpdateUserPassword(UserDetails userDetails);

        #endregion

        #region .. SELECT POST AD ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserAdsDT")]
        DataTable SelectUserAdsDT(int intUserId);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserAds/{strUserid}")]
        string SelectUserAds(string strUserid);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdDetails/{sAdPostID}/{sAdUserID}")]
        string GetAdDetails(string sAdPostID, string sAdUserID);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdPurcDetails/{sAdPostID}/{sAdUserID}")]
        string GetAdPurcDetails(string sAdPostID, string sAdUserID);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdDetailsDT")]
        DataTable GetAdDetailsDT(UserAdpost adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdImageDetails")]
        DataTable GetAdImageDetails(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAllAdDetails")]
        string GetAllAdDetails();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByAdtitle")]
        string SearchAdsByAdtitle(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByUsername")]
        string SearchAdsByUsername(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByKeyword/{strKeyword}")]
        string SearchAdsByKeyword(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByPlace/{strPlace}")]
        string SearchAdsByPlace(string strPlace);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByCategory/{strCategoryId}")]
        string SearchAdsByCategory(string strCategoryId);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectReportsByDate/{strFromDate}/{strToDate}")]
        string SelectReportsByDate(string strFromDate, string strToDate);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectReportsByCity/{strRegionName}")]
        string SelectReportsByCity(string strRegionName);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdImagePath")]
        void UpdateAdImagePath(AdImageDetails adImagDetails);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdBlockStatus")]
        void UpdateAdBlockStatus(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdDeleteStatus")]
        void UpdateAdDeleteStatus(AdPostDetails adpostDetails);

        #endregion

        #region .. CITY, STATE & COUNTRY ..

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCity")]
        string SelectAllCity();

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllState")]
        string SelectAllState();

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCountry")]
        string SelectAllCountry();

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectCityByName/{strCityname}")]
        string SelectCityByName(string strCityname);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectCityByID")]
        DataTable SelectCityByID(int intCityId);

        #endregion

        #region .. CATEGORY GROUP & CATEGORY LIST ..

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCategoryGroup")]
        string SelectAllCategoryGroup();

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCategory")]
        string SelectAllCategory();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCategoryDT")]
        DataTable SelectAllCategoryDT();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddCategory")]
        int AddCategory(CategoryDetails categoryDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddCategoryGroup")]
        int AddCategoryGroup(CategoryGroupDetails categorygroupDetails);

        [OperationContract]
        [WebInvoke(Method = "DELETE", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CategoryDelete")]
        void CategoryDelete(int intCategoryId);

        [OperationContract]
        [WebInvoke(Method = "DELETE", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CategoryGroupDelete")]
        void CategoryGroupDelete(int intCategoryGroupId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AvailableCategoryGroup")]
        DataTable AvailableCategoryGroup(string strGroupName);

        #endregion

        #region .. CHARGE DETAILS ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddChargeDetails")]
        int AddChargeDetails(ChargeDetails chargeDetails);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectChargeDetails")]
        string SelectChargeDetails();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectChargeDetailsDT")]
        DataTable SelectChargeDetailsDT();

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectChargeDetailsByID/{strChargeId}")]
        string SelectChargeDetailsByID(string strChargeId);

        [OperationContract]
        [WebInvoke(Method = "DELETE", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ChargeDetailsDelete")]
        void ChargeDetailsDelete(int intChargeId);

        #endregion

        #region .. CART DETAILS ..

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserCartDetails/{struserId}")]
        string SelectUserCartDetails(string struserId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CreateUserCart")]
        int CreateUserCart(CartDetails cartDetails);

        [OperationContract]
        [WebInvoke(Method = "DELETE", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CartDetailDelete")]
        void CartDetailDelete(CartDetails cartDetails);

        [OperationContract]
        [WebInvoke(Method = "GET", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectMaxID")]
        string SelectMaxID();

        [OperationContract]
        [WebInvoke(Method = "PUT", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateCartStatus")]
        void UpdateCartStatus(CartDetails cartDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CreateBuyDetails")]
        int CreateBuyDetails(AdStatusDetails adStatusDetails);

        #endregion

        #region .. COMMON FUNCTION ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SendMailtoUser")]
        string SendMailtoUser(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SendMailForgot")]
        string SendMailForgot(UserDetails userDetails);

        #endregion
 
    }
}
