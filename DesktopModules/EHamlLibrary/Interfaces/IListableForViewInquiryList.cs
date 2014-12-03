using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EHamlLibrary.DTOs;

namespace EHamlLibrary.Interfaces
{
    public interface IListableForViewInquiryList
    {
        List<InquiryListDTO> GetInquiryListForViewInquiryList(string inquiryType);
    }
}