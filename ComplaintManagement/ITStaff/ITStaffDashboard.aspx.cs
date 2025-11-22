using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;


public partial class ITStaffDashboard : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["ComplaintDBConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null || Session["Role"].ToString() != "ITStaff")
        {
            Response.Redirect("~/Auth/Login.aspx");
        }

        if (!IsPostBack)
        {
            lblWelcome.Text = "Logged in as: " + Session["Username"].ToString();
            LoadAssignedComplaints();
        }
    }

    private void LoadAssignedComplaints()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT c.ComplaintID, c.Title, c.Description, c.Status, c.Remarks
                FROM Complaints c
                INNER JOIN Users u ON c.AssignedTo = u.UserID
                WHERE u.Username = @Username
                ORDER BY c.ComplaintID DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        LoadAssignedComplaints();

        DropDownList ddlStatus = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlStatus");
        Label lblStatus = (Label)GridView1.Rows[e.NewEditIndex].FindControl("lblStatus");

        if (ddlStatus != null && lblStatus != null)
            ddlStatus.SelectedValue = lblStatus.Text;
    }

    protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        LoadAssignedComplaints();
    }

    protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
    {
        int complaintID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
        DropDownList ddlStatus = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlStatus");
        TextBox txtRemarks = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtRemarks");

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Complaints SET Status=@Status, Remarks=@Remarks WHERE ComplaintID=@ComplaintID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
            cmd.Parameters.AddWithValue("@ComplaintID", complaintID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        GridView1.EditIndex = -1;
        LoadAssignedComplaints();
    }
}
