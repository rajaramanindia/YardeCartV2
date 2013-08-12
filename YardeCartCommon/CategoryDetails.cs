using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartCommon
{
    public class CategoryDetails
    {
        public int CategoryId { set; get; }
        
        public string CategoryName { set; get; }
        
        public DateTime CreatedOn { set; get; }
        
        public int CreatedBy { set; get; }
        
        public int CategoryGroupId { set; get; }
    }

    public class CategoryGroupDetails
    {
        public int CategoryGroupId { set; get; }

        public string CategoryGroupName { set; get; }

        public DateTime CreatedOn { set; get; }

        public int CreatedBy { set; get; }
    }
}
