using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web;
using YardeCartCommon.Interface;
using YardeCartCommon;
namespace YardeCartServiceApp
{

    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class YardeCartServices : IYardeCartServices
    {
        public bool AddRegistration(UserDetails userDetails)
        {
            throw new NotImplementedException();
        }

        public bool ConfirmRegistration(int userId)
        {
            throw new NotImplementedException();
        }

        public bool ForgotPassword(string userEmail)
        {
            throw new NotImplementedException();
        }

        public bool LoginUser(LoginDetails loginDetails)
        {
            throw new NotImplementedException();
        }

        public bool AddBank(BankDetails bankDetials)
        {
            throw new NotImplementedException();
        }


        public string GetEmployee12(string Employee_id)
        {
            return "e";
        }
    }
}