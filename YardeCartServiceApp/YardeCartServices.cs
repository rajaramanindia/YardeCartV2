using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web;
using YardeCartCommon.Interface;
using YardeCartCommon;
using YardeCartDataAccess;

namespace YardeCartServiceApp
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class YardeCartServices : IYardeCartServices
    {
        DALComponent objDALComponent = new DALComponent();

        #region .. USER REGISTER ..

        public int AddRegistration(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@UserId", SqlDbType.Int, 4, userDetails.UserId);
                objDALComponent.SetParameters("@UserName", SqlDbType.VarChar, 100, userDetails.UserName);
                objDALComponent.SetParameters("@FirstName", SqlDbType.VarChar, 100, userDetails.FirstName);
                objDALComponent.SetParameters("@LastName", SqlDbType.VarChar, 100, userDetails.LastName);
                objDALComponent.SetParameters("@Gender", SqlDbType.Int, 4, userDetails.Gender);
                objDALComponent.SetParameters("@UserPassword", SqlDbType.VarChar, 50, userDetails.UserPassword);
                objDALComponent.SetParameters("@Email", SqlDbType.VarChar, 50, userDetails.Email);
                objDALComponent.SetParameters("@Mobile", SqlDbType.VarChar, 50, userDetails.MobilePhone);
                objDALComponent.SetParameters("@Address", SqlDbType.VarChar, 100, userDetails.Address);
                objDALComponent.SetParameters("@StreetName", SqlDbType.VarChar, 50, userDetails.StreetName);
                objDALComponent.SetParameters("@CityId", SqlDbType.Int, 4, userDetails.CityId);
                objDALComponent.SetParameters("@StateId", SqlDbType.Int, 4, userDetails.StateId);
                objDALComponent.SetParameters("@CountryId", SqlDbType.Int, 4, userDetails.CountryId);
                objDALComponent.SetParameters("@ZipCode", SqlDbType.VarChar, 50, userDetails.ZipCode);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);
                objDALComponent.SqlCommandText = "CreateUser";
                int x = objDALComponent.CreateRecord();
                object y = objDALComponent.GetParameters("@idvalue");
                if (userDetails.UserId != 0)
                    return userDetails.UserId;
                else
                    return Int32.Parse(y.ToString());
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public bool ConfirmRegistration(int userId)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, userId);
                objDALComponent.SqlCommandText = "UpdateActivation";
                int x = objDALComponent.CreateRecord();
                return true;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable ForgotPassword(string userEmail)
        {
            try
            {
                objDALComponent.SetParameters("@email", SqlDbType.VarChar, 100, userEmail);
                objDALComponent.SqlCommandText = "SelectUserByEmail";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public int LoginUser(LoginDetails loginDetails)
        {
            try
            {
                objDALComponent.SetParameters("@Username", SqlDbType.VarChar, 50, loginDetails.UserName);
                objDALComponent.SetParameters("@UserPassword", SqlDbType.VarChar, 50, loginDetails.UserPassword);
                objDALComponent.SqlCommandText = "ValidateUser";
                object y = objDALComponent.SelectRecordValue();
                if (int.Parse(y.ToString()) > 0)
                    return int.Parse(y.ToString());
                else
                    return 0;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public int LoginAdmin(LoginDetails loginDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adminName", SqlDbType.VarChar, 50, loginDetails.UserName);
                objDALComponent.SetParameters("@adminPassword", SqlDbType.VarChar, 50, loginDetails.UserPassword);
                objDALComponent.SqlCommandText = "ValidateAdmin";
                object y = objDALComponent.SelectRecordValue();
                if (int.Parse(y.ToString()) > 0)
                    return int.Parse(y.ToString());
                else
                    return 0;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public bool AddBank(BankDetails bankDetials)
        {
            try
            {
                objDALComponent.SetParameters("@bankId", SqlDbType.Int, 4, bankDetials.BankId);
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, bankDetials.UserId);
                objDALComponent.SetParameters("@bankName", SqlDbType.VarChar, 200, bankDetials.BankName);
                objDALComponent.SetParameters("@cardholderName", SqlDbType.VarChar, 50, bankDetials.CardHolderName);
                objDALComponent.SetParameters("@creditcardNumber", SqlDbType.VarChar, 50, bankDetials.CardNumber);
                objDALComponent.SetParameters("@cvcNumber", SqlDbType.VarChar, 50, bankDetials.CVCNumber);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);
                objDALComponent.SqlCommandText = "CreateBankDetails";
                object y = objDALComponent.SelectRecordValue();
                return true;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. POST AD ..

        public int AddAdPost(AdPostDetails adpostDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent.SetParameters("@adpostTitle", SqlDbType.VarChar, 500, adpostDetails.AdPostTitle);
                objDALComponent.SetParameters("@description", SqlDbType.VarChar, 1000, adpostDetails.Description);
                objDALComponent.SetParameters("@keywords", SqlDbType.VarChar, 1000,adpostDetails.Keywords);
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, adpostDetails.UserId);
                objDALComponent.SetParameters("@categoryId", SqlDbType.Int, 4, adpostDetails.CategoryId);
                objDALComponent.SetParameters("@price", SqlDbType.Decimal, 9, adpostDetails.Price);
                objDALComponent.SetParameters("@stateId", SqlDbType.Int, 4, adpostDetails.StateId);
                objDALComponent.SetParameters("@cityId", SqlDbType.Int, 4, adpostDetails.CityId);
                objDALComponent.SetParameters("@countryId", SqlDbType.Int, 4, adpostDetails.CountryId);
                objDALComponent.SetParameters("@zipCode", SqlDbType.VarChar, 50, adpostDetails.ZipCode);
                objDALComponent.SetParameters("@adtillDate", SqlDbType.SmallDateTime, 4, adpostDetails.AdTillDate);
                objDALComponent.SetParameters("@adStatus", SqlDbType.VarChar, 50, adpostDetails.AdStatus);
                objDALComponent.SetParameters("@paidStatus", SqlDbType.Int, 4, adpostDetails.PaidStatus);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);

                objDALComponent.SqlCommandText = "CreateAdPost";
                int x = objDALComponent.CreateRecord();

                object y = objDALComponent.GetParameters("@idvalue");

                if (adpostDetails.AdPostId != 0)
                    return adpostDetails.AdPostId;
                else
                    return Int32.Parse(y.ToString());
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void AddAdImageDetails(AdImageDetails adimageDetails)
        {
            try
            {
                objDALComponent.SetParameters("@imageId", SqlDbType.Int, 4, adimageDetails.ImageId);
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, adimageDetails.AdPostId);
                objDALComponent.SetParameters("@imagePath", SqlDbType.VarChar, 1000, adimageDetails.ImagePath);
                objDALComponent.SetParameters("@videoLink", SqlDbType.VarChar, 1000, adimageDetails.VideoLink);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);

                objDALComponent.SqlCommandText = "CreateAdImageDetails";
                int x = objDALComponent.CreateRecord();

                object y = objDALComponent.GetParameters("@idvalue");
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void AdPostDeleteById(int intAdpostId)
        {
            try
            {
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, intAdpostId);
                objDALComponent.SqlCommandText = "AdPostDeleteById";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. SELECT USER ..

        public DataTable SelectAllProfile()
        {
            try
            {
                objDALComponent.SqlCommandText = "[SelectAllProfile]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable AvailableUser(string strUsername)
        {
            try
            {
                objDALComponent.SetParameters("@Username", SqlDbType.VarChar, 50, strUsername);
                objDALComponent.SqlCommandText = "[AvailableUser]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable AvailableMail(string strEmail)
        {
            try
            {
                objDALComponent.SetParameters("@email", SqlDbType.VarChar, 50, strEmail);
                objDALComponent.SqlCommandText = "[AvailableMail]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable GetUserName(int intUserId)
        {
            try
            {
                objDALComponent.SetParameters("@UserId", SqlDbType.Int, 4, intUserId);
                objDALComponent.SqlCommandText = "[UserNameGet]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectProfile(int intUserId)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, intUserId);
                objDALComponent.SqlCommandText = "[SelectProfile]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SearchUsers(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchUsers]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectUserByEmail(string strEmail)
        {
            try
            {
                objDALComponent.SetParameters("@email", SqlDbType.VarChar, 100, strEmail);
                objDALComponent.SqlCommandText = "[SelectUserByEmail]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectUserPurchases(int intUserid)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, intUserid);
                objDALComponent.SqlCommandText = "[SelectUserPurchases]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateActivation(int intUserid)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, intUserid);
                objDALComponent.SqlCommandText = "UpdateActivation";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateUserBlockStatus(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, userDetails.UserId);
                objDALComponent.SetParameters("@blockvalue", SqlDbType.Int, 4, userDetails.UserBlocked);
                objDALComponent.SqlCommandText = "UpdateUserBlockStatus";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateUserDeleteStatus(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, userDetails.UserId);
                objDALComponent.SetParameters("@delvalue", SqlDbType.Int, 4, userDetails.UserDeleted);
                objDALComponent.SqlCommandText = "UpdateUserDeleteStatus";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateUserPassword(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, userDetails.UserId);
                objDALComponent.SetParameters("@userpassword", SqlDbType.VarChar, 50, userDetails.UserPassword);
                objDALComponent.SqlCommandText = "UpdateUserPassword";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. SELECT POST AD ..

        public DataTable SelectUserAds(int intUserId)
        {
            try
            {
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, intUserId);
                objDALComponent.SqlCommandText = "[SelectUserAds]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable GetAdDetails(AdPostDetails adpostDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, adpostDetails.UserId);
                objDALComponent.SqlCommandText = "[GetAdDetails]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable GetAdImageDetails(AdPostDetails adpostDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, adpostDetails.UserId);
                objDALComponent.SqlCommandText = "[GetAdImageDetails]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable GetAllAdDetails()
        {
            try
            {
                objDALComponent.SqlCommandText = "[GetAllAdDetails]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SearchAdsByAdtitle(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByAdtitle]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        
        }

        public DataTable SearchAdsByUsername(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByUsername]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }

        }

        public DataTable SearchAdsByKeyword(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByKeyword]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }

        }

        public DataTable SelectReportsByDate(ReportDetails reportDetails)
        {
            try
            {
                objDALComponent.SetParameters("@fromdate", SqlDbType.SmallDateTime, 4, reportDetails.FromDate);
                objDALComponent.SetParameters("@todate", SqlDbType.SmallDateTime, 4, reportDetails.ToDate);
                objDALComponent.SqlCommandText = "[SelectReportsByDate]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }

        }

        public DataTable SelectReportsByCity(string strRegionName)
        {
            try
            {
                objDALComponent.SetParameters("@cityname", SqlDbType.VarChar, 50, strRegionName);
                objDALComponent.SqlCommandText = "[SelectReportsByCity]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }

        }

        public void UpdateAdImagePath(AdImageDetails adImagDetails)
        {
            try
            {
                objDALComponent.SetParameters("@imageid", SqlDbType.Int, 4, adImagDetails.ImageId);
                objDALComponent.SetParameters("@imagepath", SqlDbType.VarChar, 1000, adImagDetails.ImagePath);
                objDALComponent.SqlCommandText = "UpdateImagePath";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateAdBlockStatus(AdPostDetails adpostDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostid", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent.SetParameters("@blockvalue", SqlDbType.Int, 4, adpostDetails.AdBlocked);
                objDALComponent.SqlCommandText = "UpdateAdBlockStatus";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void UpdateAdDeleteStatus(AdPostDetails adpostDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostid", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent.SetParameters("@delvalue", SqlDbType.Int, 4, adpostDetails.AdDeleted);
                objDALComponent.SqlCommandText = "UpdateAdDeleteStatus";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. CITY, STATE & COUNTRY ..

        public DataTable SelectAllCity()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCity";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectAllState()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectState";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectAllCountry()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCountry";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectCityByName(string strCityname)
        {
            try
            {
                objDALComponent.SetParameters("@cityname", SqlDbType.VarChar, 50, strCityname);
                objDALComponent.SqlCommandText = "[SelectCityByName]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectCityByID(int intCityId)
        {
            try
            {
                objDALComponent.SetParameters("@cityid", SqlDbType.Int, 4, intCityId);
                objDALComponent.SqlCommandText = "[SelectCityById]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. CATEGORY GROUP & CATEGORY LIST ..

        public DataTable SelectAllCategoryGroup()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCategoryGroup";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectAllCategory()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCategory";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public int AddCategory(CategoryDetails categoryDetails)
        {
            try
            {
                objDALComponent.SetParameters("@categoryId", SqlDbType.Int, 4, categoryDetails.CategoryId);
                objDALComponent.SetParameters("@categoryName", SqlDbType.VarChar, 50, categoryDetails.CategoryName);
                objDALComponent.SetParameters("@categoryGroupId", SqlDbType.Int, 4, categoryDetails.CategoryGroupId);
                objDALComponent.SqlCommandText = "CategoryEdit";
                int x = objDALComponent.CreateRecord();
                return x;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public int AddCategoryGroup(CategoryGroupDetails categorygroupDetails)
        {
            try
            {
                objDALComponent.SetParameters("@categoryGroupId", SqlDbType.Int, 4, categorygroupDetails.CategoryGroupId);
                objDALComponent.SetParameters("@categoryGroupName", SqlDbType.VarChar, 100, categorygroupDetails.CategoryGroupName);
                objDALComponent.SqlCommandText = "CategoryGroupUpdate";
                int x = objDALComponent.CreateRecord();
                return x;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void CategoryDelete(int intCategoryId)
        {
            try
            {
                objDALComponent.SetParameters("@categoryId", SqlDbType.Int, 4, intCategoryId);
                objDALComponent.SqlCommandText = "CategoryDelete";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void CategoryGroupDelete(int intCategoryGroupId)
        {
            try
            {
                objDALComponent.SetParameters("@categoryGroupId", SqlDbType.Int, 4, intCategoryGroupId);
                objDALComponent.SqlCommandText = "CategoryGroupDelete";
                int x = objDALComponent.DeleteRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable AvailableCategoryGroup(string strGroupName)
        {
            try
            {
                objDALComponent.SetParameters("@groupname", SqlDbType.VarChar, 50, strGroupName);
                objDALComponent.SqlCommandText = "[AvailableCategoryGroup]";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

        #region .. CHARGE DETAILS ..

        public int AddChargeDetails(ChargeDetails chargeDetails)
        {
            try
            {
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, chargeDetails.CreatedBy);
                objDALComponent.SetParameters("@chargeId", SqlDbType.Int, 4, chargeDetails.ChargeId);
                objDALComponent.SetParameters("@chargeName", SqlDbType.VarChar, 50, chargeDetails.ChargeName);
                objDALComponent.SetParameters("@chargeType", SqlDbType.Int, 4, chargeDetails.ChargeType);
                objDALComponent.SetParameters("@amtorpercent", SqlDbType.Float, 18, chargeDetails.AmountOrPercent);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);
                objDALComponent.SqlCommandText = "[CreateChargeDetails]";
                int x = objDALComponent.CreateRecord();

                return x;
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectChargeDetails()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectChargeDetails";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public DataTable SelectChargeDetailsByID(int intChargeId)
        {
            try
            {
                objDALComponent.SetParameters("@chargeId", SqlDbType.Int, 4, intChargeId);
                objDALComponent.SqlCommandText = "SelectChargeDetailsByID";
                return objDALComponent.SelectRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        public void ChargeDetailsDelete(int intChargeId)
        {
            try
            {
                objDALComponent.SetParameters("@chargeId", SqlDbType.Int, 4, intChargeId);
                objDALComponent.SqlCommandText = "ChargeDetailsDelete";
                int x = objDALComponent.CreateRecord();
            }
            catch (SqlException sqlEx)
            {
                throw new ApplicationException("Data error=" + sqlEx.Message.ToString());
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error=" + ex.Message.ToString());
            }
        }

        #endregion

    }
}