using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartCommon
{
    public class ChargeDetails
    {
        public int ChargeId { set; get; }

        public string ChargeName { set; get; }

        public int ChargeType { set; get; }

        public float AmountOrPercent { set; get; }

        public int CreatedBy { set; get; }

        public DateTime CreatedOn { set; get; }
        
    }
}
