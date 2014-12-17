using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EHamlLibrary.DTOs;

namespace EHamlLibrary.Interfaces
{
    public interface IListableForDashboardMyReplyToInquiryList
    {
        List<ReplyToInquiryListDTO> GetMyReplyToInquiryList(int userId,DateTime minDateTime, DateTime maxDateTime, List<ReplyToInquiryListDTO> replyToInquiryListDto);
    }
}