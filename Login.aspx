<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>
    <link rel="stylesheet" href="css/style.css" />
    <link href="Dashboard/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="Dashboard/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="~/Scripts/bootstrap.min.js"></script>
    <style type="text/css">
        body, html {
            height: 100%;
            background-repeat: no-repeat;
            /*background-image: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/
            background-image: url(Images/inven.jpg);
        }

        .card-container.card {
            max-width: 350px;
            padding: 40px 40px;
        }

        .btn {
            font-weight: 700;
            height: 36px;
            -moz-user-select: none;
            -webkit-user-select: none;
            user-select: none;
            cursor: default;
        }

        /*
            * Card component
            */
        .card {
            background-color: #F7F7F7;
            /* just in case there no content*/
            padding: 20px 25px 30px;
            margin: 0 auto 25px;
            margin-top: 10%;
            /* shadows and rounded borders */
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px;
            -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
        }

        .profile-img-card {
            width: 96px;
            height: 96px;
            margin: 0 auto 10px;
            display: block;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            border-radius: 50%;
        }

        /*
            * Form styles
            */
        .profile-name-card {
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0 0;
            min-height: 1em;
        }

        .reauth-email {
            display: block;
            color: #404040;
            line-height: 2;
            margin-bottom: 10px;
            font-size: 14px;
            text-align: center;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        .form-signin #inputEmail,
        .form-signin #inputPassword {
            direction: ltr;
            height: 44px;
            font-size: 16px;
        }

        .form-signin input[type=email],
        .form-signin input[type=password],
        .form-signin input[type=text],
        .form-signin button {
            width: 100%;
            display: block;
            margin-bottom: 10px;
            z-index: 1;
            position: relative;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        .form-signin .form-control:focus {
            border-color: rgb(104, 145, 162);
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgb(104, 145, 162);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgb(104, 145, 162);
        }

        .btn.btn-signin {
            /*background-color: #4d90fe; */
            background-color: rgb(104, 145, 162);
            /* background-color: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/
            padding: 0px;
            font-weight: 700;
            font-size: 14px;
            height: 36px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            border: none;
            -o-transition: all 0.218s;
            -moz-transition: all 0.218s;
            -webkit-transition: all 0.218s;
            transition: all 0.218s;
        }

            .btn.btn-signin:hover,
            .btn.btn-signin:active,
            .btn.btn-signin:focus {
                background-color: rgb(12, 97, 33);
            }

        .forgot-password {
            color: rgb(104, 145, 162);
        }

            .forgot-password:hover,
            .forgot-password:active,
            .forgot-password:focus {
                color: rgb(12, 97, 33);
            }
    </style>
</head>
<body>
    <form class="form-signin" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <h2 class="form-signin-heading">Please sign in</h2>
                    <label for="inputEmail" class="sr-only">Email address</label>
                    <asp:TextBox ID="txtemail" runat="server" placeholder="Email address" CssClass="form-control"></asp:TextBox>
                    <br />
                    <label for="inputPassword" class="sr-only">Password</label>
                    <asp:TextBox ID="txtpwd" runat="server" placeholder="Password" CssClass="form-control"></asp:TextBox>
                    <div class="checkbox">

                        <asp:CheckBox ID="chkrem" Text="Remember me" runat="server" />


                    </div>
                    <asp:Button ID="btnlogin" Text="Login" CssClass="btn btn-primary" runat="server" Width="50%" />
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>
        <div class="container">
            <div class="card card-container">
                <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
                <div class="mypanel-body" style="height: 40%;">
                    <div class="row">
                        <div class="col-lg-12">
                            <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
                            <p id="profile-name" class="profile-name-card"></p>
                        </div>
                    </div>
                    <div id="divcorpfac" runat="server">
                        <div class="row">
                            <div class="col-lg-12">
                                <span id="reauth-cor" class="reauth-email"></span>
                                <asp:DropDownList ID="drpcorp" runat="server" CssClass="form-control" Width="98%" OnSelectedIndexChanged="drpcorp_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <span id="reauth-email" class="reauth-email"></span>
                                <asp:DropDownList ID="drpfacility" runat="server" CssClass="form-control" Width="98%">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div id="divlblvalid" runat="server" visible="false">
                        <asp:Label ID="lblvalid" runat="server" ForeColor="Red"></asp:Label>
                    </div>

                    <div style="height: 10px;"></div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:TextBox ID="TextBox1" runat="server" placeholder="User Name" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:TextBox ID="TextBox2" runat="server" placeholder="Password" CssClass="form-control" TextMode="Password"></asp:TextBox>

                        </div>
                    </div>
                    <div id="remember" class="checkbox">
                        <label>
                            <asp:CheckBox ID="CheckBox1" Text="Remember me" runat="server" /></label>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <span id="reauth-login" class="reauth-email"></span>
                            <asp:Button ID="Button1" CssClass="btn btn-lg btn-primary btn-block btn-signin" Text="Continue" OnClick="btnlogin_Click" OnClientClick="return Validatetxtbox();" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <span id="reauth-Signout" class="reauth-email"></span>
                            <asp:Button ID="btnSignOut" CssClass="btn btn-lg btn-primary btn-block btn-signin" Text="Sign Out" runat="server" />
                        </div>
                    </div>
                    <!-- /form -->
                    <div class="row">
                        <div class="col-lg-9"><a href="#" class="forgot-password">Forgot the password? </a></div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Label ID="lblerror" runat="server" Style="color: red;" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
                <!-- /card-container -->
            </div>
        </div>
    </form>
</body>
</html>
