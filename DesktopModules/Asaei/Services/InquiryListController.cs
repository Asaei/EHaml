using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;

namespace Asaei.Services
{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class InquiryListController : DnnApiController
    {
        [HttpGet]
        [AllowAnonymous]
        public HttpResponseMessage GetTest()
        {
            return Request.CreateResponse(HttpStatusCode.OK, "Chi chio beboram");
        }
    }
}