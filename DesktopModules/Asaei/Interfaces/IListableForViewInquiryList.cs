using System.Collections.Generic;
using Asaei.Partials;


namespace Asaei.Interfaces
{
    public interface IListableForViewInquiryList
    {
        List<InquiryListForViewInquiryListDTO> InquiryListForViewInquiryList(string inquiryType);
    }
}