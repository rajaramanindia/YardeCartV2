using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartCommon
{
    public class UserDetails
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string MartialStaus { get; set; }
        public string Address { get; set; }
        public string EmailAdd { get; set; }
        public string MobilePhone { get; set; }
        public string Country { get; set; }
        public string PinCode { get; set; }
        public string UserType { get; set; }
        //User type will be admin, user, premium user
        public Boolean IsActive { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
        public string LastLogedDateAndLocation { get; set; }
    }
}
