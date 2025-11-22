<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-center align-items-center" style="height: 80vh;">
        <div class="card p-5 shadow-lg text-center" style="max-width: 600px; width: 100%;">
            <h1 class="mb-3 text-primary fw-bold">Complaint Management System</h1>
            <p class="lead mb-4 text-secondary">Welcome! Please log in or sign up to continue.</p>

            <div class="d-flex justify-content-center gap-3">
                <asp:Button ID="btnLogin" runat="server"
                    Text="Login"
                    CssClass="btn btn-primary btn-lg px-4"
                    OnClick="btnLogin_Click" />

                <asp:Button ID="btnSignup" runat="server"
                    Text="Faculty Signup"
                    CssClass="btn btn-success btn-lg px-4"
                    OnClick="btnSignup_Click" />
            </div>
        </div>
    </div>
</asp:Content>

