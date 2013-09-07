using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartData
{
    public class UserDetails
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public string Address { get; set; }
        public string StreetName  { get; set; }
        public string Email { get; set; }
        public string MobilePhone { get; set; }
        public int CountryId { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public string ZipCode { get; set; }
        public string UserType { get; set; }
        //User type will be admin, user, premium user
        public Boolean IsActive { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime UpdatedOn { get; set; }
        public string LastLogedDateAndLocation { get; set; }
        public int UserStatus { get; set; }
        public int UserBlocked { get; set; }
        public int UserDeleted { get; set; }
    }

    public class UserAct
    {
        public string strUserid { get; set; }
    }
}
