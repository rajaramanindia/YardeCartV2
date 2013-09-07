using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartData
{
    public class AdPostDetails
    {
        public int AdPostId { get; set; }
        public string AdPostTitle { get; set; }
        public string Description { get; set; }
        public string Keywords { get; set; }
        public int UserId { get; set; }
        public string PostedDate { get; set; }
        public int CategoryId { get; set; }
        public string Price { get; set; }
        public int StateId { get; set; }
        public int CityId { get; set; }
        public int CountryId { get; set; }
        public string ZipCode { get; set; }
        public string AdTillDate { get; set; }
        public string AdStatus { get; set; }
        public int PaidStatus { get; set; }
        public string PaidDate { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }
        public int AdBlocked { get; set; }
        public int AdDeleted { get; set; }

    }

    public class AdImageDetails
    {
        public int ImageId { get; set; }
        public int AdPostId { get; set; }
        public string ImagePath { get; set; }
        public string VideoLink { get; set; }
    }
    public class UserAdpost
    {
        public int AdPostId { get; set; }
        public int UserId { get; set; }

    }


}
