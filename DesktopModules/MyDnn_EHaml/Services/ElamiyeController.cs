using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security;
using DotNetNuke.Web.Api;
using Telerik.Web.UI.ImageEditor;

namespace MyDnn_EHaml.Services
{
    [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
    public class ElamiyeController : DnnApiController
    {
        private Util _util = new Util();

        [HttpGet]
        public HttpResponseMessage MyElamiyeList(int UserId, int ModuleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(ModuleId);
            string value = setting["grideMoredeNazarVaseDashboardElamiyeSaheb"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            int ehamlUserIdAsli = _util.GetUserEHamlUserIdByPortalId(UserId);
            //            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<ElamiyeListItemJftGeneral> elamiyeList = new List<ElamiyeListItemJftGeneral>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                elamiyeList.AddRange(from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile = i.Tedad + " دستگاه " + i.VasileyeHamleAmadeyeBargiri + " از " + i.Mabda,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    });

                elamiyeList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile =
                            i.Tedad + " کانتینر " + i.ContinerHayeAmadeyeBargiri + " از " + i.Mabda + " به " + i.Magsad,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    }));

                elamiyeList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile =
                            i.Tedad + " واگن " + i.VagoneHamleAmadeyeBargiri + " از " + i.Mabda + " به " + i.Magsad,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    }));


                return Request.CreateResponse(HttpStatusCode.OK, elamiyeList);
            }
        }

        [HttpGet]
        public HttpResponseMessage MyElamiyeListServent(int UserId, int ModuleId)
        {
            ModuleController controller = new ModuleController();
            var setting = controller.GetTabModuleSettings(ModuleId);
            string value = setting["grideMoredeNazarVaseDashboardElamiyeServent"].ToString();

            DateTime minDateTime;
            DateTime maxDateTime;

            if (value == "استعلامات قبلی")
            {
                minDateTime = DateTime.Today.AddYears(-100).Date;
                maxDateTime = DateTime.Today.Date;
            }
            else
            {
                minDateTime = DateTime.Today.Date.Date;
                maxDateTime = DateTime.Today.AddYears(100).Date;
            }

            int ehamlUserIdAsli = _util.GetUserEHamlUserIdByPortalId(UserId);
            //            string inquiryTypeForList = this.ActiveModule.TabModuleSettings["InquiryTypeForList"].ToString();
            List<ElamiyeListItemJftGeneral> elamiyeList = new List<ElamiyeListItemJftGeneral>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                int ehamlUserId = (from i in context.MyDnn_EHaml_Users
                    where i.PortalUserId == this.UserInfo.UserID
                    select i.Id).Single();

                elamiyeList.AddRange(from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile = i.Tedad + " دستگاه " + i.VasileyeHamleAmadeyeBargiri + " از " + i.Mabda,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    });

                elamiyeList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile =
                            i.Tedad + " کانتینر " + i.ContinerHayeAmadeyeBargiri + " از " + i.Mabda + " به " + i.Magsad,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    }));

                elamiyeList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                    where i.MyDnn_EHaml_User_Id == ehamlUserId
                          && i.ExpireDate.Date > minDateTime && i.ExpireDate.Date <= maxDateTime
                    select new ElamiyeListItemJftGeneral()
                    {
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value,
                        Vasile =
                            i.Tedad + " واگن " + i.VagoneHamleAmadeyeBargiri + " از " + i.Mabda + " به " + i.Magsad,
                        ZamaneAmadegi = i.ZamaneAmadegi,
                        ExpireDate = i.ExpireDate,
                        TedadePasohkha = (from j in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            where j.ElamiyeId == i.Id
                            select i).Count(),
                        ElamiyeType = GetFarsiElamiyeType(i.ElamiyeType),
                        ElamiyeTypeEN = i.ElamiyeType,
                    }));


                return Request.CreateResponse(HttpStatusCode.OK, elamiyeList);
            }
        }

        private string GetFarsiElamiyeType(string elamiyeType)
        {
            string result = string.Empty;

            if (elamiyeType.Contains("Jadei") || elamiyeType.Contains("جاده ای"))
            {
                result = "خالی جاده ای";
            }
            else if (elamiyeType.Contains("Reyli") || elamiyeType.Contains("ریلی"))
            {
                result = "خالی ریلی";
            }
            else if (elamiyeType.Contains("Daryayi") || elamiyeType.Contains("دریایی"))
            {
                result = "خالی دریایی";
            }

            return result;
        }

        [HttpGet]
        public List<MyElamiuesReplyJft> MyElamiyeReplyList(int elamiyeID, string elamiyeType)
        {
            string ttype = string.Empty;
            if (elamiyeType.Contains("Jadei") || elamiyeType.Contains("جاده ای"))
            {
                ttype = "Jadei";
            }
            else if (elamiyeType.Contains("Reyli") || elamiyeType.Contains("ریلی"))
            {
                ttype = "Reyli";
            }
            else if (elamiyeType.Contains("Daryayi") || elamiyeType.Contains("دریایی"))
            {
                ttype = "Daryayi";
            }

            List<MyElamiuesReplyJft> myElamiyesReplies = new List<MyElamiuesReplyJft>();


            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Elamiye_ReplyToElamiye elamiye = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                    where i.ElamiyeId == elamiyeID && i.ElamiyeType == elamiyeType
                    select i).FirstOrDefault();

                if (elamiye != null)
                {
                    if (ttype == "Jadei")
                    {
                        myElamiyesReplies = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis on i.ReplyToElamiyeId equals j.Id
                            where i.ElamiyeType.Contains("Jadei") && i.ElamiyeId == elamiye.ElamiyeId
                            select new MyElamiuesReplyJft()
                            {
                                rtelID = j.Id,
                                elaId = i.ElamiyeId,
                                ERTEID = i.Id,
                                //StatusPR = _util.GetUserStatus(_util.GetServantUserByInquiryReplyToInquiryId(i.Id), 0),
                                DisplayName = UserController.GetUserById(0, (int) (from k in context.MyDnn_EHaml_Users
                                    where k.Id == j.MyDnn_EHaml_User_Id
                                    select k.PortalUserId).Single()).DisplayName,
                                //GeymateKol = j.GeymateKol.ToString(),
                                //ZamaneAmadegiBarayeShooroo =
                                Status = i.Status,
                                CreateDate = i.CreateDate.ToShortDateString(),
                                //ModateAnjameAmaliyat = j.KoleModatZamaneHaml,
                                //Pishbini = j.Pishbini,
                                Power = _util.GetUserPower((int) j.MyDnn_EHaml_User_Id),
                                Rank = _util.GetUserRank((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                VaziyatePaziresh = i.Status.ToString(),
                                NameKhedmatresan = _util.GetNameKhadamatResan((int) j.MyDnn_EHaml_User_Id),
                                Masir =
                                    (j.Mabda + "," + j.Magsad).Replace(",", "<span class='flash'></span>"),
                                VasileyeHaml =
                                    j.VasileyeHamleMoredeNiyaz,
                                Tedad = j.Tedad.ToString(),
                                zaman = j.ZamaneMoredeNiyaz.Value.ToShortDateString(),
                                typeela = i.ElamiyeType,
                                NazarSanji = "",
                            }).ToList();
                    }
                    if (ttype == "Daryayi")
                    {
                        myElamiyesReplies = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis on i.ReplyToElamiyeId equals j.Id
                            where i.ElamiyeType.Contains("Daryayi") && i.ElamiyeId == elamiye.ElamiyeId
                            select new MyElamiuesReplyJft()
                            {
                                rtelID = j.Id,
                                elaId = i.ElamiyeId,
                                ERTEID = i.Id,
                                //StatusPR = _util.GetUserStatus(_util.GetServantUserByInquiryReplyToInquiryId(i.Id), 0),
                                DisplayName = UserController.GetUserById(0, (int) (from k in context.MyDnn_EHaml_Users
                                    where k.Id == j.MyDnn_EHaml_User_Id
                                    select k.PortalUserId).Single()).DisplayName,
                                //GeymateKol = j.GeymateKol.ToString(),
                                //ZamaneAmadegiBarayeShooroo =
                                Status = i.Status,
                                CreateDate = i.CreateDate.ToShortDateString(),
                                //ModateAnjameAmaliyat = j.KoleModatZamaneHaml,
                                //Pishbini = j.Pishbini,
                                Power = _util.GetUserPower((int) j.MyDnn_EHaml_User_Id),
                                Rank = _util.GetUserRank((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                VaziyatePaziresh = i.Status.ToString(),
                                NameKhedmatresan = _util.GetNameKhadamatResan((int) j.MyDnn_EHaml_User_Id),
                                Masir = (j.Mabda + "," + j.Magsad).Replace(",", "<span class='flash'></span>"),
                                VasileyeHaml = j.VasileyeHamleMoredeNiyaz,
                                Tedad = j.Tedad.ToString(),
                                zaman = j.ZamaneMoredeNiyaz.Value.ToShortDateString(),
                                typeela = i.ElamiyeType,
                                NazarSanji = "",
                            }).ToList();
                    }
                    if (ttype == "Reyli")
                    {
                        myElamiyesReplies = (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis on i.ReplyToElamiyeId equals
                                j.Id
                            where i.ElamiyeType.Contains("Reyli") && i.ElamiyeId == elamiye.ElamiyeId
                            select new MyElamiuesReplyJft()
                            {
                                rtelID = j.Id,
                                elaId = i.ElamiyeId,
                                ERTEID = i.Id,
                                //StatusPR = _util.GetUserStatus(_util.GetServantUserByInquiryReplyToInquiryId(i.Id), 0),
                                DisplayName =
                                    UserController.GetUserById(0, (int) (from k in context.MyDnn_EHaml_Users
                                        where k.Id == j.MyDnn_EHaml_User_Id
                                        select k.PortalUserId).Single()).DisplayName,
                                //GeymateKol = j.GeymateKol.ToString(),
                                //ZamaneAmadegiBarayeShooroo =
                                Status = i.Status,
                                CreateDate = i.CreateDate.ToShortDateString(),
                                //ModateAnjameAmaliyat = j.KoleModatZamaneHaml,
                                //Pishbini = j.Pishbini,
                                Power = _util.GetUserPower((int) j.MyDnn_EHaml_User_Id),
                                Rank = _util.GetUserRank((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliKhoob =
                                    _util.GetNazareKoliKhoobKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) j.MyDnn_EHaml_User_Id),
                                VaziyatePaziresh = i.Status.ToString(),
                                NameKhedmatresan = _util.GetNameKhadamatResan((int) j.MyDnn_EHaml_User_Id),
                                Masir = (j.Mabda + "," + j.Magsad).Replace(",", "<span class='flash'></span>"),
                                VasileyeHaml = j.VasileyeHamleMoredeNiyaz,
                                Tedad = j.Tedad.ToString(),
                                zaman = j.ZamaneMoredeNiyaz.Value.ToShortDateString(),
                                typeela = i.ElamiyeType,
                                NazarSanji = "",
                            }).ToList();
                    }


                    foreach (MyElamiuesReplyJft elamiuesReplyJft in myElamiyesReplies)
                    {
                        if (!(elamiuesReplyJft.Status == 1))
                        {
                            elamiuesReplyJft.DisplayName = "***";
                        }
                    }

                    foreach (MyElamiuesReplyJft elamiuesReplyJft in myElamiyesReplies)
                    {
                        if ((elamiuesReplyJft.DisplayName != "***"))
                        {
                            MyDnn_EHaml_ReplyToElamiye_KhaliJadei replyToElamiyeJadei = null;
                            using (
                                DataClassesDataContext context2 =
                                    new DataClassesDataContext(Config.GetConnectionString()))
                            {
                                //if (elamiuesReplyJft.typeela.Contains("Jadei"))
                                //{
                                //    replyToElamiyeJadei = (from i in context2.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                //                           join j in context2.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis
                                //                               on i.ReplyToElamiyeId equals j.Id
                                //                           where i.Id == elamiuesReplyJft.ERTEID
                                //                           select j).Single();
                                //}
                                //if (elamiuesReplyJft.typeela.Contains("Daryayi"))
                                //{
                                //    replyToElamiyeJadei = (from i in context2.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                //                           join j in context2.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis
                                //                               on i.ReplyToElamiyeId equals j.Id
                                //                           where i.Id == elamiuesReplyJft.ERTEID
                                //                           select j).Single();
                                //}


                                MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiye = (
                                    from i in context2.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                    where i.Id == elamiuesReplyJft.ERTEID
                                    select i).Single();

                                if (
                                    !context.MyDnn_EHaml_NazarSanji_SahebBeKhadamats.Any(
                                        i =>
                                            i.ERTEID == elamiuesReplyJft.ERTEID)
                                    )
                                {
                                    if (
                                        (DateTime.Parse(elamiuesReplyJft.zaman).AddDays(3)
                                            .AddDays(_util.GetTedadeRoozBadAzEtmamJahateNemayesheNazarSanji())).Date <=
                                        DateTime.Now)
                                    {
                                        elamiuesReplyJft.NazarSanji = "Yes";
                                    }
                                    else
                                    {
                                        elamiuesReplyJft.NazarSanji = "No";
                                    }
                                }
                                else
                                {
                                    elamiuesReplyJft.NazarSanji = "SherkatKarde";
                                }
                            }
                        }
                    }
                }
            }
            return myElamiyesReplies;
        }

        [HttpGet]
        public HttpResponseMessage GetElamiyeList()
        {
            string elamiyeTypeForList = this.ActiveModule.TabModuleSettings["ElamiyeTypeForList"].ToString();

            List<ElamiyeListItemDTO> elamiyeList = new List<ElamiyeListItemDTO>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                if (elamiyeTypeForList == "KhaliJadei")
                {
                    elamiyeList = (
                        from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                        where i.ElamiyeType == "KhaliJadei" && i.ServentUserId == null &&
                              (!(from v in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                  join x in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis on v.ReplyToElamiyeId equals
                                      x.Id
                                  where
                                      v.ElamiyeId == i.Id && x.MyDnn_EHaml_User_Id ==
                                      _util.GetUserEHamlUserIdByPortalId(this.UserInfo.UserID) &&
                                      v.Status > 0
                                  select i
                                  ).Any())
                        select new ElamiyeListItemDTO()
                        {
                            Id = i.Id,
                            Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Quality).SingleOrDefault(),
                            Power = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Power).SingleOrDefault(),
                            //DisplayName ="***",
                            //UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            //    (int) j.PortalUserId).DisplayName,
                            ElamiyeType = i.ElamiyeType,
                            CreateDate = i.CreateDate.Value.ToShortDateString(),
                            ExpireDate = i.ExpireDate.ToShortDateString(),
                            NoVaTedadeVasileyeHaml = i.VasileyeHamleAmadeyeBargiri,
                            //Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                            NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == true
                                select g).Count()).ToString(),
                            NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == false
                                select g).Count()).ToString(),
                            StartingPoint =
                                i.Mabda,
                            Magsad = "نامشخص",
                            VasileyeHaml =
                                i.VasileyeHamleAmadeyeBargiri,
                            Tedad = i.Tedad.ToString(),
                            ZamaneAmadegi = i.ZamaneAmadegi.ToShortDateString(),
                        }).ToList();
                }
                else if (elamiyeTypeForList == "KhaliDaryayi")
                {
                    elamiyeList = (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                        where i.ElamiyeType == "KhaliDaryayi" && i.ServentUserId == null &&
                              (!(from v in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                  join x in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis on v.ReplyToElamiyeId
                                      equals
                                      x.Id
                                  where
                                      v.ElamiyeId == i.Id && x.MyDnn_EHaml_User_Id ==
                                      _util.GetUserEHamlUserIdByPortalId(this.UserInfo.UserID) &&
                                      v.Status > 0
                                  select i
                                  ).Any())
                        select new ElamiyeListItemDTO()
                        {
                            Id = i.Id,
                            Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Quality).SingleOrDefault(),
                            Power = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Power).SingleOrDefault(),
                            //DisplayName ="***",
                            //UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            //    (int) j.PortalUserId).DisplayName,
                            ElamiyeType = i.ElamiyeType,
                            CreateDate = i.CreateDate.Value.ToShortDateString(),
                            ExpireDate = i.ExpireDate.ToShortDateString(),
                            NoVaTedadeVasileyeHaml = i.ContinerHayeAmadeyeBargiri,
                            //Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                            NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == true
                                select g).Count()).ToString(),
                            NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == false
                                select g).Count()).ToString(),
                            StartingPoint =
                                i.Mabda,
                            Magsad = i.Magsad ?? "نامشخص",
                            VasileyeHaml =
                                i.ContinerHayeAmadeyeBargiri,
                            Tedad =
                                i.Tedad.ToString(),
                            ZamaneAmadegi = i.ZamaneAmadegi.ToShortDateString()
                        }).ToList();
                }
                else if (elamiyeTypeForList == "KhaliReyli")
                {
                    elamiyeList = (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                        where i.ElamiyeType == "KhaliReyli" && i.ServentUserId == null &&
                              (!(from v in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                                  join x in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis on v.ReplyToElamiyeId equals
                                      x.Id
                                  where
                                      v.ElamiyeId == i.Id && x.MyDnn_EHaml_User_Id ==
                                      _util.GetUserEHamlUserIdByPortalId(this.UserInfo.UserID) &&
                                      v.Status > 0
                                  select i
                                  ).Any())
                        select new ElamiyeListItemDTO()
                        {
                            Id = i.Id,
                            Rank = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Quality).SingleOrDefault(),
                            Power = (from i2 in context.MyDnn_EHaml_UserRanks
                                where i2.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                select i2.Power).SingleOrDefault(),
                            //DisplayName ="***",
                            //UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                            //    (int) j.PortalUserId).DisplayName,
                            ElamiyeType = i.ElamiyeType,
                            CreateDate = i.CreateDate.Value.ToShortDateString(),
                            ExpireDate = i.ExpireDate.ToShortDateString(),
                            NoVaTedadeVasileyeHaml = i.VagoneHamleAmadeyeBargiri,
                            //Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                            NazareKoliyeKhoob = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == true
                                select g).Count()).ToString(),
                            NazareKoliyeBad = ((from g in context.MyDnn_EHaml_NazarSanji_KhadamatBeSahebs
                                join h in context.MyDnn_EHaml_Elamiye_KhaliJadeis on g.ERTEID equals h.Id
                                where h.MyDnn_EHaml_User_Id == i.MyDnn_EHaml_User_Id
                                      && g.NazareKoli == false
                                select g).Count()).ToString(),
                            StartingPoint =
                                i.Mabda,
                            Magsad = i.Magsad ?? "نامشخص",
                            VasileyeHaml =
                                i.VagoneHamleAmadeyeBargiri,
                            Tedad =
                                i.Tedad.ToString(),
                            ZamaneAmadegi = i.ZamaneAmadegi.ToShortDateString()
                        }).ToList();
                }
                //if (elamiyeTypeForList == "KhaliDaryayi")
                //{
                //    elamiyeList = (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                //        join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                //        where i.ElamiyeType == "KhaliDaryayi" && i.ServentUserId == null
                //        select new ElamiyeListItemDTO()
                //        {
                //            Id = i.Id,
                //            //DisplayName = "***",
                //                //UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                //                //    (int) j.PortalUserId).DisplayName,
                //            ElamiyeType = i.ElamiyeType,
                //            CreateDate = i.CreateDate.Value,
                //            ExpireDate = i.ExpireDate,
                //            NoVaTedadeVasileyeHaml = i.ContinerHayeAmadeyeBargiri,
                //            //Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                //        }).ToList();
                //}
            }

            return Request.CreateResponse(HttpStatusCode.OK, elamiyeList);
        }

        [HttpGet]
        public HttpResponseMessage BaPishnahadMovafegamPasEmalKonElamiye(int erteId)
        {
            using (
                DataClassesDataContext context =
                    new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiyes =
                    (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                        where i.Id == erteId
                        select i).Single();
                if (elamiyeReplyToElamiyes.ElamiyeType == "KhaliJadei")
                {
                    MyDnn_EHaml_ReplyToElamiye_KhaliJadei replyToElamiyeKhaliJadei =
                        (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis on i.ReplyToElamiyeId equals
                                j.Id
                            where i.Id == elamiyeReplyToElamiyes.Id
                            select j).Single();

                    elamiyeReplyToElamiyes.Status = 1;

                    context.SubmitChanges();

                    var elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                        where i.Id == elamiyeReplyToElamiyes.ElamiyeId
                        select i).Single();


                    elamiye.ServentUserId = replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id;
                    elamiye.AcceptedDate = DateTime.Now;
                    context.SubmitChanges();

                    UserInfo user = UserController.GetCurrentUserInfo();

                    _util.TanzimeBedehkariyeUser(user.UserID, elamiye.AcceptedDate);

                    long mablag = (long) MakeKhadamatresanBedehkarElamiye(elamiyeReplyToElamiyes,
                        (int) user.UserID, (_util.GetDarsadElamiye()), _util.getUserTakhfif(user.UserID), 0);

                    //string content = _util.ContentForEtelaresaniTaeedReply(context, irti.ToString(), mablag);

                    //_util.EtelaresaniForTaeedReply(irti, content);
                }
                if (elamiyeReplyToElamiyes.ElamiyeType == "KhaliDaryayi")
                {
                    MyDnn_EHaml_ReplyToElamiye_KhaliDaryayi replyToElamiyeKhaliJadei =
                        (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis on i.ReplyToElamiyeId equals
                                j.Id
                            where i.Id == elamiyeReplyToElamiyes.Id
                            select j).Single();

                    elamiyeReplyToElamiyes.Status = 1;

                    context.SubmitChanges();

                    var elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                        where i.Id == elamiyeReplyToElamiyes.ElamiyeId
                        select i).Single();


                    elamiye.ServentUserId = replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id;
                    elamiye.AcceptedDate = DateTime.Now;
                    context.SubmitChanges();

                    UserInfo user = UserController.GetCurrentUserInfo();

                    _util.TanzimeBedehkariyeUser(user.UserID, elamiye.AcceptedDate);

                    long mablag = (long) MakeKhadamatresanBedehkarElamiye(elamiyeReplyToElamiyes,
                        (int) user.UserID, (_util.GetDarsadElamiye()), _util.getUserTakhfif(user.UserID), 0);

                    //string content = _util.ContentForEtelaresaniTaeedReply(context, irti.ToString(), mablag);

                    //_util.EtelaresaniForTaeedReply(irti, content);
                }
                if (elamiyeReplyToElamiyes.ElamiyeType == "KhaliReyli")
                {
                    MyDnn_EHaml_ReplyToElamiye_KhaliReyli replyToElamiyeKhaliJadei =
                        (from i in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes
                            join j in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis on i.ReplyToElamiyeId equals
                                j.Id
                            where i.Id == elamiyeReplyToElamiyes.Id
                            select j).Single();

                    elamiyeReplyToElamiyes.Status = 1;

                    context.SubmitChanges();

                    var elamiye = (from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                        where i.Id == elamiyeReplyToElamiyes.ElamiyeId
                        select i).Single();


                    elamiye.ServentUserId = replyToElamiyeKhaliJadei.MyDnn_EHaml_User_Id;
                    elamiye.AcceptedDate = DateTime.Now;
                    context.SubmitChanges();

                    UserInfo user = UserController.GetCurrentUserInfo();

                    _util.TanzimeBedehkariyeUser(user.UserID, elamiye.AcceptedDate);

                    long mablag = (long) MakeKhadamatresanBedehkarElamiye(elamiyeReplyToElamiyes,
                        (int) user.UserID, (_util.GetDarsadElamiye()), _util.getUserTakhfif(user.UserID), 0);

                    //string content = _util.ContentForEtelaresaniTaeedReply(context, irti.ToString(), mablag);

                    //_util.EtelaresaniForTaeedReply(irti, content);
                }


                return Request.CreateResponse(HttpStatusCode.OK, 1);
            }
        }

        private long MakeKhadamatresanBedehkarElamiye(
            MyDnn_EHaml_Elamiye_ReplyToElamiye elamiyeReplyToElamiyes,
            int userId, int mablageBedehkari, int getUserTakhfif, byte type)
        {
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString()))
            {
                MyDnn_EHaml_BankTransactionDetail detail =
                    new MyDnn_EHaml_BankTransactionDetail();

                detail.ElamiyeReplyToElamiye_Id = elamiyeReplyToElamiyes.Id;
                detail.Khadamatresan_EHaml_User_Id = userId;
                detail.Status = 3;

                context.MyDnn_EHaml_BankTransactionDetails.InsertOnSubmit(detail);
                context.SubmitChanges();

                MyDnn_EHaml__Bank bank = new MyDnn_EHaml__Bank();

                if (type > 0)
                {
                    bank.Type = 1;
                }
                else
                {
                    bank.Type = 0;
                }
                if (getUserTakhfif > 0)
                {
                    bank.Amount = mablageBedehkari*(getUserTakhfif);
                }
                else
                {
                    bank.Amount = mablageBedehkari;
                }


                bank.EHaml_User_Id = userId;
                bank.Description = "بابت انجام کار به عنوان خدمت رسان";
                bank.MyDnn_EHaml_BankTransactionDetail_Id = detail.Id;
                bank.Date = DateTime.Now.Date;
                context.MyDnn_EHaml__Banks.InsertOnSubmit(bank);

                context.SubmitChanges();


                return (long) bank.Amount;
            }
        }

        [HttpGet]
        public HttpResponseMessage MyElamiyesListSuc(int UserId)
        {
            int ehamlUserIdAsli = _util.GetUserEHamlUserIdByPortalId(UserId);

            List<ElamiyeListItemJftGeneralSuc> inquiryList = new List<ElamiyeListItemJftGeneralSuc>();
            using (
                DataClassesDataContext context = new DataClassesDataContext(Config.GetConnectionString())
                )
            {
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliJadeis
                    join k in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes on i.Id equals k.ElamiyeId
                    join b in context.MyDnn_EHaml_ReplyToElamiye_KhaliJadeis on k.ReplyToElamiyeId equals b.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where j.Id == ehamlUserIdAsli && k.Status == 1
                    select new ElamiyeListItemJftGeneralSuc()
                    {
                        ERTEID = k.Id,
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        StartingPoint =
                            i.Mabda,
                        Destination =
                            b.Magsad,
                        JoziyateAsli =
                            GetJoziyatePishnahadDaryayi(i.Tedad, i.VasileyeHamleAmadeyeBargiri, i.ZamaneAmadegi,
                                "دستگاه"),
                        JoziyatePishnahad =
                            GetJoziyatePishnahadDaryayi(b.Tedad, b.VasileyeHamleMoredeNiyaz, b.ZamaneMoredeNiyaz.Value,
                                "دستگاه"),
                        Masir =
                            (b.Mabda + "," + b.Magsad).Replace(",", "<span class='flash'></span>"),
                        JoziyatLink = "",
                        NameSahebBar = _util.GetNameKhadamatResan((int) b.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) b.MyDnn_EHaml_User_Id),
                        Rank = _util.GetUserRank((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        //NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamatElamiye(k.Id),
                        NazarSanjiVaziyat = 1,
                        //eId = i.Id,
                        //erteId = k.Id,

                        ////JoziyatLink = _util.CreateJoziyateEstelamLink(i.Id, "Zadghan"),
                        //irti = b.Id,
                        //rId = f.Id,
                        //KhadamatresanId = f.MyDnn_EHaml_User_Id,
                        //TedadePasokhha = (from c in context.MyDnn_EHaml_Inquiry_ReplyToInquiries
                        //                  join x in context.MyDnn_EHaml_ReplyToInquiries on c.ReplyToInquiryId equals x.Id
                        //                  where c.InquiryId == i.Id && i.InquiryType == "Zadghan"
                        //                  select c).Count(),
                        //NazareKoliyeKhoob =
                        //    _util.GetNazareKoliKhoobSahebBeKhadamat((int)f.MyDnn_EHaml_User_Id).ToString(),
                        //NazareKoliyeBad = _util.GetNazareKoliBadSahebBeKhadamat((int)f.MyDnn_EHaml_User_Id).ToString(),
                        //Khatarnak = i.LoadType.Contains("IMDG"),
                        //Rank = _util.GetUserRank((int)f.MyDnn_EHaml_User_Id),
                        //Power = _util.GetUserPower((int)f.MyDnn_EHaml_User_Id),
                        //Status = _util.GetUserStatus(j.PortalUserId, 1),
                        //DisplayName =
                        //    UserController.GetUserById(PortalController.GetCurrentPortalSettings().PortalId,
                        //        (int)j.PortalUserId).DisplayName,
                        //InquiryType = i.InquiryType,
                        //CreateDate = i.CreateDate.Value.ToShortDateString(),
                        //ExpireDate = i.ExpireDate.Value.ToShortDateString(),
                        //IsTender = i.IsTender,
                        //StartingPoint = i.StartingPoint,
                        //Destination = i.Destination,
                        //ActionDate = i.ActionDate.Value.ToShortDateString(),
                        //IsReallyNeed = i.IsReallyNeed,
                        //LoadType = i.LoadType,
                        //EmptyingCharges = k.EmptyingCharges,
                        //NoVaTedadeVasileyeHaml = k.NoVaTedadeVasileyeHaml,
                        //WithInsurance = k.WithInsurance,
                        //FileArzesheBar = string.Format("<A HREF=\"{0}\">فایل</A>", k.FileArzesheBar),
                        //Company = this.UserInfo.Profile.GetPropertyValue("Company"),
                        //VazneKol = "",
                        //NameKhedmatresan = _util.GetNameKhadamatResan((int)f.MyDnn_EHaml_User_Id),
                    }));
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliDaryayis
                    join k in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes on i.Id equals k.ElamiyeId
                    join b in context.MyDnn_EHaml_ReplyToElamiye_KhaliDaryayis on k.ReplyToElamiyeId equals b.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where j.Id == ehamlUserIdAsli && k.Status == 1
                    select new ElamiyeListItemJftGeneralSuc()
                    {
                        ERTEID = k.Id,
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        StartingPoint =
                            b.Mabda,
                        Destination = b.Magsad,
                        JoziyateAsli =
                            GetJoziyatePishnahadDaryayi(i.Tedad, i.ContinerHayeAmadeyeBargiri,
                                i.ZamaneAmadegi, "کانتینر"),
                        //JoziyatePishnahad = b.Tedad + " دستگاه " + b.VasileyeHamleMoredeNiyaz + " در تاریخ " + b.ZamaneMoredeNiyaz.Value.ToShortDateString(),
                        JoziyatePishnahad =
                            GetJoziyatePishnahadDaryayi(b.Tedad, b.VasileyeHamleMoredeNiyaz,
                                b.ZamaneMoredeNiyaz.Value, "کانتینر"),
                        Masir = (b.Mabda + "," + b.Magsad).Replace(",", "<span class='flash'></span>"),
                        JoziyatLink = "",
                        NameSahebBar = _util.GetNameKhadamatResan((int) b.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) b.MyDnn_EHaml_User_Id),
                        Rank = _util.GetUserRank((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        //NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamatElamiye(k.Id),
                        NazarSanjiVaziyat = 1,
                    }));
                inquiryList.AddRange((from i in context.MyDnn_EHaml_Elamiye_KhaliReylis
                    join k in context.MyDnn_EHaml_Elamiye_ReplyToElamiyes on i.Id equals k.ElamiyeId
                    join b in context.MyDnn_EHaml_ReplyToElamiye_KhaliReylis on k.ReplyToElamiyeId equals b.Id
                    join j in context.MyDnn_EHaml_Users on i.MyDnn_EHaml_User_Id equals j.Id
                    where j.Id == ehamlUserIdAsli && k.Status == 1
                    select new ElamiyeListItemJftGeneralSuc()
                    {
                        ERTEID = k.Id,
                        Id = i.Id,
                        CreateDate = i.CreateDate.Value.ToShortDateString(),
                        StartingPoint =
                            b.Mabda,
                        Destination = b.Magsad,
                        JoziyateAsli =
                            GetJoziyatePishnahadDaryayi(i.Tedad, i.VagoneHamleAmadeyeBargiri,
                                i.ZamaneAmadegi, "واگن"),
                        //JoziyatePishnahad = b.Tedad + " دستگاه " + b.VasileyeHamleMoredeNiyaz + " در تاریخ " + b.ZamaneMoredeNiyaz.Value.ToShortDateString(),
                        JoziyatePishnahad =
                            GetJoziyatePishnahadDaryayi(b.Tedad, b.VasileyeHamleMoredeNiyaz,
                                b.ZamaneMoredeNiyaz.Value, "واگن"),
                        Masir = (b.Mabda + "," + b.Magsad).Replace(",", "<span class='flash'></span>"),
                        JoziyatLink = "",
                        NameSahebBar = _util.GetNameKhadamatResan((int) b.MyDnn_EHaml_User_Id),
                        Power = _util.GetUserPower((int) b.MyDnn_EHaml_User_Id),
                        Rank = _util.GetUserRank((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliKhoob = _util.GetNazareKoliKhoobKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        NazareKoliBad = _util.GetNazareKoliBadKhadamatBeSaheb((int) b.MyDnn_EHaml_User_Id),
                        //NazarSanjiVaziyat = _util.GetVaziyateNazarSanjiSahebBeKhadamatElamiye(k.Id),
                        NazarSanjiVaziyat = 1,
                    }));

                return Request.CreateResponse(HttpStatusCode.OK, inquiryList);
            }
        }

        private string GetJoziyatePishnahadDaryayi(int? tedad, string vasileyeHamleMoredeNiyaz, DateTime date,
            string text)
        {
            string result = string.Format("{0} {1} {2} در تاریخ {3}", tedad, text, vasileyeHamleMoredeNiyaz,
                Util.ConvertToPersian(date));

            return result;
        }

        public class ElamiyeListItemJftGeneralSuc
        {
            public
                int Id { get; set; }

            public
                string StartingPoint { get; set; }

            public
                string Destination { get; set; }

            public
                string JoziyatLink { get; set; }

            public
                string CreateDate { get; set; }

            public
                string NameSahebBar { get; set; }

            public
                int ERTEID { get; set; }

            public
                int Power { get; set; }

            public
                double Rank { get; set; }

            public
                int NazareKoliKhoob { get; set; }

            public
                int NazareKoliBad { get; set; }

            public
                int NazarSanjiVaziyat { get; set; }

            public
                string JoziyateAsli { get; set; }

            public
                string JoziyatePishnahad { get; set; }

            public
                string Masir { get; set; }
        }
    }

    public class MyElamiyeReplyListItemDTO
    {
        public int Id { get; set; }
        public string DisplayName { get; set; }
        public string VasileyeMoredeNiyaz { get; set; }
        public string EType { get; set; }
    }

    public class ElamiyeListItemDTO
    {
        public int Id { get; set; }
        //public string DisplayName { get; set; }
        public string ElamiyeType { get; set; }
        public string CreateDate { get; set; }
        public string NoVaTedadeVasileyeHaml { get; set; }
        //public string Company { get; set; }
        public string ExpireDate { get; set; }
        public double? Rank { get; set; }
        public int? Power { get; set; }
        public string NazareKoliyeKhoob { get; set; }
        public string NazareKoliyeBad { get; set; }
        public string StartingPoint { get; set; }
        public string VasileyeHaml { get; set; }
        public string Tedad { get; set; }
        public string ZamaneAmadegi { get; set; }
        public string Magsad { get; set; }
        public int Gablan { get; set; }
    }

    public class MyElamiuesReplyJft
    {
        public int elaId { get; set; }
        public int ERTEID { get; set; }
        public string DisplayName { get; set; }
        public byte Status { get; set; }
        public string CreateDate { get; set; }
        public int Power { get; set; }
        public double Rank { get; set; }
        public int NazareKoliKhoob { get; set; }
        public int NazareKoliBad { get; set; }
        public string VaziyatePaziresh { get; set; }
        public string NameKhedmatresan { get; set; }
        public int rtelID { get; set; }
        public string Masir { get; set; }
        public string VasileyeHaml { get; set; }
        public string Tedad { get; set; }
        public string zaman { get; set; }
        public string typeela { get; set; }
        public string NazarSanji { get; set; }
    }
}