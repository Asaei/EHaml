namespace EHamlLibrary.Utility
{
    public class Notification
    {
        public void ReplyToInquiryRaTaeedKardid(string inquiryType, int? inquiryId, int id)
        {
            
        }

        public void ReplyToInquiryShomaTaeedShod(string inquiryType, int? inquiryId, int id)
        {
            
        }

        public void DoSuccessInquiry(string inquiryType, int? inquiryId, int id)
        {
            ReplyToInquiryRaTaeedKardid(inquiryType,inquiryId,id);
            ReplyToInquiryShomaTaeedShod(inquiryType,inquiryId,id);
        }
    }
}