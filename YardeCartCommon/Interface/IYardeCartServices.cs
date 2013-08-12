﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Data;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace YardeCartCommon.Interface
{
    [ServiceContract]
    public interface IYardeCartServices
    {
        #region .. USER REGISTER ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "LoginAdmin")]
        int LoginAdmin(LoginDetails loginDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "LoginUser")]
        int LoginUser(LoginDetails loginDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddRegistration")]
        int AddRegistration(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle=WebMessageBodyStyle.Bare, RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ConfirmRegistration")]
        bool ConfirmRegistration(int userId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ForgotPassword")]
        DataTable ForgotPassword(string userEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddBank")]
        bool AddBank(BankDetails bankDetials);

        #endregion

        #region .. POST AD ..
        
        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddAdPost")]
        int AddAdPost(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddAdImageDetails")]
        void AddAdImageDetails(AdImageDetails adimageDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AdPostDeleteById")]
        void AdPostDeleteById(int intAdpostId);
        
        #endregion

        #region .. SELECT USER ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllProfile")]
        DataTable SelectAllProfile();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AvailableUser")]
        DataTable AvailableUser(string strUsername);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AvailableMail")]
        DataTable AvailableMail(string strEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetUserName")]
        DataTable GetUserName(int intUserId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectProfile")]
        DataTable SelectProfile(int intUserId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchUsers")]
        DataTable SearchUsers(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserByEmail")]
        DataTable SelectUserByEmail(string strEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserPurchases")]
        DataTable SelectUserPurchases(int intUserid);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateActivation")]
        void UpdateActivation(int intUserid);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserBlockStatus")]
        void UpdateUserBlockStatus(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserDeleteStatus")]
        void UpdateUserDeleteStatus(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateUserPassword")]
        void UpdateUserPassword(UserDetails userDetails);

        #endregion

        #region .. SELECT POST AD ..
        
        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectUserAds")]
        DataTable SelectUserAds(int intUserId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdDetails")]
        DataTable GetAdDetails(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAdImageDetails")]
        DataTable GetAdImageDetails(AdPostDetails adpostDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "GetAllAdDetails")]
        DataTable GetAllAdDetails();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByAdtitle")]
        DataTable SearchAdsByAdtitle(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByUsername")]
        DataTable SearchAdsByUsername(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SearchAdsByKeyword")]
        DataTable SearchAdsByKeyword(string strKeyword);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectReportsByDate")]
        DataTable SelectReportsByDate(ReportDetails reportDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectReportsByCity")]
        DataTable SelectReportsByCity(string strRegionName);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdImagePath")]
        void UpdateAdImagePath(AdImageDetails adImagDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdBlockStatus")]
        void UpdateAdBlockStatus(AdPostDetails adpostDetails);
        
        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "UpdateAdDeleteStatus")]
        void UpdateAdDeleteStatus(AdPostDetails adpostDetails);
        
        #endregion

        #region .. CITY, STATE & COUNTRY ..

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCity")]
        DataTable SelectAllCity();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllState")]
        DataTable SelectAllState();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCountry")]
        DataTable SelectAllCountry();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectCityByName")]
        DataTable SelectCityByName(string strCityname);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectCityByID")]
        DataTable SelectCityByID(int intCityId);

        #endregion

        #region .. CATEGORY GROUP & CATEGORY LIST ..
       
        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCategoryGroup")]
        DataTable SelectAllCategoryGroup();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectAllCategory")]
        DataTable SelectAllCategory();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddCategory")]
        int AddCategory(CategoryDetails categoryDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddCategoryGroup")]
        int AddCategoryGroup(CategoryGroupDetails categorygroupDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CategoryDelete")]
        void CategoryDelete(int intCategoryId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "CategoryGroupDelete")]
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
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectChargeDetails")]
        DataTable SelectChargeDetails();

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "SelectChargeDetailsByID")]
        DataTable SelectChargeDetailsByID(int intChargeId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ChargeDetailsDelete")]
        void ChargeDetailsDelete(int intChargeId);

        #endregion


    }
}