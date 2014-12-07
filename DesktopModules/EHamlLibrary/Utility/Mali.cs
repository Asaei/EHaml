using System;

namespace EHamlLibrary.Utility
{
    public class Mali
    {
        Utility _utility =new Utility();
        public void DoSuccessInquiry(EHamlDataClassesDataContext context, string inquiryType, int serventUserId, string vahedePool, int? inquiryId, int replyToInquiryId, string geymateKol, DateTime? acceptDateMiladi, string acceptDateShamsi)
        {
            Asaei_EHaml_Bank bank = new Asaei_EHaml_Bank
            {
                InquiryId = inquiryId,
                ReplyToInquiryId = replyToInquiryId,
                UserId = serventUserId,
                MablagheBedehkari =CalculateMablagheBedehkari(inquiryType,vahedePool,serventUserId,acceptDateMiladi, Convert.ToDecimal(geymateKol)),
                CreateDateMiladi = DateTime.Now,
                CreateDateShamsi = _utility.ConvertToPersian(DateTime.Now)
                ,TasfiyeShode = "خیر",
                Vaziyat = "ثبت اولیه"
            };

            context.Asaei_EHaml_Banks.InsertOnSubmit(bank);
            context.SubmitChanges();
        }

        private decimal? CalculateMablagheBedehkari(string inquiryType, string vahedePool, int serventUserId, DateTime? acceptDateMiladi, decimal geymateKol)
        {
            return geymateKol*(decimal) .03;
        }
    }
}