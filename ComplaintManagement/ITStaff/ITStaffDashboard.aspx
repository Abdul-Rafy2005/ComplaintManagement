<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ITStaffDashboard.aspx.cs" Inherits="ITStaffDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="m-0">IT Staff Dashboard</h2>
        <asp:Button ID="btnLogout" runat="server" Text="Logout"
            PostBackUrl="~/Logout.aspx"
            CssClass="btn btn-danger" />
    </div>

    <p class="fw-semibold mb-4">
        <asp:Label ID="lblWelcome" runat="server" Font-Size="Medium"></asp:Label>
    </p>

    <div class="card p-4 shadow-sm">
        <h4 class="mb-3">Assigned Complaints</h4>

        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-bordered table-striped align-middle"
            AutoGenerateColumns="False"
            DataKeyNames="ComplaintID"
            OnRowEditing="GridView1_RowEditing"
            OnRowUpdating="GridView1_RowUpdating"
            OnRowCancelingEdit="GridView1_RowCancelingEdit">

            <Columns>
                <asp:BoundField DataField="ComplaintID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="Status" HeaderText="Current Status" />

                <asp:TemplateField HeaderText="Remarks">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtRemarks" runat="server"
                            Text='<%# Bind("Remarks") %>'
                            CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblRemarks" runat="server"
                            Text='<%# Eval("Remarks") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Update Status">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem>Pending</asp:ListItem>
                            <asp:ListItem>In Progress</asp:ListItem>
                            <asp:ListItem>Resolved</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# Eval("Status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" />
            </Columns>

        </asp:GridView>
    </div>

</asp:Content>
