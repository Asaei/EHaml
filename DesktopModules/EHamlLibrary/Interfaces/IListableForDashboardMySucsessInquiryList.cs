using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EHamlLibrary.DTOs;

namespace EHamlLibrary.Interfaces
{
    public interface IListableForDashboardMySucsessInquiryList
    {
        List<InquiryListDTO> GetMySucsessInquiryList(int userId, List<InquiryListDTO> inquiryListDto);
    }
}