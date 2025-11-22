<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Top bar: Heading + Go Back Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="m-0">Login</h2>
        <asp:Button ID="btnGoback" runat="server" Text="Go Back"
            PostBackUrl="~/GoingBack.aspx"
            CssClass="btn btn-danger"
            CausesValidation="False" />
    </div>

    <!-- Centered login form -->
    <div class="card p-4 shadow-sm" style="max-width:400px; margin:auto;">
        <div class="mb-3">
            <asp:Label Text="Username:" runat="server" AssociatedControlID="txtUsername" />
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtUsername"
                ErrorMessage="Username required!"
                ForeColor="Red"
                Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="mb-3">
            <asp:Label Text="Password:" runat="server" AssociatedControlID="txtPassword" />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password required!"
                ForeColor="Red"
                Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="text-center">
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
        </div>

        <div class="text-center mt-2">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>

</asp:Content>
