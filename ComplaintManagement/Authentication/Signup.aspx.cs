using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Signup : System.Web.UI.Page
{
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["ComplaintDBConnection"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string checkUser = "SELECT COUNT(*) FROM Users WHERE Username=@Username";
            SqlCommand cmdCheck = new SqlCommand(checkUser, conn);
            cmdCheck.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            conn.Open();
            int count = (int)cmdCheck.ExecuteScalar();

            if (count > 0)
            {
                lblMsg.Text = "Username already exists!";
                return;
            }

            string query = "INSERT INTO Users (Username, Password, Role, Email) VALUES (@Username, @Password, @Role, @Email)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Role", "Faculty"); // Signup only for Faculty
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.ExecuteNonQuery();

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Registration successful! You can now login.";
        }
    }
}
