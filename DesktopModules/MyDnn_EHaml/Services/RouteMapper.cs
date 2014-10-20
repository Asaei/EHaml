using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace MyDnn_EHaml.Services
{
    public class RouteMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("MyDnn_EHaml_Inquiries", "default", "{controller}/{action}",
                new[] {"MyDnn_EHaml.Services"});
        }
    }
}