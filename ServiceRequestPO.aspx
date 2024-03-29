﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceRequestPO.aspx.cs" MasterPageFile ="~/Inven.Master" Inherits="WebApplication1.ServiceRequestPO" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--/* 
'*******************************************************************************************************
' Itrope Technologies All rights reserved. 
' Copyright (C) 2017. Itrope Technologies. 
' Name      : ServiceRequestPO.aspx 
' Type      : ASPX File 
' Description  :   To design the Request Service PO page for add,Update and show the Request Service Parts on Grid.
' Modification History : 
'------------------------------------------------------------------------------------------------------'
   Date		            Version                 By                          Reason 
 1/08/2017              V.01                S.Vivekanand                    New
 
'******************************************************************************************************/
--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/Common.css" rel="stylesheet" />
    <link href="Content/sumoselect.css" rel="stylesheet" />
     <script src="Scripts/CDN.js/Cdn.js"></script>
    <style type="text/css">
        .page-title-breadcrumb {
            padding: 3px 20px;
            background: #ffffff;
            -webkit-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.05), 0 1px 0 rgba(0, 0, 0, 0.05);
            box-shadow: 0 2px 2px rgba(0, 0, 0, 0.05), 0 1px 0 rgba(0, 0, 0, 0.05);
            clear: both;
            border-bottom: 5px solid #e5e5e5 !important;
            box-shadow: none !important;
        }

        .pull-left {
            float: left !important;
        }

        .page-title-breadcrumb .page-header .page-title {
            font-size: 25px;
            font-weight: 300;
            display: inline-block;
        }

        .page-title-breadcrumb .breadcrumb {
            margin-bottom: 0;
            padding-left: 0;
            padding-right: 0;
            border-radius: 0;
            background: transparent;
        }

        .breadcrumb {
            padding: 8px 15px;
            margin-bottom: 20px;
            list-style: none;
            background-color: #f5f5f5;
            border-radius: 4px;
        }

        .page-header {
            margin: 0;
            padding: 0;
            border-bottom: 0;
        }

            .page-header .page-title {
                font-size: 25px;
                font-weight: 300;
                display: inline-block;
            }

        .pull-left {
            float: left !important;
        }

        .modalBackground {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1030;
            background-color: #000;
            opacity: 0.3;
        }

        .HeaderStyleLable {
            color: #000;
            font-family: 'Trocchi', serif;
            font-size: 20px;
            font-weight: bold;
            line-height: 18px;
            margin: 0;
        }

        .box {
            height: 100%;
            display: flex;
            align-items: center; /* align vertical */
        }


  .LeftPadding {
            padding-left: 15px;
        }

        .outPopUp {
            position: absolute;
            width: 900px;
            max-height: 400px;
            z-index: 15;
            top: 30%;
            left: 20%;
            margin: -50px 0 0 -150px;
            background: #f1f1f1;
            box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5);
        }

        .Upopacity {
            opacity: 0.3;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
    </style>
    <script type="text/javascript">
         
        function CorpDrop() {           
            $('[id*=drpcorsearch]').change(function (event) {                
                    if ($(this).val().length > 1) {
                        var val = $(this).val() || [];
                        alert('Multiple selection are not allowed here. Use Multi select link for multiple selection.');
                        var $this = $(this);
                        //$this[0].sumo.unSelectAll();

                        //$.each(last_valid_selection, function (i, e) {
                        //    $this[0].sumo.selectItem($this.find('option[value="' + e + '"]').index());
                        //});

                    } else {
                        last_valid_selection = $(this).val();
                    }                
            });
            
            $('[id*=drpfacilitysearch]').change(function (event) {
                
                if ($(this).val().length > 1) {
                    var val = $(this).val() || [];
                    alert('Multiple selection are not allowed here. Use Multi select link for multiple selection.');
                    var $this = $(this);
                    //$this[0].sumo.unSelectAll();

                    //$.each(last_valid_selection, function (i, e) {
                    //    $this[0].sumo.selectItem($this.find('option[value="' + e + '"]').index());
                    //});

                } else {
                    last_valid_selection = $(this).val();
                }                
            });
        }
       
    </script>
    <script type="text/javascript">

        function jScript() {
            $('[id*=drpcorsearch]').SumoSelect({
                <%-- $(<%=drpFacilitys.ClientID%>).SumoSelect({--%>
                selectAll: false,
                placeholder: 'Select Corporate'
            });

            $('[id*=drpfacilitysearch]').SumoSelect({
                <%-- $(<%=drpFacilitys.ClientID%>).SumoSelect({--%>
                selectAll: true,
                placeholder: 'Select Facility'
            });

            $('[id*=drpStatussearch]').SumoSelect({
                <%-- $(<%=drpFacilitys.ClientID%>).SumoSelect({--%>
                selectAll: true,
                placeholder: 'Select Status'
            });
        }

        function jscriptsearch() {
            var config = {
                '.chosen-select': {},
            }
            for (var selector in config) {
                $(selector).chosen(config[selector]);
            }
        }


        function SetAction(lnk) {
            var row = lnk.parentNode.parentNode;
            grdMedReqsearchIndex = row.rowIndex;
            var DrCr = $(lnk).closest("tr").find("[id *= drpaction]").val();
            var inputText = "Deny";
            $(document).ready(function () {

                $("#<%=grdSROrder.ClientID %> tr").each(function () {
                    //Skip first(header) row                    
                    if (!this.rowIndex) return;
                    if (DrCr == "Order" || DrCr == "Approve") {
                        if (this.rowIndex != grdMedReqsearchIndex) {
                            $(this).closest("tr").find('[id *= drpaction]').val(inputText);
                        }
                        else {
                            $("#<%=HddSelectedActionIndex.ClientID %>").val(this.rowIndex);
                        }
                    }
                    else if (DrCr == "Hold") {
                        var Check = $(this).closest("tr").find("[id *= drpaction]").val();
                        if (this.rowIndex != grdMedReqsearchIndex) {
                            if (Check == "Order" || Check == "Approve" || Check == "0") {
                                $(this).closest("tr").find('[id *= drpaction]').val(inputText);
                            }
                        }
                        else {
                            $("#<%=HddSelectedActionIndex.ClientID %>").val(this.rowIndex);
                        }

                    } else if (DrCr == "Deny") {
                        $("#<%=HddSelectedActionIndex.ClientID %>").val(this.rowIndex);
                    }
                });
            });
        }


function Remarkspopupshow() {
    $(document).ready(function () {
        $(function () {
            $('[id*=imgreadmore]').on('mouseover', function () {
                var a = "Click here to read more";
                $('[id*=imgreadmore]').attr('title', a);
            })
        });
        $('[data-toggle="popover"]').popover({
            placement: 'top',
            html: true,
            title: 'Remarks <a href="#" class="tooltipclose" data-dismiss="alert">&times;</a>'
        });

        $(document).on("click", ".popover .tooltipclose", function () {
            $(this).parents(".popover").popover('hide');
        });

        $('body').on('click', function (e) {
            $('[data-toggle=popover]').each(function () {
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });
    });
}

function Auditpopupshow() {
    $(document).ready(function () {
        $(function () {
            $('[id*=imgreadmore]').on('mouseover', function () {
                var a = "Click here to read more";
                $('[id*=imgreadmore]').attr('title', a);
            })
        });
        $('[data-toggle1="popover"]').popover({
            placement: 'top',
            html: true,
            title: 'Audit Trail <a href="#" class="tooltipclose" data-dismiss="alert">&times;</a>'
        });

        $(document).on("click", ".popover .tooltipclose", function () {
            $(this).parents(".popover").popover('hide');
        });

        $('body').on('click', function (e) {
            $('[data-toggle1=popover]').each(function () {
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });
    });
}



function ShowPopup(res) {

    $('[id*=lblsave]').html(res);

    $("#modalSave").modal("show");

}
function ShowdelPopup(res) {

    $('[id*=lbldelete]').html(res);

    $("#modalDelete").modal("show");

}

function ShowwarningPopup(res) {
    //alert('ggg');
    $('[id*=lblwarning]').html(res);

    $("#modalWarning").modal("show");

}
function ShowwarningLookupPopup(res) {
    //alert('ggg');
    $('[id*=lblwarning]').html(res);

    $("#modalWarning").modal("show");

}

function ShowConfirmationPopup() {

    $("#modalConfirm").modal("show");

}

function Hide(lnk) {
    $('[id*=btnGenerateOrder]').hide();
    //$('[id*=btngenerateorder]').attr("hidden", true);
}


// Valiadtion 

function RemarksChangeValidation(lnk) {
    //var row = lnk.parentNode.parentNode;
    //grdMedReqsearchIndex = row.rowIndex;

    //$('[id*=txtremarks]').on('change', function (e) {
    //    alert('Changed!')
    //});
}

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   
        <div class="page-title-breadcrumb">
            <div class="page-header">
                <div class="page-header page-title">
                    Work/Service Order
                </div>
            </div>
        </div>

        <asp:UpdatePanel ID="updmain" runat="server">
            <ContentTemplate>
                <script type="text/javascript">
                    Sys.Application.add_load(Auditpopupshow); 
                    Sys.Application.add_load(Remarkspopupshow);
                    Sys.Application.add_load(jScript);
                    Sys.Application.add_load(jscriptsearch);
                    Sys.Application.add_load(CorpDrop);
                </script>
                <asp:HiddenField ID="HddListCorpID" runat="server" />
                <asp:HiddenField ID="HddListFacID" runat="server" />
                   <%-- Model PopUp For Multi Corporate and Facility --%>
                <div class="outPopUp" runat="server" style="margin-left: 1px; margin-top: 3px; display: none; padding: 5px 5px 5px 10px;" id="DivMultiCorp">
                    <%--<asp:UpdatePanel runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnuploadfile" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                    <asp:Label ID="lblMultiCorp" runat="server" CssClass="page-header page-title" Text="Select Multiple Corporate"></asp:Label><br />
                     <asp:Label ID="lbrow" runat="server">No of records : <%=GrdMultiCorp.Rows.Count.ToString() %></asp:Label>
                    <div class="row" style="padding: 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12" style="overflow-y: scroll;height: 200px;">
                            <asp:GridView ID="GrdMultiCorp" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="ChkAllCorp" runat="server" AutoPostBack="true" OnCheckedChanged="ChkAllCorp_CheckedChanged" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkmultiCorp" runat="server" />
                                            <asp:Label ID="lblCorpID" runat="server" Text=' <%# Eval("CorporateID")%>' CssClass="HeaderHide"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Corporate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCorpname" runat="server" Text=' <%# Eval("CorporateName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="Headerstyle" />
                                <FooterStyle CssClass="gridfooter" />
                                <PagerStyle CssClass="pagerstyle" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle CssClass="gridselectedrow" />
                                <EditRowStyle CssClass="grideditrow" />
                                <AlternatingRowStyle CssClass="gridalterrow" />
                                <RowStyle CssClass="gridrow" />
                            </asp:GridView>
                        </div>

                    </div>

                    <div class="row" style="margin-top: 5px;">
                        <div class="col-lg-6 col-md-6 col-sm-6 form-group">
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 " align="right">
                            <br />
                            <asp:Button ID="btnMultiCorpselect" runat="server" Text="Select" CssClass="btn btn-primary" OnClick="btnMultiCorpselect_Click" />
                            <asp:Button ID="btnMultiCorpClose" runat="server" Text="Close" CssClass="btn btn-success" OnClick="btnMultiCorpClose_Click" />
                        </div>
                    </div>
                </div>
                <div id="UploadOpacity" runat="server">
                    <div class="mypanel-body" style="padding: 5px 15px 15px 15px;">
                        <div class="row">
                            <div class="col-lg-4" align="left">
                                <asp:Label ID="lblEditHeader" runat="server" Visible="false" CssClass="page-header page-title" Text="Search Result"></asp:Label>
                                <asp:Label ID="lblUpdateHeader" runat="server" Visible="false" CssClass="page-header page-title" Text="Header"></asp:Label>
                                <asp:Label ID="lblseroutHeader" runat="server" Visible="true" CssClass="page-header page-title" Text="Search Criteria"></asp:Label>
                            </div>
                            <div class="col-lg-8" align="right">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" Visible="false" />
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" ValidationGroup="EmptyField" OnClick="btnSearch_Click" />
                                <%--<asp:Button ID="btnReview" Visible="false" runat="server" CssClass="btn btn-primary" ValidationGroup="EmptyField" Text="Review" OnClick="btnReview_Click" />--%>
                                <asp:Button ID="btnPrint" runat="server" CssClass="btn btn-primary" Text="Print" OnClick="btnPrint_Click" />
                            </div>
                        </div>
                        <div id="divMPRMaster" runat="server" style="margin-top: 5px;">
                            <div id="divContent" class="well well-sm">
                                <div class="row">
                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                        <div class="form-group">
                                            <span style="font-weight: 800;">Corporate</span>&nbsp;<span style="color: red">*</span>
                                             <asp:LinkButton ID="lnkMultiCorp" runat="server" Text="Multi Select" CssClass="LeftPadding" OnClick="lnkMultiCorp_Click"></asp:LinkButton>
                                             <asp:LinkButton ID="lnkClearCorp" runat="server" Text="Select All" CssClass="LeftPadding" OnClick="lnkClearCorp_Click"></asp:LinkButton>
                                             <asp:LinkButton ID="lnkClearAllCorp" runat="server" Text="Clear All" CssClass="LeftPadding" OnClick="lnkClearAllCorp_Click"></asp:LinkButton>                     
                                             <asp:ListBox ID="drpcorsearch" runat="server" CssClass="form-control" SelectionMode="Multiple" multiple="multiple" AutoPostBack="true" OnSelectedIndexChanged="drpcorsearch_SelectedIndexChanged"></asp:ListBox>
                                             <asp:RequiredFieldValidator InitialValue="" ID="Reqdrpcorsearch" ValidationGroup="EmptyField" runat="server" ForeColor="Red"
                                                ControlToValidate="drpcorsearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                        <div class="form-group">
                                            <span style="font-weight: 800;">Facility</span>&nbsp;<span style="color: red">*</span>  
                                            <asp:ListBox ID="drpfacilitysearch" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                             <asp:RequiredFieldValidator InitialValue="" ID="Reqdrpfacilitysearch" ValidationGroup="EmptyField" runat="server" ForeColor="Red"
                                                ControlToValidate="drpfacilitysearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>

                                    </div>
                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                        <div class="form-group">
                                            <span style="font-weight: 800;">Status</span>&nbsp;<span style="color: red">*</span> 
                                            <asp:ListBox ID="drpStatussearch" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                            <asp:RequiredFieldValidator InitialValue="" ID="ReqdrpStatus" runat="server" ForeColor="Red" ValidationGroup="EmptyField"
                                                ControlToValidate="drpStatussearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <%--<div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span style="font-weight: 800;">Vendor</span>&nbsp;<span style="color: red">*</span>
                                        <asp:RequiredFieldValidator InitialValue="0" ID="Reqdrpvendorsearch" ValidationGroup="EmptyField" runat="server" ForeColor="Red"
                                            ControlToValidate="drpvendorsearch" ErrorMessage="This information is required."></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="drpvendorsearch" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>--%>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                        <div class="form-group">
                                            <span style="font-weight: 800;">Date From</span>&nbsp;<span style="color: red">*</span>
                                            <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control" placeholder="--/--/----"></asp:TextBox>
                                            <ajax:CalendarExtender ID="CalDateFrom" runat="server" TargetControlID="txtDateFrom" Format="MM/dd/yyyy"></ajax:CalendarExtender>
                                            <ajax:FilteredTextBoxExtender ID="FilterDateFrom" FilterType="Numbers,Custom" ValidChars="/,-" runat="server" TargetControlID="txtDateFrom"></ajax:FilteredTextBoxExtender>
                                               <asp:RequiredFieldValidator ID="ReqDateFrom" runat="server" ControlToValidate="txtDateFrom" ValidationGroup="EmptyField"
                                                ErrorMessage="This information is required" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                        <div class="form-group">
                                            <span style="font-weight: 800;">Date To</span>&nbsp;<span style="color: red">*</span>
                                            <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control" placeholder="--/--/----"></asp:TextBox>
                                            <ajax:CalendarExtender ID="CalDateTo" runat="server" TargetControlID="txtDateTo" Format="MM/dd/yyyy"></ajax:CalendarExtender>
                                            <ajax:FilteredTextBoxExtender ID="FilterDateTo" FilterType="Numbers,Custom" ValidChars="/,-" runat="server" TargetControlID="txtDateTo"></ajax:FilteredTextBoxExtender>
                                             <asp:RequiredFieldValidator ID="ReqtxtDateTo" runat="server" ControlToValidate="txtDateTo" ValidationGroup="EmptyField"
                                                ErrorMessage="This information is required" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div style="margin-left: 1px; margin-top: 3px;" id="divsearch">
                                <div class="row">
                                    <div class="col-lg-4" align="left">
                                        <asp:Label ID="btnSearchHeader" runat="server" CssClass="page-header page-title" Text="Search Result"></asp:Label>
                                    </div>
                                    <div class="col-lg-8" align="right">
                                        <asp:Button ID="btnrefresh" runat="server" Text="Refresh" CssClass="btn btn-primary" OnClick="btnrefresh_Click" />
                                        <%--<asp:Button ID="btnapproveall" runat="server" CssClass="btn btn-primary" Text="Approve All" OnClick="btnapproveall_Click" />--%>
                                        <%--<asp:Button ID="btnorderall" runat="server" CssClass="btn btn-primary" ValidationGroup="EmptyFieldSave" Text="Order All" OnClick="btnorderall_Click" />--%>
                                        <asp:Button ID="btnbtmreview" runat="server" Text="Review" CssClass="btn btn-primary" OnClick="btnReview_Click" />
                                        <asp:Button ID="btnClose" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="btnClose_Click" />
                                    </div>
                                </div>
                                  <asp:Label ID="lblcount" runat="server">No of records : <%=grdSRPO.Rows.Count.ToString() %></asp:Label>
                                <div class="SRPOSearchgrid">
                                    <asp:GridView ID="grdSRPO" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="8%" ItemStyle-Width="8%">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnEdit" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/edit.png" OnClick="imgbtnEdit_Click" />
                                                    <asp:ImageButton ID="imgprint" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/Print.png" OnClick="imgprint_Click" />
                                                    <asp:ImageButton ID="imgbtnEmail" runat="server" Text="Email" Height="20px" ImageUrl="~/Images/email_icon.png" OnClick="imgbtnEmail_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ServiceRequestMasterID" HeaderText="ServiceRequestMasterID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                            <asp:BoundField DataField="CorporateID" HeaderText="CorporateID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                            <asp:BoundField DataField="FacilityID" HeaderText="FacilityID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                            <asp:BoundField DataField="CreatedOn" HeaderText="Date Created " DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-Width="10%" ItemStyle-Width="10%" />
                                            <asp:BoundField DataField="CorporateName" HeaderText="Corp"  HeaderStyle-Width="8%" ItemStyle-Width="8%" />
                                            <asp:BoundField DataField="FacilityShortName" HeaderText="Facility"  HeaderStyle-Width="8%" ItemStyle-Width="8%" />
                                            <asp:TemplateField HeaderText="SR No">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbrevSRno" runat="server" Text='<%# Eval("SRNo")%>' OnClick="lbitrno_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SPO NO">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbrevSPOno" runat="server" Text='<%# Eval("SRPONO")%>' OnClick="lbitono_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpostatus" runat="server" Text='<%# Eval("Status")%>'></asp:Label>
                                                    <asp:Label ID="lblAction" runat="server" Text='<%# Eval("Action") %>' CssClass="HeaderHide"></asp:Label>
                                                    <asp:Label ID="lblIsEdit" runat="server" Text='<%# Eval("IsEdit") %>' CssClass="HeaderHide"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Audit Trail"  HeaderStyle-Width="6%" ItemStyle-Width="6%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCreatedBy" runat="server" Visible="false" Text=' <%# Eval("CreatedBy")%>'></asp:Label>
                                                    <asp:Image ID="imgreadmore1" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Audit") %>' data-toggle1="popover" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks"  HeaderStyle-Width="6%" ItemStyle-Width="6%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRemarks" runat="server" Visible="false"  Text='<%# Eval("Remarks")%>'></asp:Label>
                                                    <asp:Image ID="imgreadmore" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Remarks")%>' data-toggle="popover" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="Headerstyle" />
                                        <FooterStyle CssClass="gridfooter" />
                                        <PagerStyle CssClass="pagerstyle" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle CssClass="gridselectedrow" />
                                        <EditRowStyle CssClass="grideditrow" />
                                        <AlternatingRowStyle CssClass="gridalterrow" HorizontalAlign="left" />
                                        <RowStyle CssClass="gridrow" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <asp:HiddenField ID="hdncheckfield" Value="0" runat="server" />
                            <asp:HiddenField ID="HddServiceDetailsID" runat="server" />
                            <asp:HiddenField ID="HddServiceMasterNo" runat="server" />
                            <asp:HiddenField ID="HddSelectedActionIndex" runat="server" />
                            <asp:HiddenField ID="HddListofSRMasterID" runat="server" />
                            <asp:HiddenField ID="HddReviewPOPCheck" runat="server" />
                            <asp:HiddenField ID="HddGeneratePOPCheck" runat="server" />
                        </div>
                    </div>
                </div>




                <div id="modalConfirm" class="modal fade" style="position: center">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content ">
                            <div class="modal-header bg-red">
                                <h4 class="modal-title font-bold text-white">Delete Confirmation</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>Do you want to delete this record <span id="spnreName"></span>?</p>
                            </div>
                            <div class="modal-footer">
                                <asp:ImageButton ID="btnImgDeletePopUp" runat="server" CssClass="btn btn-danger" AlternateText="Yes" />
                                <button type="button" class="btn btn-default ra-100" data-dismiss="modal">Close</button>
                                <%--<asp:ImageButton ID="ImageButtonNo" runat="server" ImageUrl="~/Images/btnNo.jpg"/>--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="modalSave" class="modal fade" style="position: center">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content ">
                            <div class="modal-header bg-green">
                                <h4 class="modal-title font-bold text-white">Service Request Purchase Order 
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></h4>
                            </div>
                            <div class="modal-body">
                                <asp:Label ID="lblsave" runat="server"></asp:Label><asp:LinkButton ID="lbpopprint" runat="server" Text="Print" Visible="false"></asp:LinkButton>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default ra-100" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="modalDelete" class="modal fade" style="position: center">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content ">
                            <div class="modal-header bg-red">
                                <h4 class="modal-title font-bold text-white">Service Request Purchase Order 
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></h4>
                            </div>
                            <div class="modal-body">
                                <asp:Label ID="lbldelete" runat="server"></asp:Label>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default ra-100" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="modalWarning" class="modal fade" style="position: center">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content ">
                            <div class="modal-header btn-warning">
                                <h4 class="modal-title font-bold text-white">Service Request Purchase Order 
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></h4>
                            </div>
                            <div class="modal-body">
                                <asp:Label ID="lblwarning" runat="server"></asp:Label>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default ra-100" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="outPopUp" runat="server" style="margin-left: 1px; margin-top: 3px; display: none; padding: 5px 5px 5px 10px;" id="divUploadFile">
                    <asp:UpdatePanel runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnuploadfile" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Label ID="lblUPServicefile" runat="server" CssClass="page-header page-title" Text="Quote"></asp:Label>
                    <asp:HiddenField ID="hdnattachment" runat="server" />
                    <asp:GridView ID="GrdUploadFile" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                        <Columns>
                            <asp:BoundField DataField="ServiceUploadID" HeaderText="ServiceUploadID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                            <asp:BoundField DataField="ServiceRequestDetailsID" HeaderText="ServiceRequestDetailsID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                            <asp:BoundField DataField="LocationOfTheFile" HeaderText="Location Of The File" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                            <asp:BoundField DataField="FileName" HeaderText="FileName" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:BoundField DataField="UploadedDateTime" HeaderText="Uploaded DateTime" />
                            <asp:BoundField DataField="UploadedByName" HeaderText="Uploaded By" />

                            <asp:TemplateField HeaderText="Action" HeaderStyle-Width="30px" ItemStyle-Width="30px">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnImgView" runat="server" Width="18px" Height="20px" ImageUrl="~/Images/View.png" OnClick="btnImgView_Click" />
                                    <asp:ImageButton ID="btnImgDeleteQuote" runat="server" Width="18px" Height="20px" ImageUrl="~/Images/Delete.png" Enabled="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ServiceRequestMasterID" HeaderText="ServiceRequestMasterID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide"/>
                                    <asp:BoundField DataField="ServiceRequestDetailsID" HeaderText="ServiceRequestDetailsID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide"/>  --%>
                        </Columns>
                        <HeaderStyle CssClass="Headerstyle" />
                        <FooterStyle CssClass="gridfooter" />
                        <PagerStyle CssClass="pagerstyle" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle CssClass="gridselectedrow" />
                        <EditRowStyle CssClass="grideditrow" />
                        <AlternatingRowStyle CssClass="gridalterrow" />
                        <RowStyle CssClass="gridrow" />
                    </asp:GridView>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <asp:FileUpload ID="Fileuploadfile" runat="server" Enabled="false" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 5px;">
                        <div class="col-lg-6 col-md-6 col-sm-6 form-group">
                            <asp:Label ID="lblDescrip" runat="server" Text="Description" Font-Bold="true" CssClass="page-title"></asp:Label><br />
                            <asp:TextBox ID="txtDescrip" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 " align="right">
                            <br />
                            <asp:Button ID="btnuploadfile" runat="server" Text="Upload" CssClass="btn btn-primary" Enabled="false" />
                            <asp:Button ID="btnupclose" runat="server" Text="Close" CssClass="btn btn-success" OnClick="btnupclose_Click" />
                        </div>
                    </div>
                </div>


            </ContentTemplate>
        </asp:UpdatePanel>


        <div id="User_Permission_Message" runat="server" visible="false">
            <br />
            <br />
            <br />
            <h4>
                <center> This User don't have a Permission to View This Page...</center>
            </h4>
        </div>

        <asp:UpdatePanel ID="upnrevieworeder" runat="server">
            <ContentTemplate>
                <asp:Button ID="Button2" runat="server" Style="display: none" />
                <ajax:ModalPopupExtender ID="mpereview" runat="server"
                    PopupControlID="modalreview" TargetControlID="Button2"
                    BackgroundCssClass="modalBackground" BehaviorID="modalreview">
                </ajax:ModalPopupExtender>
                <div id="modalreview" style="display: none;">
                    <div class="modal-dialog-Review">
                        <div class="modal-content">
                            <div class="modal-header" style="padding: 8px 5px 0px 5px;">
                                <asp:Button ID="btnreviewclose" class="close" runat="server" Text="X" OnClick="btnrevwcancel_Click" />
                                <h4 class="modal-title" style="color: green; font-size: large">Work/Service Order Review</h4>
                            </div>
                            <div class="modal-body" style="padding: 5px;">
                                <div class="well well-sm">                                   
                                        <div class="row" style="margin-bottom: 2px;">
                                            <%-- <div class="col-lg-1" align="left">
                                            <asp:Label ID="lblpopupheader" runat="server" CssClass="page-header page-title" Text="Header"></asp:Label>
                                        </div>--%>
                                            <div class="col-lg-5">
                                                <div id="DivReportMessage" runat="server" style="display: none;">
                                                    <asp:Label ID="lblReprotMessage" runat="server" Style="color: green;"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-lg-7" align="right">
                                                <asp:Button ID="btnGenerateOrder" runat="server" CssClass="btn btn-success" Text="Approve/Generate Order" OnClientClick="Hide(this)"  OnClick="btnGenerateOrder_Click" />
                                                <asp:Button ID="btnrevwcancel" runat="server" CssClass="btn btn-primary" Text="Cancel" OnClick="btnrevwcancel_Click" />
                                            </div>
                                        </div>
                                   
                                    <%--<div class="well well-sm" style="padding: 5px 15px 15px 25px;">
                                        <div class="row">
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group">
                                                    <span style="font-weight: 800;">Corporate : </span>
                                                    <asp:Label ID="lblCorp" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group">
                                                    <span style="font-weight: 800;">Facility : </span>
                                                    <asp:Label ID="lblFac" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>

                                    </div>--%>

                                    <%--<asp:Label ID="lblpopupitems" runat="server" CssClass="page-header page-title" Text="Items"></asp:Label>--%>
                                     <asp:Label ID="lblrcount1" runat="server">No of records : <%=grdreviewreqpo.Rows.Count.ToString() %></asp:Label>
                                    <div class="SRPOReviewgrid">
                                        <asp:GridView ID="grdreviewreqpo" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Print" HeaderStyle-Width="5%" ItemStyle-Width="5%">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgrevprint" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/Print.png" OnClick="imgrevprint_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ServiceRequestMasterID" HeaderText="ServiceRequestMasterID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                <asp:BoundField DataField="ServiceRequestDetailsID" HeaderText="ServiceRequestDetailsID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                <asp:BoundField DataField="CreatedOn" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-Width="9%" ItemStyle-Width="9%" />
                                                <asp:BoundField DataField="CorporateID" HeaderText="CorporateID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                <asp:BoundField DataField="FacilityID" HeaderText="FacilityID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                <asp:BoundField DataField="CorporateName" HeaderText="Corp" HeaderStyle-Width="8%" ItemStyle-Width="8%" />
                                                <asp:BoundField DataField="FacilityShortName" HeaderText="Facility" HeaderStyle-Width="8%" ItemStyle-Width="8%" />
                                                <asp:BoundField DataField="VendorShortName" HeaderText="Vendor" HeaderStyle-Width="8%" ItemStyle-Width="8%" />
                                                <asp:TemplateField HeaderText="SR No">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbrevSRno" runat="server" Text='<%# Eval("SRNo")%>' OnClick="lbitrno_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SPO NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbrevSPOno" runat="server" Text='<%# Eval("SRPONO")%>' OnClick="lbitono_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Price" HeaderText="Price($)" DataFormatString="$ {0:#,0.00}" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                                <asp:BoundField DataField="Action" HeaderText="Action" />
                                                <asp:TemplateField HeaderText="Audit Trail" HeaderStyle-Width="6%" ItemStyle-Width="6%">
                                                    <ItemTemplate>
                                                        <%-- <span style="font-weight: 600">Date Created: </span>
                                                            <asp:Label ID="CreatedOn" runat="server" Text=' <%# Eval("CreatedOn","{0:MM/dd/yy}")%>'></asp:Label><br />
                                                            <span style="font-weight: 600">Created By: </span>--%>
                                                        <asp:Label ID="lblCreatedBy"  runat="server" Visible="false" Text=' <%# Eval("CreatedBy")%>'></asp:Label>
                                                        <asp:Image ID="imgrwreadmoreaudit" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Audit") %>' data-toggle1="popover" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remarks" HeaderStyle-Width="6%" ItemStyle-Width="6%"> 
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRemarks" runat="server" Visible="false" Text='<%# Eval("Remarks")%>'></asp:Label>
                                                        <asp:Image ID="imgrwreadmoreremark" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Remarks")%>' data-toggle="popover" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <%--<asp:BoundField DataField="User" HeaderText="User" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" /> --%>
                                            </Columns>
                                            <HeaderStyle CssClass="Headerstyle" />
                                            <FooterStyle CssClass="gridfooter" />
                                            <PagerStyle CssClass="pagerstyle" ForeColor="White" HorizontalAlign="Center" />
                                            <SelectedRowStyle CssClass="gridselectedrow" />
                                            <EditRowStyle CssClass="grideditrow" />
                                            <AlternatingRowStyle CssClass="gridalterrow" HorizontalAlign="left" />
                                            <RowStyle CssClass="gridrow" />
                                        </asp:GridView>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="uppanservicedetailsorder" runat="server">
            <ContentTemplate>

                <asp:Button ID="btnserviceorderopup" runat="server" Style="display: none" />
                <ajax:ModalPopupExtender ID="mpserviceorder" runat="server"
                    PopupControlID="modalserviceorder" TargetControlID="btnserviceorderopup"
                    BackgroundCssClass="modalBackground" BehaviorID="modalserviceorder">
                </ajax:ModalPopupExtender>
                <div id="modalserviceorder" style="display: none;">
                    <div class="modal-dialog-Review">
                        <div class="modal-content">
                            <div class="modal-header" style="padding: 8px 5px 0px 5px;">
                                <asp:Button ID="btnactionclose" class="close" runat="server" Text="X" OnClick="btncancel_Click" />
                                <h4 class="modal-title" style="color: green; font-size: large">Service Rquest Order </h4>
                            </div>
                            <div class="modal-body" style="padding: 5px;">
                                <div class="form-horizontal">
                                    <div class="row" style="margin-bottom: 2px;">
                                        <div class="col-lg-4">
                                        </div>
                                        <div class="col-lg-5">
                                            <div id="DivShowError" runat="server" style="display: none;" align="left">
                                                <asp:Label ID="lblShowError" runat="server" ForeColor="Red"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-3" align="right">
                                            <asp:Button ID="btnActionSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnActionSave_Click" />
                                            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-primary" Text="Reset Selection" OnClick="btnReset_Click" />
                                            <asp:Button ID="btncancel" runat="server" CssClass="btn btn-primary" Text="Cancel" OnClick="btncancel_Click" />
                                        </div>
                                    </div>
                                    <div id="Div1" class="row" runat="server">
                                        <div class="col-lg-6">
                                            <span style="font-weight: 800; color: red;">Performing changes on Service Request No:- </span>
                                            <asp:Label ID="lblSRNo" runat="server" ForeColor="Red" Text=""></asp:Label>
                                        </div>
                                    </div>

                                    <%-- <asp:Label ID="lblitems" runat="server" CssClass="page-header page-title" Text="Items"></asp:Label>--%>
                                     <asp:Label ID="lblrcount2" runat="server">No of records : <%=grdSROrder.Rows.Count.ToString() %></asp:Label>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="grdSROrder" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Vendor">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("VendorName") %>' CssClass="form-control"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Service">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtService" runat="server" Text='<%# Eval("Service") %>' CssClass="Textbox_Size" ReadOnly="true" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Unit">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtUnit" runat="server" Text='<%# Eval("Unit") %>' CssClass="Textbox_Size" ReadOnly="true" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Price($)">
                                                        <ItemTemplate>
                                                            <div class="Currency-group">
                                                                <span class="Currency-group-addon">
                                                                    <i class="fa fa-dollar"></i>
                                                                </span>
                                                                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Eval("Price", "{0:F2}") %>' CssClass="Textbox_Size" ReadOnly="true" />
                                                                <%-- <ajax:FilteredTextBoxExtender ID="FTBPrice" FilterType="Numbers,Custom" ValidChars="." runat="server" TargetControlID="Price"></ajax:FilteredTextBoxExtender>--%>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Quote" HeaderStyle-Width="30px" ItemStyle-Width="30px">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="btnImgUploadQuote" runat="server" Height="20px" ImageUrl="~/Images/Attachment.png" OnClick="btnImgUploadQuote_Click" />
                                                            <asp:Label ID="lbServiceRequestMasterID" runat="server" Text='<%# Eval("ServiceRequestMasterID") %>' CssClass="HeaderHide"></asp:Label>
                                                            <asp:Label ID="lbServiceRequestDetailsID" runat="server" Text='<%# Eval("ServiceRequestDetailsID") %>' CssClass="HeaderHide"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="drpaction" runat="server" onchange="SetAction(this)"></asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Remarks">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtremarks" runat="server" CssClass="form-control" Text="" TextMode="MultiLine"></asp:TextBox>
                                                            <asp:TextBox ID="txtremarksAfterOrder" runat="server" CssClass="form-control" Text='<%# Eval("Remarks")%>' Visible="false" ReadOnly="true"></asp:TextBox>
                                                            <%--<asp:Image ID="imgreadmore" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="30px" Visible="false" data-content='<%# Eval("Remarks")%>' data-toggle="popover" />--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>

                                                <HeaderStyle CssClass="Headerstyle" />
                                                <FooterStyle CssClass="gridfooter" />
                                                <PagerStyle CssClass="pagerstyle" ForeColor="White" HorizontalAlign="Center" />
                                                <SelectedRowStyle CssClass="gridselectedrow" />
                                                <EditRowStyle CssClass="grideditrow" />
                                                <AlternatingRowStyle CssClass="gridalterrow" HorizontalAlign="left" />
                                                <RowStyle CssClass="gridrow" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>


        <asp:UpdatePanel ID="upnlview" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnmpedemo" runat="server" Style="display: none" />
                <ajax:ModalPopupExtender ID="mpeimgview" runat="server"
                    TargetControlID="btnmpedemo" PopupControlID="pnlimgview" CancelControlID="btnpopclose"
                    BackgroundCssClass="modalBackground">
                </ajax:ModalPopupExtender>
                <asp:Panel ID="pnlimgview" Style="display: none;" runat="server">
                    <div style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 1040; overflow: auto; overflow-y: scroll; margin-top: 1%;">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header" style="height: 40px">
                                    <asp:Button ID="btnpopclose" runat="server" CssClass="close" Text="X" />
                                    <asp:Label runat="server" Text="Document Viewer" ID="lblimg" />
                                </div>
                                <div class="modal-body" style="padding: 2px;">
                                    <div class="container-fluid" runat="server" id="Div2">
                                        <iframe id="frame1" runat="server" style="height: 530px; width: 100%;" onscroll="auto"></iframe>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>


        <div style="display: none">
            <rsweb:ReportViewer ID="rvservicerequestPOreport" runat="server"></rsweb:ReportViewer>
        </div>

</asp:Content>
