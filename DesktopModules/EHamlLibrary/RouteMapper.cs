using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Web.Api;

namespace EHamlLibrary
{
    public class RouteMapper : IServiceRouteMapper
    {
        public void RegisterRoutes(IMapRoute mapRouteManager)
        {
            mapRouteManager.MapHttpRoute("EHamlLibrary", "default", "{controller}/{action}",
                new[] { "EHamlLibrary.Services" });
        }
    }
}