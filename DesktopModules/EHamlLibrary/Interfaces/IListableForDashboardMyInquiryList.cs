using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using EHamlLibrary.DTOs;

namespace EHamlLibrary.Interfaces
{
    public interface IListableForDashboardMyInquiryList
    {
        List<InquiryListDTO> GetMyInquiryList(int userId, DateTime minDate, DateTime maxDate, List<InquiryListDTO> inquiryListDto);
    }
}