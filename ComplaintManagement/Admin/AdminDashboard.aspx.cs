using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;


public partial class AdminDashboard : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["ComplaintDBConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("~/Auth/Login.aspx");
        }

        if (!IsPostBack)
        {
            lblWelcome.Text = "Logged in as: " + Session["Username"].ToString();
            LoadComplaints();
        }
    }

    private void LoadComplaints()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT c.ComplaintID, c.Title, c.Description, c.Status, c.DateSubmitted, 
                       f.Username AS FacultyName, 
                       s.Username AS AssignedToName
                FROM Complaints c
                INNER JOIN Users f ON c.UserID = f.UserID
                LEFT JOIN Users s ON c.AssignedTo = s.UserID
                ORDER BY c.ComplaintID DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        LoadComplaints();

        // Populate IT Staff dropdown
        DropDownList ddlStaff = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlStaff");
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT UserID, Username FROM Users WHERE Role='ITStaff'";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            ddlStaff.DataSource = reader;
            ddlStaff.DataTextField = "Username";
            ddlStaff.DataValueField = "UserID";
            ddlStaff.DataBind();
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        LoadComplaints();
    }

    protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
    {
        int complaintID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
        DropDownList ddlStaff = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlStaff");

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Complaints SET AssignedTo=@AssignedTo, Status='In Progress' WHERE ComplaintID=@ComplaintID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AssignedTo", ddlStaff.SelectedValue);
            cmd.Parameters.AddWithValue("@ComplaintID", complaintID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        GridView1.EditIndex = -1;
        LoadComplaints();
    }

    protected void btnAddStaff_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Users (Username, Password, Role, Email) VALUES (@Username, @Password, 'ITStaff', @Email)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", txtStaffUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtStaffPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtStaffEmail.Text.Trim());
            conn.Open();
            cmd.ExecuteNonQuery();
            lblStaffMsg.Text = "IT Staff added successfully!";
        }
    }


}