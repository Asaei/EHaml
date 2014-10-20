using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MyDnn_EHaml.Services
{
    internal class TarhListItemDTO
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public int? DayCount { get; set; }

        public bool? TarhType { get; set; }

        public decimal? Price { get; set; }
    }
}