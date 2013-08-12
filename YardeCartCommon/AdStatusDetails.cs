﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace YardeCartCommon
{
    public class AdStatusDetails
    {
        public int AdPostId { set; get; }

        public int HistroyId { set; get; }

        public int ViewersCount { set; get; }

        public int UserId_Buyer { set; get; }

        public DateTime SaleDate { set; get; }

        public int SaleLocationId { set; get; }

        public string CurrentStatus { set; get; }

        public string DeliveryName { set; get; }

        public DateTime DeliveryDate { set; get; }

        public string DeliveryAddress { set; get; }

        public string DeliveryType { set; get; }

        public decimal TotalPrice { set; get; }

        public string ChargeName { set; get; }

        public int ChargeType { set; get; }

        public float ChargeAmount { set; get; }

    }

    public class ReportDetails
    {
        public DateTime FromDate { set; get; }
        
        public DateTime ToDate { set; get; }

        public string RegionName { set; get; }
    }
}