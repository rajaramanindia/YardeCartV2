using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartCommon
{
    public class BankDetails
    {
        public int BankId { set; get; }
        
        public int UserId { set; get; }

        public string BankName { set; get; }

        public string CardNumber { get; set; }

        public string CardHolderName { get; set; }

        public string CVCNumber { get; set; }

        public string BankBranch { get; set; }

    }
}
