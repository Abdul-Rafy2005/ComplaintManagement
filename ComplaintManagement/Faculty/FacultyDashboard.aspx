<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FacultyDashboard.aspx.cs" Inherits="FacultyDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="m-0">Faculty Dashboard</h2>
        <asp:Button ID="btnLogout" runat="server" Text="Logout"
            PostBackUrl="~/Logout.aspx"
            CssClass="btn btn-danger" />
    </div>

    <p class="fw-semibold">
        <asp:Label ID="lblWelcome" runat="server" Font-Size="Medium"></asp:Label>
    </p>

    <div class="card p-4 shadow-sm mb-5" style="max-width:600px;">
        <h4 class="mb-3">Submit a Complaint</h4>

        <div class="mb-3">
            <asp:Label Text="Title:" runat="server" AssociatedControlID="txtTitle" />
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label Text="Description:" runat="server" AssociatedControlID="txtDescription" />
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
        </div>

        <div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Complaint"
                CssClass="btn btn-primary w-100"
                OnClick="btnSubmit_Click" />
        </div>

        <div class="text-center mt-2">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </div>

    
    <div class="card p-4 shadow-sm">
        <h4 class="mb-3">Your Complaints</h4>
        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-bordered table-striped"
            AutoGenerateColumns="True">
        </asp:GridView>
    </div>

</asp:Content>
