﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MedicalSuppliesRequestOrder.aspx.cs" MasterPageFile ="~/Inven.Master" Inherits="WebApplication1.MedicalSuppliesRequestOrder" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--/* 
'*******************************************************************************************************
' Itrope Technologies All rights reserved. 
' Copyright (C) 2017. Itrope Technologies. 
' Name      : MedicalSuppliesOrder.aspx 
' Type      : ASPX File 
' Description  :   To design the MedicalSuppliesOrder page for Add,Update and show the MedicalSuppliesOrder on Grid.
' Modification History : 
'------------------------------------------------------------------------------------------------------'
   Date		            Version             By                                       Reason 
  04/JAN/2018           V.01              C.Dhanasekaran                               New
  05/Mar/2018          V.01              Vivekanand.S                               Multi Search 
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
                selectAll: false,
                placeholder: 'Select Facility'
            });

            $('[id*=drpvendorsearch]').SumoSelect({
                <%-- $(<%=drpFacilitys.ClientID%>).SumoSelect({--%>
                selectAll: true,
                placeholder: 'Select Vendor'
            });

            $('[id*=drpStatus]').SumoSelect({
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

        function GetgrdOrderSearchIndexValue(orderid) {
            var row = orderid.parentNode.parentNode;
            grdMedReqsearchIndex = row.rowIndex - 1;
            document.getElementById('<%=HdnMSRDetailID.ClientID%>').value += (grdMedReqsearchIndex) + ',';
        }

        function Remarkspopupshow() {
            $(document).ready(function () {
                $('[id*=imgreadmore]').on('mouseover', function () {
                    var a = "Click here to read more";
                    $('[id*=imgreadmore]').attr('title', a);
                })
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
                $('[id*=imgreadmore]').on('mouseover', function () {
                    var a = "Click here to read more";
                    $('[id*=imgreadmore]').attr('title', a);
                })
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
            $('[id*=lblwarning]').html(res);
            $("#modalWarning").modal("show");

        }
        function ShowwarningLookupPopup(res) {
            $('[id*=lblwarning]').html(res);
            $("#modalWarning").modal("show");
        }
        function ShowConfirmationPopup() {
            $("#modalConfirm").modal("show");
        }

        function HideConfirmationPopup() {
            $("#modalConfirm").modal("Hide");
        }
        
        function Hide(lnk)
        {
            var IsValidRemarks = true;
            $("[id*=gvmedreview] tbody tr").each(function () {
                var txtremarks = $(this).find("[id*=txtremarks]").val();
                if (txtremarks == '') {
                    IsValidRemarks = false;
                }
            });
            if (IsValidRemarks == true) {
                $('[id*=btngenerateorder]').hide();
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   
        <div class="page-title-breadcrumb">
            <div class="page-header">
                <div class="page-header page-title">
                    Purchase Order
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="updmain" runat="server">
            <ContentTemplate>
                <script type="text/javascript">
                    Sys.Application.add_load(Auditpopupshow);
                    Sys.Application.add_load(Remarkspopupshow);
                    Sys.Application.add_load(jScript);
                    Sys.Application.add_load(CorpDrop); 
                    //Sys.Application.add_load(jscriptsearch);
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
                        <div class="col-lg-12 col-md-12 col-sm-12" style="overflow-y: scroll; height: 200px;">
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

                <div class="outPopUp" runat="server" style="margin-left: 1px; margin-top: 3px; display: none; padding: 5px 5px 5px 10px;" id="DivFacCorp">
                    <%--<asp:UpdatePanel runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnuploadfile" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                    <asp:Label ID="lblMultiFac" runat="server" CssClass="page-header page-title" Text="Select Multiple Facility"></asp:Label><br />
                      <asp:Label ID="lbcount" runat="server">No of records : <%=GrdMultiFac.Rows.Count.ToString() %></asp:Label>
                    <div class="row" style="padding: 10px;">
                        <div class="col-lg-12 col-md-12 col-sm-12" style="overflow-y: scroll; height: 200px;">
                            <asp:GridView ID="GrdMultiFac" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="ChkAllFac" runat="server" AutoPostBack="true" OnCheckedChanged="ChkAllFac_CheckedChanged" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkmultiFac" runat="server" />
                                            <asp:Label ID="lblFacID" runat="server" Text=' <%# Eval("FacilityID")%>' CssClass="HeaderHide"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Facility">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFacname" runat="server" Text=' <%# Eval("FacilityDescription")%>'></asp:Label>
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
                            <asp:Button ID="btnMultiFacselect" runat="server" Text="Select" CssClass="btn btn-primary" OnClick="btnMultiFacselect_Click" />
                            <asp:Button ID="btnMultiFacClose" runat="server" Text="Close" CssClass="btn btn-success" OnClick="btnMultiFacClose_Click" />
                        </div>
                    </div>
                </div>

                <div id="DivMedicalRequestOrder" runat="server" class="mypanel-body" style="padding: 5px 15px 15px 15px;">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4" align="left">
                            <asp:Label ID="lblEditHeader" runat="server" Visible="false" CssClass="page-header page-title" Text="Search Result"></asp:Label>
                            <asp:Label ID="lblUpdateHeader" runat="server" Visible="false" CssClass="page-header page-title" Text="Header"></asp:Label>
                            <asp:Label ID="lblseroutHeader" runat="server" Visible="true" CssClass="page-header page-title" Text="Search Criteria"></asp:Label>
                        </div>
                        <div class="col-lg-8 col-md-8 col-sm-8" align="right">
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" ValidationGroup="EmptyFieldSearch" OnClick="btnSearch_Click" />
                            <asp:Button ID="btnsearchprint" runat="server" CssClass="btn btn-primary" Text="Print" OnClick="btnsearchprint_Click" />
                        </div>
                    </div>
                    <div id="divMedReqSearch" runat="server" style="margin-top: 5px;">
                        <div id="divSearchContent" runat="server" class="well well-sm">
                            <div class="row">
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Corporate</span>&nbsp;<span style="color: red">*</span>
                                         <asp:LinkButton ID="lnkMultiCorp" runat="server" Text="Multi Select" CssClass="LeftPadding" OnClick="lnkMultiCorp_Click"></asp:LinkButton>
                                         <asp:LinkButton ID="lnkClearCorp" runat="server" Text="Select All" CssClass="LeftPadding" OnClick="lnkClearCorp_Click"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkClearAllCorp" runat="server" Text="Clear All" CssClass="LeftPadding" OnClick="lnkClearAllCorp_Click"></asp:LinkButton>
                                        <asp:RequiredFieldValidator InitialValue="" ID="Reqdrpcorsearch" ValidationGroup="EmptyFieldSearch" runat="server" ForeColor="Red"
                                            ControlToValidate="drpcorsearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:ListBox ID="drpcorsearch" runat="server" CssClass="form-control" SelectionMode="Multiple" multiple="multiple" AutoPostBack="true" OnSelectedIndexChanged="drpcorsearch_SelectedIndexChanged"></asp:ListBox>                                            
                                        <%--<asp:DropDownList ID="drpcorsearch" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="drpcorsearch_SelectedIndexChanged">--%>
                                        <%--</asp:DropDownList>--%>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Facility</span>&nbsp;<span style="color: red">*</span>
                                        <asp:LinkButton ID="lnkMultiFac" runat="server" Text="Multi Select" CssClass="LeftPadding" OnClick="lnkMultiFac_Click"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkClearFac" runat="server" Text="Select All" CssClass="LeftPadding" OnClick="lnkClearFac_Click"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkClearAllFac" runat="server" Text="Clear All" CssClass="LeftPadding" OnClick="lnkClearAllFac_Click"></asp:LinkButton>
                                        <asp:RequiredFieldValidator InitialValue="" ID="Reqdrpfacilitysearch" ValidationGroup="EmptyFieldSearch" runat="server" ForeColor="Red"
                                            ControlToValidate="drpfacilitysearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:ListBox ID="drpfacilitysearch" runat="server" CssClass="form-control" SelectionMode="Multiple" multiple="multiple" AutoPostBack="true" OnSelectedIndexChanged="drpfacilitysearch_SelectedIndexChanged"></asp:ListBox>
                                        <%--<asp:DropDownList ID="drpfacilitysearch" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="drpfacilitysearch_SelectedIndexChanged"></asp:DropDownList>--%>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Vendor</span>&nbsp;<span style="color: red">*</span>
                                          <asp:RequiredFieldValidator InitialValue="" ID="Reqdrpvendorsearch" ValidationGroup="EmptyFieldSearch" runat="server" ForeColor="Red"
                                            ControlToValidate="drpvendorsearch" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:ListBox ID="drpvendorsearch" runat="server" CssClass="form-control" SelectionMode="Multiple" ></asp:ListBox>
                                        <%--<asp:DropDownList ID="drpvendorsearch" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Date From</span>&nbsp;<span style="color: red">*</span>
                                        <asp:RequiredFieldValidator ID="rfvDateFrom" runat="server" ControlToValidate="txtDateFrom" ValidationGroup="EmptyFieldSearch"
                                            ErrorMessage="This information is required" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revdatefrom" ControlToValidate="txtDateFrom"
                                            ValidationExpression="^([0-9]|0[1-9]|1[012])\/([0-9]|0[1-9]|[12][0-9]|3[01])\/(19|20)\d\d$" runat="server" ErrorMessage="Invalid Format(eg.MM/DD/YYYY)"
                                            SetFocusOnError="true" ForeColor="Red" Style="margin-left: 4px;" ValidationGroup="EmptyFieldSearch" Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY" MaxLength="10"></asp:TextBox>
                                        <ajax:CalendarExtender ID="CalDateFrom" runat="server" TargetControlID="txtDateFrom" Format="MM/dd/yyyy"></ajax:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Date To</span>&nbsp;<span style="color: red">*</span>
                                        <asp:RequiredFieldValidator ID="rfvDateTo" runat="server" ControlToValidate="txtDateTo" ValidationGroup="EmptyFieldSearch"
                                            ErrorMessage="This information is required" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revdateto" ControlToValidate="txtDateTo"
                                            ValidationExpression="^([0-9]|0[1-9]|1[012])\/([0-9]|0[1-9]|[12][0-9]|3[01])\/(19|20)\d\d$" runat="server" ErrorMessage="Invalid Format(eg.MM/DD/YYYY)"
                                            SetFocusOnError="true" ForeColor="Red" Style="margin-left: 4px;" ValidationGroup="EmptyFieldSearch" Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY" MaxLength="10"></asp:TextBox>
                                        <ajax:CalendarExtender ID="CalDateTo" runat="server" TargetControlID="txtDateTo" Format="MM/dd/yyyy"></ajax:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <span>Status</span>&nbsp;<span style="color: red">*</span>
                                        <asp:RequiredFieldValidator InitialValue="" ID="ReqdrpStatus" ValidationGroup="EmptyFieldSearch" runat="server" ForeColor="Red"
                                            ControlToValidate="drpStatus" ErrorMessage="This information is required." SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:ListBox ID="drpStatus" runat="server" CssClass="form-control" SelectionMode="Multiple" ></asp:ListBox> 
                                        <%--<asp:DropDownList ID="drpStatus" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3" align="left">
                            <asp:Label ID="btnSearchHeader" runat="server" CssClass="page-header page-title" Text="Search Result"></asp:Label>
                        </div>
                        <div class="col-lg-9" align="right">
                            <asp:Button ID="btnrefresh" runat="server" CssClass="btn btn-primary" Text="Refresh" OnClick="btnrefresh_Click" />
                            <asp:Button ID="btnorderall" runat="server" CssClass="btn btn-primary" Text="Order All" OnClick="btnorderall_Click" />
                            <asp:Button ID="btnrevieworder" runat="server" CssClass="btn btn-primary" Text="Review" OnClick="btnrevieworder_Click" />
                            <asp:Button ID="btncancel" runat="server" CssClass="btn btn-primary" Text="Cancel" OnClick="btncancel_Click" />
                        </div>
                    </div>
                    <asp:HiddenField ID="HdnMSRDetailID" runat="server" />
                        <asp:Label ID="lblrcount2" runat="server">No of records : <%=grdOrderSearch.Rows.Count.ToString() %></asp:Label>
                    <div id="divgrdMSRSearch" runat="server" style="margin-left: 1px; margin-top: 3px;" class="divMedReqSearchGrid MSRSearchgrid">
                        <asp:GridView ID="grdOrderSearch" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" OnRowDataBound="grdOrderSearch_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Edit/Print" HeaderStyle-Width="6%" ItemStyle-Width="6%">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnEdit" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/edit.png" OnClick="imgbtnEdit_Click" ToolTip="Edit" />
                                        <asp:ImageButton ID="imgsearchprint" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/Print.png" OnClick="imgsearchprint_Click" ToolTip="Print" />
                                        <asp:ImageButton ID="imgsend" runat="server" Text="Send" Height="20px" ImageUrl="~/Images/email_icon.png" OnClick="imgsend_Click" ToolTip="Resend" Visible="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MedicalSuppliesID" HeaderText="MedicalSuppliesID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                <asp:BoundField DataField="CorporateID" HeaderText="CorporateID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                <asp:BoundField DataField="FacilityID" HeaderText="FacilityID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                <asp:BoundField DataField="VendorID" HeaderText="VendorID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                <asp:BoundField DataField="CreatedOn" HeaderText="Date Created" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-Width="9%" ItemStyle-Width="9%" />
                                <asp:BoundField DataField="CorporateName" HeaderText="Corp" HeaderStyle-Width="7%" ItemStyle-Width="7%" />
                                <asp:BoundField DataField="FacilityShortName" HeaderText="Facility"  HeaderStyle-Width="7%" ItemStyle-Width="7%"/>
                                <asp:BoundField DataField="VendorShortName" HeaderText="Vendor" HeaderStyle-Width="7%" ItemStyle-Width="7%" />
                                <asp:TemplateField HeaderText="PR No">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lkbtnprno" runat="server" Text=' <%# Eval("PRNo")%>' OnClick="lkbtnprno_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO No">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lkbtnpono" runat="server" Text=' <%# Eval("PONo")%>' OnClick="lkbtnpono_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TotalPrice" HeaderText="Price($)" DataFormatString="$ {0:#,0.00}" HeaderStyle-Width="9%" ItemStyle-Width="9%"/>
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="drpaction" runat="server" CssClass="form-control" onchange="GetgrdOrderSearchIndexValue(this)"></asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Audit Trail" HeaderStyle-Width="6%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblaudit" Visible="false" runat="server" Text='<%# Eval("Audit")%>'></asp:Label>
                                        <asp:Image ID="imgreadmoreaudit" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Audit") %>' data-toggle1="popover" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks" HeaderStyle-Width="6%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemarks" Visible="false" runat="server" Text='<%# Eval("Remarks")%>'></asp:Label>
                                        <asp:Image ID="imgreadmore" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Remarks")%>' data-toggle="popover" />
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
                        <asp:HiddenField ID="hdncheckfield" runat="server" Value="0" />
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
        <div style="display: none">
            <rsweb:ReportViewer ID="rvMSRPoReport" runat="server"></rsweb:ReportViewer>
        </div>
        <div style="display: none">
            <rsweb:ReportViewer ID="rvmedicalsupplyreportPDF" runat="server"></rsweb:ReportViewer>
        </div>
        <%-- Popup Notification--%>
        <div id="modalSave" class="modal fade" style="position: center">
            <div class="modal-dialog modal-sm">
                <div class="modal-content ">
                    <div class="modal-header bg-green">
                        <h4 class="modal-title font-bold text-white">Medical Supplies RequestPo
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


        <div id="modalWarning" class="modal fade" style="position: center">
            <div class="modal-dialog modal-sm">
                <div class="modal-content ">
                    <div class="modal-header btn-warning">
                        <h4 class="modal-title font-bold text-white">Medical Supplies RequestPo
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
        <div id="modalDelete" class="modal fade" style="position: center">
            <div class="modal-dialog modal-sm">
                <div class="modal-content ">
                    <div class="modal-header bg-red">
                        <h4 class="modal-title font-bold text-white">Medical Supplies RequestPo
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
        <div id="modalConfirm" class="modal fade" style="position: center">
            <div class="modal-dialog modal-sm">
                <div class="modal-content ">
                    <div class="modal-header bg-red">
                        <h4 class="modal-title font-bold text-white">Delete Confirmation</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Do you want to delete this record <span id="spnreName"></span>?.</p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="removeyes" runat="server" Text="Yes" CssClass="btn btn-danger" />
                        <asp:Button ID="removeno" runat="server" Text="Close" class="btn btn-default ra-100" />
                        <%-- <asp:ImageButton ID="ImageButton3" runat="server" CssClass="btn btn-danger" AlternateText="Yes" OnClick="Imageremoveyes_Click" />--%>
                        <%-- <button type="button" class="btn btn-default ra-100" data-dismiss="modal">Close</button>--%>
                        <%--<asp:ImageButton ID="ImageButton6" runat="server" CssClass="btn btn-default ra-100" AlternateText="Close" OnClick="imgremoveno_Click" />--%>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnmedreview" runat="server" Style="display: none" />
                <ajax:ModalPopupExtender ID="mpemedsupplyReview" runat="server"
                    PopupControlID="mpemedsupreview" TargetControlID="btnmedreview"
                    BackgroundCssClass="modalBackground" BehaviorID="mpemedsupplyReview" CancelControlID="btnrevclose">
                </ajax:ModalPopupExtender>

                <div id="mpemedsupreview" style="display: none;">
                    <div class="modal-dialog-Review">
                        <div class="modal-content">
                            <div class="modal-header" style="padding: 8px 5px 0px 5px;">
                                <asp:Button ID="btnrevclose" class="close" runat="server" Text="X" OnClick="btnrevclose_Click" />
                                <h4 class="modal-title" style="color: black; font-size: large">Purchase Order Review</h4>
                            </div>
                            <div class="modal-body" style="padding: 5px 15px 15px 15px;">
                                <div class="form-horizontal">
                                    <div class="row" style="margin-bottom: 2px;">
                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <div class="col-lg-3"><span class="page-header page-title">Items</span></div>
                                            <div class="col-lg-9" align="right">
                                                <asp:Label ID="lblmessage" runat="server" Text="" ForeColor="Green"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6" align="right">
                                            <asp:Button ID="btngenerateorder" runat="server" CssClass="btn btn-success" Text="Generate Order" OnClientClick="Hide(this)" OnClick="btngenerateorder_Click" ValidationGroup="EmptyFieldremarks" />
                                            <asp:Button ID="btnreviewprintall" runat="server" Text="Print All" CssClass="btn btn-primary" Visible="false" />
                                            <asp:Button ID="btnreviewcancel" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="btnreviewcancel_Click" />
                                        </div>
                                    </div>
                                      
                                   <%-- <div class="well well-sm">--%>
                                        <%--       <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Corporate</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblreviewcorporate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Facility</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblreviewfacility" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Vendor</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblvendor" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-lg-12">
                                                <asp:Label ID="lblrcount3" runat="server">No of records : <%=gvmedreview.Rows.Count.ToString() %></asp:Label>
                                               <div class="MSRReviewgrid">
                                                <asp:GridView ID="gvmedreview" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive" 
                                                    OnRowDataBound="gvmedreview_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Print" HeaderStyle-Width="4%" ItemStyle-Width="4%">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgprint" runat="server" Text="Edit" Height="20px" ImageUrl="~/Images/Print.png" OnClick="imgprint_Click" ToolTip="Print" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="MedicalSuppliesID" HeaderText="MedicalSuppliesID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                        <asp:BoundField DataField="CreatedOn" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-Width="9%" />
                                                        <asp:BoundField DataField="CorporateID" HeaderText="CorporateID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                        <asp:BoundField DataField="FacilityID" HeaderText="FacilityID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                        <asp:BoundField DataField="VendorID" HeaderText="VendorID" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide" />
                                                        <asp:BoundField DataField="CorporateName" HeaderText="Corp" HeaderStyle-Width="7%" />
                                                        <asp:BoundField DataField="FacilityShortName" HeaderText="Facility" HeaderStyle-Width="7%" />
                                                        <asp:BoundField DataField="VendorShortName" HeaderText="Vendor" HeaderStyle-Width="7%" />
                                                        <asp:TemplateField HeaderText="PR No">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lkbtnprnoreview" runat="server" Text=' <%# Eval("PRNo")%>' OnClick="lkbtnprnoreview_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PO No">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lkbtnponoreview" runat="server" Text=' <%# Eval("PONo")%>' OnClick="lkbtnponoreview_Click"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="TotalPrice" HeaderText="Price($)" DataFormatString="{0:F2}" HeaderStyle-Width="9%" />
                                                        <asp:TemplateField HeaderText="Status" HeaderStyle-Width="8%">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Action" HeaderText="Action" HeaderStyle-Width="7%" />
                                                        <asp:TemplateField HeaderText="Audit Trail" HeaderStyle-Width="5%">
                                                            <ItemTemplate>
                                                                <%--<asp:Label ID="lblrwaudit" runat="server" Text='<%# Eval("Audit")%>'></asp:Label>--%>
                                                                <asp:Image ID="imgrwreadmoreaudit" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="40px" data-content='<%# Eval("Audit") %>' data-toggle1="popover" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%-- <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="HeaderHide" ItemStyle-CssClass="HeaderHide">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="drpaction" runat="server" CssClass="form-control"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                        <%--   <asp:TemplateField HeaderText="Audit Trail" HeaderStyle-Width="17%">
                                                            <ItemTemplate>
                                                                <span style="font-weight: 600">Date Created: </span>
                                                                <asp:Label ID="CreatedOn" runat="server" Text=' <%# Eval("CreatedOn","{0:MM/dd/yy}")%>'></asp:Label><br />
                                                                <span style="font-weight: 600">Created By: </span>
                                                                <asp:Label ID="CreatedBy" runat="server" Text=' <%# Eval("CreatedBy")%>'></asp:Label>
                                                                <asp:Image ID="imgreadmore1" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="30px" data-content='<%# Eval("Audit") %>' data-toggle1="popover" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Remarks" HeaderStyle-Width="9%">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtremarks" runat="server" TextMode="MultiLine" Visible="false"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvremarks" runat="server" ControlToValidate="txtremarks" ErrorMessage="Please enter the Remark" ForeColor="Red"
                                                                    ValidationGroup="EmptyFieldremarks"></asp:RequiredFieldValidator>
                                                                <%--<asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks")%>'></asp:Label>
                                                                <asp:Image ID="imgreadmore" runat="server" ImageUrl="~/Images/Readmore.png" ImageAlign="Right" Height="30px" Visible="false" data-content='<%# Eval("Remarks")%>' data-toggle="popover" />--%>
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

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:Button ID="Button1" runat="server" Style="display: none" />
                <ajax:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                    TargetControlID="Button1" PopupControlID="Panel1" CancelControlID="btnprpopclose"
                    BackgroundCssClass="modalBackground">
                </ajax:ModalPopupExtender>
                <asp:Panel ID="Panel1" Style="display: none;" runat="server">
                    <div class="modal-dialog-Review">
                        <div class="modal-content">
                            <div class="modal-header" style="padding: 8px 5px 0px 5px;">
                                <asp:Button ID="btnprpopclose" class="close" runat="server" Text="X" />
                                <h4 class="modal-title" style="color: black; font-size: large">Medical Supplies Review</h4>
                            </div>
                            <div class="modal-body" style="padding: 5px 15px 15px 15px;">
                                <div class="form-horizontal">
                                    <div class="row" style="margin-bottom: 2px;">
                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <span class="page-header page-title">Header</span>
                                        </div>
                                    </div>
                                    <div runat="server" id="diveviewprno">
                                        <span style="font-weight: 800;">Purchase Number :- </span>
                                        <asp:Label ID="lblrwprno" runat="server" ForeColor="Red" CssClass="page-title lable-align" Text=""></asp:Label>
                                    </div>
                                    <div class="well well-sm">
                                        <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Corporate</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrcorporate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Facility</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrfacility" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Vendor</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrvendor" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Order Period</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrorderperiod" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Shipping</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrshipping" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Order Type</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrordertype" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-2 col-md-2 col-lg-2">
                                                <span style="font-size: 14px; font-weight: bold;">Time Delivery</span>
                                            </div>
                                            <div class="col-sm-4 col-md-4 col-lg-4">
                                                <div class="form-group" style="font-weight: 600;">
                                                    <asp:Label ID="lblmsrtimedelivery" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                      <asp:Label ID="lblItemHeader" runat="server" CssClass="page-header page-title" Text="Items"></asp:Label><br />
                                      <asp:Label ID="lblrcount4" runat="server">No of records : <%=grdmsrreview.Rows.Count.ToString() %></asp:Label>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-12 col-lg-12 MSRReviewgrid">
                                            <asp:GridView ID="grdmsrreview" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Records Found" CssClass="table table-responsive">
                                                <Columns>
                                                    <asp:BoundField DataField="ItemID" HeaderText="ItemID" HeaderStyle-Width="5%"/>
                                                     <asp:BoundField DataField="VendorItemID" HeaderText="Vendor ItemID"  HeaderStyle-Width="8%" />
                                                    <asp:BoundField DataField="CategoryName" HeaderText="Item Group"  HeaderStyle-Width="8%" />
                                                    <asp:BoundField DataField="ItemDescription" HeaderText="Item Description" />
                                                    <asp:BoundField DataField="UOM" HeaderText="UOM"  HeaderStyle-Width="5%" />
                                                    <asp:BoundField DataField="QtyPack" HeaderText="Qty/ Pack"  HeaderStyle-Width="5%" />
                                                    <asp:BoundField DataField="Price" HeaderText="Price($)" DataFormatString="$ {0:#,0.00}"  HeaderStyle-Width="8%" />
                                                    <asp:BoundField DataField="Parlevel" HeaderText="Par level"  HeaderStyle-Width="5%"/>
                                                    <asp:BoundField DataField="QtyInHand" HeaderText="Qty In Hand (Each)"  HeaderStyle-Width="5%" />
                                                    <asp:BoundField DataField="OrderQty" HeaderText="Order Qty"  HeaderStyle-Width="5%" />
                                                    <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice($)" DataFormatString="$ {0:#,0.00}"  HeaderStyle-Width="10%" />
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
                                    <div class="row" align="right">
                                        <div class="col-sm-12 col-md-12 col-lg-12">
                                            <span style="font-weight: 800;">Grand Total</span>&nbsp&nbsp;                                         
                                            <asp:Label ID="lblrwgrandtotal" runat="server" Text="0" Style="font-weight: 800;"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
