<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="m-0">Sign Up</h2>
        <asp:Button ID="btnGoback" runat="server" Text="Go Back"
            PostBackUrl="~/GoingBack.aspx"
            CssClass="btn btn-danger"
            CausesValidation="False" />
    </div>

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
            <asp:Label Text="Email:" runat="server" AssociatedControlID="txtEmail" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email required!"
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
            <asp:Button ID="btnSignup" runat="server" Text="Register"
                CssClass="btn btn-primary w-100"
                OnClick="btnSignup_Click" />
        </div>

        <div class="text-center mt-2">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>

</asp:Content>
