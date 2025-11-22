<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="m-0">Admin Dashboard</h2>
        <asp:Button ID="btnLogout" runat="server" Text="Logout"
            PostBackUrl="~/Logout.aspx"
            CssClass="btn btn-danger" />
    </div>

    <p class="fw-semibold">
        <asp:Label ID="lblWelcome" runat="server" Font-Size="Medium"></asp:Label>
    </p>

    <hr class="mb-4" />

    <div class="card p-3 shadow-sm mb-5">
        <h4 class="mb-3">All Complaints</h4>
        <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-striped"
            AutoGenerateColumns="False" DataKeyNames="ComplaintID"
            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
            OnRowCancelingEdit="GridView1_RowCancelingEdit">
            <Columns>
                <asp:BoundField DataField="ComplaintID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="DateSubmitted" HeaderText="Date" />
                <asp:BoundField DataField="FacultyName" HeaderText="Submitted By" />
                <asp:TemplateField HeaderText="Assign To (IT Staff)">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlStaff" runat="server" CssClass="form-select"></asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblAssigned" runat="server" Text='<%# Eval("AssignedToName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
            </Columns>
        </asp:GridView>
    </div>

 
    <div class="card p-4 shadow-sm" style="max-width:500px;">
        <h4 class="mb-3">Add IT Staff</h4>

        <div class="mb-3">
            <asp:Label Text="Username:" runat="server" AssociatedControlID="txtStaffUsername" />
            <asp:TextBox ID="txtStaffUsername" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label Text="Email:" runat="server" AssociatedControlID="txtStaffEmail" />
            <asp:TextBox ID="txtStaffEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <asp:Label Text="Password:" runat="server" AssociatedControlID="txtStaffPassword" />
            <asp:TextBox ID="txtStaffPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>

        <div>
            <asp:Button ID="btnAddStaff" runat="server" Text="Add IT Staff"
                CssClass="btn btn-primary w-100" OnClick="btnAddStaff_Click" />
        </div>

        <div class="text-center mt-2">
            <asp:Label ID="lblStaffMsg" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </div>

</asp:Content>
