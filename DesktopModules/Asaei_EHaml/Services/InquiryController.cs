using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;
using Telerik.Web.UI.ImageEditor;
using Telerik.Web.UI.ODataSource.Filters;

namespace Asaei_EHaml.Services
{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class InquiryController : DnnApiController
    {
        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetInquiryListForViewInquiryList()
        {
            string inquiryTypeForViewInquiryList =
                this.ActiveModule.TabModuleSettings["InquiryTypeForViewInquiryList"].ToString();
            List<InquiryListForViewInquiryListDTO> result = null;
            try
            {
                Asaei_EHaml_Inquiry inquiry = new Asaei_EHaml_Inquiry();
                result = inquiry.InquiryListForViewInquiryList(inquiryTypeForViewInquiryList);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
    }
}