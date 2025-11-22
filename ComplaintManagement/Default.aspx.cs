using System;

public partial class Default : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Authentication/Login.aspx");
    }

    protected void btnSignup_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Authentication/Signup.aspx");
    }
}
