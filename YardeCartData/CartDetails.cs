using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartData
{
    public class CartDetails
    {
        public int CartId { set; get; }

        public int UserId { set; get; }

        public int AdPostId { set; get; }
        
        public int CreatedBy { set; get; }
        
        public int CartStatus { set; get; }

        public string CreatedOn { set; get; }

    }



}
