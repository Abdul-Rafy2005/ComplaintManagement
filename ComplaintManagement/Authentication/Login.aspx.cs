using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["ComplaintDBConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT Role FROM Users WHERE Username=@Username AND Password=@Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            conn.Open();

            var role = cmd.ExecuteScalar();

            if (role != null)
            {
                Session["Username"] = txtUsername.Text.Trim();
                Session["Role"] = role.ToString();

                if (role.ToString() == "Admin")
                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                else if (role.ToString() == "Faculty")
                    Response.Redirect("~/Faculty/FacultyDashboard.aspx");
                else if (role.ToString() == "ITStaff")
                    Response.Redirect("~/ITStaff/ITStaffDashboard.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid username or password!";
            }
        }
    }
}
