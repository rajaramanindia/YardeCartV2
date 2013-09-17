using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Runtime.Serialization;
using System.Web;
using YardeCartCommon.Interface;
using YardeCartCommon;
using YardeCartData;
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

        public string LoginUser(LoginDetails loginDetails)
        {
            try
            {
                objDALComponent.SetParameters("@Username", SqlDbType.VarChar, 50, loginDetails.UserName);
                objDALComponent.SetParameters("@UserPassword", SqlDbType.VarChar, 50, loginDetails.UserPassword);
                objDALComponent.SqlCommandText = "ValidateUser";
                object y = objDALComponent.SelectRecordValue();
                if (int.Parse(y.ToString()) > 0)
                    return y.ToString();
                else
                    return null;
            }
            catch (SqlException sqlEx)
            {
               return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

          //System.Web.Script.Serialization.JavaScriptSerializer serializer =
          //     new System.Web.Script.Serialization.JavaScriptSerializer();
          //  List<Dictionary<string, object>> rows =
          //     new List<Dictionary<string, object>>();
          //  Dictionary<string, object> row = null;
// string s = { "Exception":"","":""};
        }

        public string LoginAdmin(LoginDetails loginDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adminName", SqlDbType.VarChar, 50, loginDetails.UserName);
                objDALComponent.SetParameters("@adminPassword", SqlDbType.VarChar, 50, loginDetails.UserPassword);
                objDALComponent.SqlCommandText = "ValidateAdmin";
                object y = objDALComponent.SelectRecordValue();
                if (int.Parse(y.ToString()) > 0)
                    return y.ToString();
                else
                    return null;
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

        }

        public void AddBank(BankDetails bankDetials)
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
                //return true;
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
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@adpostId", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDAL.SetParameters("@adpostTitle", SqlDbType.VarChar, 500, adpostDetails.AdPostTitle);
                objDAL.SetParameters("@description", SqlDbType.VarChar, 1000, adpostDetails.Description);
                objDAL.SetParameters("@keywords", SqlDbType.VarChar, 1000,adpostDetails.Keywords);
                objDAL.SetParameters("@userId", SqlDbType.Int, 4, adpostDetails.UserId);
                objDAL.SetParameters("@categoryId", SqlDbType.Int, 4, adpostDetails.CategoryId);
                objDAL.SetParameters("@price", SqlDbType.Decimal, 9, Convert.ToDecimal(adpostDetails.Price));
                objDAL.SetParameters("@stateId", SqlDbType.Int, 4, adpostDetails.StateId);
                objDAL.SetParameters("@cityId", SqlDbType.Int, 4, adpostDetails.CityId);
                objDAL.SetParameters("@countryId", SqlDbType.Int, 4, adpostDetails.CountryId);
                objDAL.SetParameters("@zipCode", SqlDbType.VarChar, 50, adpostDetails.ZipCode);
                objDAL.SetParameters("@adtillDate", SqlDbType.SmallDateTime, 4, adpostDetails.AdTillDate);
                objDAL.SetParameters("@adStatus", SqlDbType.VarChar, 50, adpostDetails.AdStatus);
                objDAL.SetParameters("@paidStatus", SqlDbType.Int, 4, adpostDetails.PaidStatus);
                objDAL.SetParameters("@idvalue", SqlDbType.Int, true);

                objDAL.SqlCommandText = "CreateAdPost";
                int x = objDAL.CreateRecord();

                object y = objDAL.GetParameters("@idvalue");

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

        public string AddAdImageDetails(AdImageDetails adimageDetails)
        {
            try
            {
                /*string[] strImg = new string[5];
                HttpPostedFile postedFile = strImg[0] as HttpPostedFile;
                strImg = adimageDetails.ImagePath.Split(':');
                string path = string.Empty;
                string strImgFinalPath = "";
                string finalPath = string.Empty;
                string filePath = string.Empty;
                int userId = 0;// Convert.ToInt32(Session["UserId"].ToString());
                string sFilename = "";
                if (FileUpload1.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload1.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        DirectoryInfo dirInfo = null;
                        fileSavePath = "/Data/TS_" + userId + "/Images/";
                        path = Server.MapPath("~" + fileSavePath);
                        if (!Directory.Exists(path))
                        {
                            dirInfo = Directory.CreateDirectory(path);
                        }
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload1.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);
                    }
                }
                strImgFinalPath = finalPath;

                if (FileUpload2.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload2.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        path = Server.MapPath("~" + fileSavePath);
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload2.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);

                        strImgFinalPath = strImgFinalPath + ":" + finalPath;
                    }
                }

                if (FileUpload3.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload3.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        path = Server.MapPath("~" + fileSavePath);
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload3.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);
                        strImgFinalPath = strImgFinalPath + ":" + finalPath;
                    }
                }

                if (FileUpload4.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload4.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        path = Server.MapPath("~" + fileSavePath);
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload4.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);
                        strImgFinalPath = strImgFinalPath + ":" + finalPath;
                    }
                }

                if (FileUpload5.PostedFile != null)
                {
                    HttpPostedFile myFile = FileUpload5.PostedFile;
                    int nFileLen = myFile.ContentLength;
                    if (nFileLen != 0)
                    {
                        path = Server.MapPath("~" + fileSavePath);
                        sFilename = System.IO.Path.GetFileName(myFile.FileName);
                        path = path + "/" + sFilename;
                        FileUpload5.PostedFile.SaveAs(path);

                        finalPath = Path.Combine(fileSavePath, sFilename);
                        strImgFinalPath = strImgFinalPath + ":" + finalPath;
                    }
                }*/
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@imageId", SqlDbType.Int, 4, adimageDetails.ImageId);
                objDAL.SetParameters("@adpostId", SqlDbType.Int, 4, adimageDetails.AdPostId);
                objDAL.SetParameters("@imagePath", SqlDbType.VarChar, 1000, adimageDetails.ImagePath);
                objDAL.SetParameters("@videoLink", SqlDbType.VarChar, 1000, adimageDetails.VideoLink);
                objDAL.SetParameters("@idvalue", SqlDbType.Int, true);

                objDAL.SqlCommandText = "CreateAdImageDetails";
                int x = objDAL.CreateRecord();

                object y = objDAL.GetParameters("@idvalue");

                return y.ToString();
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public void AdPostDeleteById(UserAdpost uAdpost)
        {
            try
            {
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, uAdpost.AdPostId);
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

        public string SelectAllProfile()
        {
            try
            {
                objDALComponent.SqlCommandText = "[SelectAllProfile]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string AvailableUser(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@Username", SqlDbType.VarChar, 50, userDetails.UserName);
                objDALComponent.SqlCommandText = "[AvailableUser]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string AvailableMail(string strEmail)
        {
            try
            {
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@email", SqlDbType.VarChar, 50, strEmail);
                objDAL.SqlCommandText = "[AvailableMail]";
                return GetJson(objDAL.SelectRecord());
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

        public string SelectProfile(string userId)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, Convert.ToInt32(userId));
                objDALComponent.SqlCommandText = "[SelectProfile]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public DataTable SelectUserProfile(UserDetails userDetails)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, userDetails.UserId);
                objDALComponent.SqlCommandText = "[SelectUserProfile]";
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

        public string SelectUserByEmail(string strEmail)
        {
            try
            {
                objDALComponent.SetParameters("@email", SqlDbType.VarChar, 100, strEmail);
                objDALComponent.SqlCommandText = "[SelectUserByEmail]";
                return GetJson(objDALComponent.SelectRecord());
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

        public string SelectUserPurchases(string strUserid)
        {
            try
            {
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, Convert.ToInt32(strUserid));
                objDALComponent.SqlCommandText = "[SelectUserPurchases]";
                return GetJson(objDALComponent.SelectRecord());
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

        public void UpdateActivation(UserAct userAct)
        {
            try
            {
                userAct.strUserid = userAct.strUserid.Replace(" ", "+");

                int u = Convert.ToInt32(UtilityClass.Decrypt(userAct.strUserid));
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, u);
                objDALComponent.SqlCommandText = "UpdateActivation";
                int x = objDALComponent.UpdateRecord();
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
                int x = objDALComponent.UpdateRecord();
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
                int x = objDALComponent.UpdateRecord();
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
                int x = objDALComponent.UpdateRecord();
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

        public DataTable SelectUserAdsDT(int intUserId)
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

        public string SelectUserAds(string strUserid)
        {
            try
            {
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, Convert.ToInt32(strUserid));
                objDALComponent.SqlCommandText = "[SelectUserAds]";
                return GetJson(objDALComponent.SelectRecord());
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

        public string GetAdDetails(string sAdPostID, string sAdUserID)
        {
            try
            {
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@adpostId", SqlDbType.Int, 4, Convert.ToInt32(sAdPostID));
                objDAL.SetParameters("@userId", SqlDbType.Int, 4, Convert.ToInt32(sAdUserID));
                objDAL.SqlCommandText = "[GetAdDetails]";
                string s = GetJson(objDAL.SelectRecord());
                return s;
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string GetAdPurcDetails(string sAdPostID, string sAdUserID)
        {
            try
            {
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@adpostId", SqlDbType.Int, 4, Convert.ToInt32(sAdPostID));
                objDAL.SetParameters("@userId", SqlDbType.Int, 4, Convert.ToInt32(sAdUserID));
                objDAL.SqlCommandText = "[GetAdPurcDetails]";
                string s = GetJson(objDAL.SelectRecord());
                return s;
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public DataTable GetAdDetailsDT(UserAdpost adpostDetails)
        {
            try
            {
                DALComponent objDALComponent1 = new DALComponent();
                objDALComponent1.SetParameters("@adpostId", SqlDbType.Int, 4, adpostDetails.AdPostId);
                objDALComponent1.SetParameters("@userId", SqlDbType.Int, 4, adpostDetails.UserId);
                objDALComponent1.SqlCommandText = "[GetAdDetails]";
                return objDALComponent1.SelectRecord();
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

        public string GetAllAdDetails()
        {
            try
            {
                objDALComponent.SqlCommandText = "[GetAllAdDetails]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SearchAdsByAdtitle(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByAdtitle]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        
        }

        public string SearchAdsByUsername(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByUsername]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

        }

        public string SearchAdsByKeyword(string strKeyword)
        {
            try
            {
                objDALComponent.SetParameters("@Keyword", SqlDbType.VarChar, 200, strKeyword);
                objDALComponent.SqlCommandText = "[SearchAdsByKeyword]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SearchAdsByCategory(string strCategoryId)
        {
            try
            {
                objDALComponent.SetParameters("@categoryId", SqlDbType.Int, 4, Convert.ToInt32(strCategoryId));
                objDALComponent.SqlCommandText = "[SearchAdsByCategory]";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

        }

        public string SelectReportsByDate(string strFromDate, string strToDate)
        {
            try
            {
                objDALComponent.SetParameters("@fromdate", SqlDbType.SmallDateTime, 4, Convert.ToDateTime(strFromDate));
                objDALComponent.SetParameters("@todate", SqlDbType.SmallDateTime, 4, Convert.ToDateTime(strToDate));
                objDALComponent.SqlCommandText = "[SelectReportsByDate]";
                return GetJson(objDALComponent.SelectRecord());
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

        public string SelectReportsByCity(string strRegionName)
        {
            try
            {
                objDALComponent.SetParameters("@cityname", SqlDbType.VarChar, 50, strRegionName);
                objDALComponent.SqlCommandText = "[SelectReportsByCity]";
                return GetJson(objDALComponent.SelectRecord());
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

        public string SelectAllCity()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCity";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SelectAllState()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectState";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SelectAllCountry()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCountry";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SelectCityByName(string strCityname)
        {
            try
            {
                objDALComponent.SetParameters("@cityname", SqlDbType.VarChar, 50, strCityname);
                objDALComponent.SqlCommandText = "[SelectCityByName]";
                return GetJson(objDALComponent.SelectRecord());
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

        public string SelectAllCategoryGroup()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCategoryGroup";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SelectAllCategory()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectCategory";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public DataTable SelectAllCategoryDT()
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

        public string SelectChargeDetails()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectChargeDetails";
                return GetJson(objDALComponent.SelectRecord());
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public DataTable SelectChargeDetailsDT()
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

        public string SelectChargeDetailsByID(string strChargeId)
        {
            try
            {
                DALComponent objDAL = new DALComponent();
                objDAL.SetParameters("@chargeId", SqlDbType.Int, 4, Convert.ToInt32(strChargeId));
                objDAL.SqlCommandText = "SelectChargeDetailsByID";
                return GetJson(objDAL.SelectRecord());
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

        #region .. CART DETAILS ..

        public string SelectUserCartDetails(string struserId)
        {
            try
            {
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, Convert.ToInt32(struserId));
                objDALComponent.SqlCommandText = "SelectUserCartDetails";
                return GetJson(objDALComponent.SelectRecord());
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

        public int CreateUserCart(CartDetails cartDetails)
        {
            try
            {
                objDALComponent.SetParameters("@cartId", SqlDbType.Int, 4, cartDetails.CartId);
                objDALComponent.SetParameters("@userId", SqlDbType.Int, 4, cartDetails.UserId);
                objDALComponent.SetParameters("@adpostId", SqlDbType.Int, 4, cartDetails.AdPostId);
                objDALComponent.SetParameters("@idvalue", SqlDbType.Int, true);

                objDALComponent.SqlCommandText = "CreateUserCart";
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

        public void CartDetailDelete(CartDetails cartDetails)
        {
            try
            {
                objDALComponent.SetParameters("@cartid", SqlDbType.Int, 4, cartDetails.CartId);
                objDALComponent.SqlCommandText = "CartDetailDelete";
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

        public string SelectMaxID()
        {
            try
            {
                objDALComponent.SqlCommandText = "SelectMaxID";
                return GetJson(objDALComponent.SelectRecord());
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

        public void UpdateCartStatus(CartDetails cartDetails)
        {
            try
            {
                objDALComponent.SetParameters("@adpostid", SqlDbType.Int, 4, cartDetails.AdPostId);
                objDALComponent.SetParameters("@userid", SqlDbType.Int, 4, cartDetails.UserId);
                objDALComponent.SqlCommandText = "UpdateCartStatus";
                int x = objDALComponent.UpdateRecord();
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

        public int CreateBuyDetails(AdStatusDetails adStatusDetails)
        {
            try
            {
                DALComponent oDal = new DALComponent();
                oDal.SetParameters("@adpostid", SqlDbType.Int, 4, adStatusDetails.AdPostId);
                oDal.SetParameters("@historyId", SqlDbType.Int, 4, adStatusDetails.HistroyId);
                oDal.SetParameters("@userId", SqlDbType.Int, 4, adStatusDetails.UserId_Buyer);
                oDal.SetParameters("@totalprice", SqlDbType.Decimal, 9, Convert.ToDecimal(adStatusDetails.TotalPrice));
                oDal.SetParameters("@delitype", SqlDbType.Int, 4, adStatusDetails.DeliveryType);
                oDal.SetParameters("@cityId", SqlDbType.Int, 4, adStatusDetails.SaleLocationId);
                oDal.SetParameters("@currentstatus", SqlDbType.VarChar, 50, adStatusDetails.CurrentStatus);
                oDal.SetParameters("@viewcount", SqlDbType.Int, 4, adStatusDetails.ViewersCount);
                oDal.SetParameters("@chargeName", SqlDbType.VarChar, 50, adStatusDetails.ChargeName);
                oDal.SetParameters("@chargeType", SqlDbType.Int, 4, adStatusDetails.ChargeType);
                oDal.SetParameters("@chargeAmount", SqlDbType.Float, 9, Convert.ToDouble(adStatusDetails.ChargeAmount));
                oDal.SetParameters("@idvalue", SqlDbType.Int, true);

                oDal.SqlCommandText = "[CreateBuyDetails]";
                int x = oDal.CreateRecord();

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

        #endregion

        #region .. COMMON FUNCTION ..

        public string SendMailtoUser(UserDetails userDetails)
        {
            try
            {
                string mUname = ConfigurationManager.AppSettings["mailUsername"].ToString();
                string mPwd = ConfigurationManager.AppSettings["mailPassword"].ToString();
                string mFrom = "";
                string mTo = userDetails.Email;
                string mCC = "";

                string mSubject = "YardeCart Activation mail";
                string serverPath = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + "/ActivateUser.aspx?uid=" + UtilityClass.Encrypt(userDetails.UserId.ToString()).ToString();
                string mMsg = "<html><body><form id='form1' runat='server'><div>" +
                "Dear " + userDetails.UserName + ",<br /><br />Thank you for registering at the YardeCart." +
                "Before we can activate your account one last step must be taken to complete your registration." +
                "<br /><br />Please note - you must complete this last step to become a registered member. You will only need to visit this URL once to activate your account." +
                "<br /><br />To complete your registration, please visit this URL:<br />" +
                "<a href='" + serverPath + "' runat='server' >" + serverPath + "</a>" +
                "<br /><br /><br /><br />All the best,<br />YardeCart.</div></form></body></html>";

                UtilityClass.SendMail(mUname, mPwd, mFrom, mTo, mCC, mSubject, mMsg, true);

                return "true";
            }
            catch (SystemException ex)
            {
                return ex.Message.ToString();
            }
        }

        public string SendMailForgot(UserDetails userDetails)
        {
            try
            {
                string mUname = ConfigurationManager.AppSettings["mailUsername"].ToString();
                string mPwd = ConfigurationManager.AppSettings["mailPassword"].ToString();
                string mFrom = "";
                string mTo = userDetails.Email;
                string mCC = "";

                string mSubject = "YardeCart User password mail";
                string serverPath = ConfigurationManager.AppSettings["ApplicationPath"].ToString() + "/Login.aspx";
                string mMsg = "<html><body><form id='form1' runat='server'><div>" +
                    "Dear " + userDetails.UserName + ",<br /><br />As you request, your username and password is given below:<br><br>" +
                    "<b>UserName : " + userDetails.UserName + "<br>Password : " + userDetails.UserPassword + "</b>" +
                    "<br /><br />Now you can login with Yard E-Cart<br />" +
                    "<a href='" + serverPath + "' runat='server' >" + serverPath + "</a>" +
                    "<br /><br /><br /><br />All the best,<br />Yard E-Cart.</div></form></body></html>";

                UtilityClass.SendMail(mUname, mPwd, mFrom, mTo, mCC, mSubject, mMsg, true);

                return "true";
            }
            catch (SystemException ex)
            {
                return ex.Message.ToString();
            }
        }

        public static string GetJson(DataTable dt)
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer =
               new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows =
               new List<Dictionary<string, object>>();
            Dictionary<string, object> row = null;

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }

        #endregion
    }
}