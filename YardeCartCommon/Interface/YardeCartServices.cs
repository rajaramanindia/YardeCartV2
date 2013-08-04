using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace YardeCartCommon.Interface
{
    [ServiceContract]
    public interface IYardeCartServices
    {

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "LoginUser")]
        bool LoginUser(LoginDetails loginDetails);


        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddRegistration")]
        bool AddRegistration(UserDetails userDetails);

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle=WebMessageBodyStyle.Bare, RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ConfirmRegistration")]
        bool ConfirmRegistration(int userId);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "ForgotPassword")]
        bool ForgotPassword(string userEmail);

        [OperationContract]
        [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, UriTemplate = "AddBank")]
        bool AddBank(BankDetails bankDetials);

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.Wrapped, ResponseFormat = WebMessageFormat.Json, UriTemplate = "Employees")]
        string GetEmployee12(string Employee_id);


    }
}
