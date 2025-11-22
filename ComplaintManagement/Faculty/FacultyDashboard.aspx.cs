using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class FacultyDashboard : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["ComplaintDBConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"].ToString() != "Faculty")
        {
            Response.Redirect("~/Auth/Login.aspx");
        }

        if (!IsPostBack)
        {
            lblWelcome.Text = "Logged in as: " + Session["Username"].ToString();
            LoadComplaints();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"INSERT INTO Complaints (UserID, Title, Description, Status)
                             SELECT UserID, @Title, @Description, 'Pending' FROM Users WHERE Username=@Username";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());
            cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            lblMsg.Text = "Complaint submitted successfully!";
            txtTitle.Text = "";
            txtDescription.Text = "";
            LoadComplaints();
        }
    }

    private void LoadComplaints()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"SELECT ComplaintID, Title, Description, Status, DateSubmitted 
                             FROM Complaints c
                             INNER JOIN Users u ON c.UserID = u.UserID
                             WHERE u.Username = @Username
                             ORDER BY ComplaintID DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}
