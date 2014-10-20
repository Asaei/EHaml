using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Profile;
using DotNetNuke.Entities.Users;
using DotNetNuke.Modules.Dashboard.Components.Host;
using DotNetNuke.Security.Membership;
using DotNetNuke.Security.Roles;
using DotNetNuke.UI.UserControls;
using DotNetNuke.Web.UI.WebControls;
using DotNetNuke.Web.UI.WebControls.Extensions;
using Telerik.Web.UI;

namespace MyDnn_EHaml.MyDnn_Ehaml_Register
{
    public partial class Register : PortalModuleBase
    {
        #region†Methods†(17)†

        //†Protected†Methods†(2)†

        protected void Page_Init(object sender, EventArgs e)
        {
            lnkRegister.Click += lnkRegister_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["A"] == "True")
            {
                pnlKoli.Visible = false;
                pnlAfterRegister.Visible = true;
            }
            else
            {
                if (!Page.IsPostBack)
                {
                    FillPageControlls();
                }

            }
        }

        //†Private†Methods†(15)†

        private void AssignToCarrierBooroonMarzi(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            foreach (RadComboBoxItem carrierBooroonMarziType in cbolCarrierBooroonMarzi.Items)
            {
                if (carrierBooroonMarziType.Checked)
                {
                    RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, carrierBooroonMarziType.Value);
                    roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                        DateTime.Now.AddYears(100));
                }
            }
        }

        private void AssignToCarrierDakheli(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            foreach (RadComboBoxItem carrierDakhelyType in cbolCarrierDakhely.Items)
            {
                if (carrierDakhelyType.Checked)
                {
                    RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, carrierDakhelyType.Value);
                    roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                        DateTime.Now.AddYears(100));
                }
            }
        }

        private void AssignToForwarderRole(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            foreach (RadComboBoxItem forwarderType in cbolForwarder.Items)
            {
                if (forwarderType.Checked)
                {
                    RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, forwarderType.Value);
                    roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                        DateTime.Now.AddYears(100));
                }
            }
        }

        private void AssignToTakhliyeVaBargiri(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            foreach (RadComboBoxItem takhliyeVaBargiriType in cbolTakhliyeVaBargiry.Items)
            {
                if (takhliyeVaBargiriType.Checked)
                {
                    RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, takhliyeVaBargiriType.Value);
                    roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                        DateTime.Now.AddYears(100));
                }
            }
        }

        private void AssignToTarkhis(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();

            if (chkTarkhis.Checked)
            {
                RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, "Tarkhis");
                roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID, DateTime.Now.AddYears(100));
            }
        }

        private string CreateActivityFeild(string userType)
        {
            string activityFeildResult = string.Empty;

            if (userType == "A")
            {
                foreach (RadComboBoxItem forwarderType in cbolForwarder.Items)
                {
                    if (forwarderType.Checked)
                    {
                        activityFeildResult += (string.Format("{0}, ", forwarderType.Value));
                    }
                }


                foreach (RadComboBoxItem carrierDakhelyType in cbolCarrierDakhely.Items)
                {
                    if (carrierDakhelyType.Checked)
                    {
                        activityFeildResult += (string.Format("{0}, ", carrierDakhelyType.Value));
                    }
                }

                foreach (RadComboBoxItem carrierBooroonMarziType in cbolCarrierBooroonMarzi.Items)
                {
                    if (carrierBooroonMarziType.Checked)
                    {
                        activityFeildResult += (string.Format("{0}, ", carrierBooroonMarziType.Value));
                    }
                }

                foreach (RadComboBoxItem takhliyeVaBargiriType in cbolTakhliyeVaBargiry.Items)
                {
                    if (takhliyeVaBargiriType.Checked)
                    {
                        activityFeildResult += (string.Format("{0}, ", takhliyeVaBargiriType.Value));
                    }
                }


                if (chkTarkhis.Checked)
                {
                    activityFeildResult += (string.Format("{0}, ", "Tarkhis"));
                }
            }
            //else
            //{
            //    if (
            //        !(!string.IsNullOrEmpty(txtActivityFieldTypelord.Text) &&
            //          !string.IsNullOrWhiteSpace(txtActivityFieldTypelord.Text)))
            //    {
            //        activityFeildResult += (txtActivityFieldTypelord.Text);
            //    }
            //}

            return activityFeildResult;
        }

        private void FillCbolCarrierBooroonMarzi()
        {

            cbolCarrierBooroonMarzi.Items.Add(new DnnComboBoxItem("Ã«œÂ «Ì", "CarrierBooroonMarziyeJadei"));
            cbolCarrierBooroonMarzi.Items.Add(new DnnComboBoxItem("—Ì·Ì", "CarrierBooroonMarziyeReyli"));
            cbolCarrierBooroonMarzi.Items.Add(new DnnComboBoxItem("œ—Ì«ÌÌ", "CarrierBooroonMarziyeDaryayi"));


        }

        private void FillCbolCarrierDakhely()
        {

            cbolCarrierDakhely.Items.Add(new DnnComboBoxItem("”»ò", "CarrierDakheliyeSabok"));
            cbolCarrierDakhely.Items.Add(new DnnComboBoxItem("”‰êÌ‰", "CarrierDakheliySangin"));

        }

        private void FillCbolForwarder()
        {

            cbolForwarder.Items.Add(new DnnComboBoxItem("Å—ÊéÂ", "ForwardereProject"));
            cbolForwarder.Items.Add(new DnnComboBoxItem("œ—Ì«ÌÌ", "ForwardereDaryayi"));
            cbolForwarder.Items.Add(new DnnComboBoxItem("ÂÊ«ÌÌ", "ForwardereHavayi"));
            cbolForwarder.Items.Add(new DnnComboBoxItem("—Ì·Ì", "ForwardereReyli"));
            cbolForwarder.Items.Add(new DnnComboBoxItem("Ã«œÂ «Ì", "ForwardereJadei"));


        }

        private void FillCbolHagigiYaHoogoogiType()
        {

            cbolHagigiYaHoogoogiType.Items.Add(new DnnComboBoxItem("ÕﬁÊﬁÌ", "A"));
            cbolHagigiYaHoogoogiType.Items.Add(new DnnComboBoxItem("ÕﬁÌﬁÌ", "B"));

        }

        private void FillCbolTakhliyeVaBargiry()
        {

            cbolTakhliyeVaBargiry.Items.Add(new DnnComboBoxItem("”»ò", "TakhliyeVaBargiriyeSabok"));
            cbolTakhliyeVaBargiry.Items.Add(new DnnComboBoxItem("”‰êÌ‰", "TakhliyeVaBargiriyeSangin"));


        }

        private void FillCbolUserType()
        {

            cbolUserType.Items.Add(new DnnComboBoxItem("’«Õ» »«—", "B"));
            cbolUserType.Items.Add(new DnnComboBoxItem("Œœ„«  —”«‰", "A"));

        }

        private void FillPageControlls()
        {
            FillCbolHagigiYaHoogoogiType();
            FillCbolUserType();
            FillCbolForwarder();
            FillCbolCarrierDakhely();
            FillCbolCarrierBooroonMarzi();
            FillCbolTakhliyeVaBargiry();
        }

        private string GetIPAddress()
        {
            string iPAddress = string.Empty;
            if (HttpContext.Current.Request.UserHostAddress != null)
            {
                iPAddress = HttpContext.Current.Request.UserHostAddress;
            }
            return iPAddress;
        }

        private void lnkRegister_Click(object sender, EventArgs e)
        {
            UserInfo userInfoByUserName = UserController.GetUserByName(txtUserName.Text);
            if (userInfoByUserName != null)
            {
                pnlUserNameTaken.Visible = true;
                return;
            }
            if (!chkTavafog.Checked)
            {
                pnlTavafog.Visible = true;
                return;
            }

            UserInfo userInfo = UserController.GetUserByName(txtEmail.Text);

            if (userInfo == null)
            {
                if (UserController.ValidatePassword(txtPassword.Text))
                {
                    if (txtPassword.Text == txtPasswordConfirm.Text)
                    {
                        userInfo = new UserInfo
                        {
                            DisplayName = txtFirstName.Text + " " + txtLastName.Text,
                            Email = txtEmail.Text,
                            FirstName = txtFirstName.Text,
                            LastName = txtLastName.Text
                        };

                        userInfo.Membership.Approved = true;
                        userInfo.Membership.Password = txtPassword.Text;
                        userInfo.Membership.UpdatePassword = false;
                        userInfo.Username = txtUserName.Text;
                        userInfo.PortalID = PortalId;

                        UserProfile userProfile = userInfo.Profile;
                        ProfilePropertyDefinitionCollection profilePropertyDefinitionCollection =
                            userProfile.ProfileProperties;

                        foreach (
                            ProfilePropertyDefinition profilePropertyDefinition in profilePropertyDefinitionCollection)
                        {
                            switch (profilePropertyDefinition.PropertyName)
                            {
                                case "PostalCode":
                                    profilePropertyDefinition.PropertyValue = txtPostalCode.Text;
                                    break;
                                case "Address":
                                    profilePropertyDefinition.PropertyValue = txtAddress.Text;
                                    break;
                                case "Telephone":
                                    profilePropertyDefinition.PropertyValue = txtPhone.Text;
                                    break;
                                case "Cell":
                                    profilePropertyDefinition.PropertyValue = txtCellPhone.Text;
                                    break;
                            }
                        }

                        string activityFeild = CreateActivityFeild(cbolUserType.SelectedValue);
                        if (cbolUserType.SelectedValue == "A")
                        {
                            if ((string.IsNullOrEmpty(activityFeild) ||
                                 string.IsNullOrWhiteSpace(activityFeild)))
                            {
                                lblActivityFieldTypeServantError.Visible = true;
                                return;
                            }
//                            else
//                            {
//                                if (!string.IsNullOrWhiteSpace(txtActivityFieldTypeServantOther.Text) &&
//                                    !string.IsNullOrEmpty(txtActivityFieldTypeServantOther.Text))
//                                {
//                                    activityFeild += " ||| " + txtActivityFieldTypeServantOther.Text;
//                                }
//                            }
                        }

                        string guid = Guid.NewGuid().ToString();
                        if (UserController.CreateUser(ref userInfo) == UserCreateStatus.Success)
                        {
                            using (var context = new DataClassesDataContext(Config.GetConnectionString()))
                            {
                                var myDnnEHamlUser = new MyDnn_EHaml_User();
                                myDnnEHamlUser.PortalUserId = userInfo.UserID;
                                myDnnEHamlUser.Company = txtCompany.Text;
                                myDnnEHamlUser.PersonalityType = char.Parse(cbolHagigiYaHoogoogiType.SelectedItem.Value);
                                myDnnEHamlUser.Type = char.Parse(cbolUserType.SelectedItem.Value);

                                if (myDnnEHamlUser.Type == char.Parse("A"))
                                {
                                    myDnnEHamlUser.ActivityField += activityFeild;
                                }
                                //else
                                //{
                                //    myDnnEHamlUser.ActivityField = txtActivityFieldTypelord.Text;
                                //}
                                myDnnEHamlUser.IsApprove = false;
                                myDnnEHamlUser.AppCode = guid;
                                context.MyDnn_EHaml_Users.InsertOnSubmit(myDnnEHamlUser);
                                context.SubmitChanges();
                            }

                            if (cbolUserType.SelectedValue == "A")
                            {
                                AssignToKhedmatgozar(userInfo);
                                AssignToForwarderRole(userInfo);
                                AssignToCarrierDakheli(userInfo);
                                AssignToCarrierBooroonMarzi(userInfo);
                                AssignToTakhliyeVaBargiri(userInfo);
                                AssignToTarkhis(userInfo);
                            }
                            else
                            {
                                AssignToSahebBar(userInfo);
                            }

                            Util util = new Util();

                            string link = "http://" + PortalSettings.DefaultPortalAlias.ToLower().Replace("http://", "") +
                                          "/default.aspx?tabid=" + this.TabId +
                                          "&mid=" + ModuleId + "&ctl=Approve&AppCode=" + guid;


                            UserInfo info = UserController.GetUserById(this.PortalId, userInfo.UserID);
                            UserController.UserLogin(this.PortalId, info, PortalSettings.PortalName, GetIPAddress(),
                                true);

                            util.SendAppLinkToUserMail(info.UserID, link);

                            Response.Redirect("/default.aspx?tabid=124&A=True");
                        }
                    }
                }
            }
        }

        private void AssignToSahebBar(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, "SahebBar");
            roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                DateTime.Now.AddYears(100));
        }

        private void AssignToKhedmatgozar(UserInfo userInfo)
        {
            RoleController roleController = new RoleController();
            RoleInfo roleInfo = roleController.GetRoleByName(this.PortalId, "Khedmatgozar");
            roleController.AddUserRole(this.PortalId, userInfo.UserID, roleInfo.RoleID,
                DateTime.Now.AddYears(100));
        }

        #endregion†Methods†
    }
}