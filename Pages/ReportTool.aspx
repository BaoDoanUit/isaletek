<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Layout.master"
    AutoEventWireup="true"
    CodeBehind="ReportTool.aspx.cs" Inherits="WebApplication.Pages.ReportTool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(4)").addClass("dxm-selected");
        })

        function ExportOnEndCallback(s, e) {
            alert('Success');
        }

        function ExportFile() {
            var para = "Export;" + cbReport.GetValue() + ";" + cbMonth.GetValue() + ";" + cbYear.GetValue();
            console.log(para);
            aspxExport.PerformCallback(para);
        }
    </script>
    <style type="text/css">
        ul {
            list-style-type: none;
        }

        .placeHolder div {
            background-color: white !important;
            border: dashed 1px gray !important;
        }

        ul#gallery {
            float: left;
            width: 100%;
            padding: 0;
            margin: 0
        }

            ul#gallery li {
                float: left;
                height: 85px;
            }

        .thumbnail {
            position: relative
        }

        ul#gallery li a {
            padding-left: 15px
        }

        td#Content_popupEdit_Panel1_PopupCallback_ASPxFormLayout1_3 td.dxflCaptionCellSys {
            vertical-align: middle;
        }
    </style>
    <div class="row marginTop20">
        <div class="col-md-12">
            <dx:ASPxFormLayout ID="SearchFormLayout"
                ClientInstanceName="SearchFormLayout"
                runat="server" UseDefaultPaddings="true">
                <SettingsItems Width="100%" />
                <SettingsItemCaptions Location="Top" />
                <Items>
                    <dx:LayoutGroup Caption="Report">
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Month</label>
                                                <dx:ASPxComboBox runat="server" ID="cbMonth" Width="100%"
                                                    ValueType="System.Int32" NullText="Choose"
                                                    ClientInstanceName="cbMonth">
                                                    <Items>
                                                        <dx:ListEditItem Text="1" Value="1" />
                                                        <dx:ListEditItem Text="2" Value="2" />
                                                        <dx:ListEditItem Text="3" Value="3" />
                                                        <dx:ListEditItem Text="4" Value="4" />
                                                        <dx:ListEditItem Text="5" Value="5" />
                                                        <dx:ListEditItem Text="6" Value="6" />
                                                        <dx:ListEditItem Text="7" Value="7" />
                                                        <dx:ListEditItem Text="8" Value="8" />
                                                        <dx:ListEditItem Text="9" Value="9" />
                                                        <dx:ListEditItem Text="10" Value="10" />
                                                        <dx:ListEditItem Text="11" Value="11" />
                                                        <dx:ListEditItem Text="12" Value="12" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </div>
                                            <div class="col-md-3">
                                                <label>Year</label>
                                                <dx:ASPxComboBox runat="server" ID="cbYear" Width="100%"
                                                    ValueType="System.Int32" NullText="Choose"
                                                    ClientInstanceName="cbYear">
                                                    <Items>
                                                        <dx:ListEditItem Text="2018" Value="2018" />
                                                        <dx:ListEditItem Text="2019" Value="2019" />
                                                        <dx:ListEditItem Text="2020" Value="2020" />
                                                        <dx:ListEditItem Text="2021" Value="2021" />
                                                        <dx:ListEditItem Text="2022" Value="2022" />
                                                        <dx:ListEditItem Text="2023" Value="2023" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </div>
                                            <div class="col-md-6">
                                                <label>Report Type</label>
                                                <dx:ASPxComboBox runat="server" ID="cbReport" Width="100%"
                                                    ValueType="System.String" NullText="Choose"
                                                    ClientInstanceName="cbReport">
                                                    <Items>
                                                        <dx:ListEditItem Text="Báo cáo PC sử dụng hệ thống" Value="LoginReport" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </div>
                                            <div class="col-md-6">
                                                <label style="color: white">Tool</label><br />
                                                <dx:ASPxButton ID="btnImport"
                                                    ClientInstanceName="btnExport"
                                                    CssClass="btn btn-danger ml-2" runat="server"
                                                    Text='Import' Width="100"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s,e) {ExportFile();}" />
                                                </dx:ASPxButton>
                                                <dx:ASPxButton ID="btnExport" ClientInstanceName="btnExport"
                                                    CssClass="btn btn-danger ml-2" runat="server" Text='Export' Width="100"
                                                    AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s,e) {ExportFile();}" />
                                                </dx:ASPxButton>
                                                <dx:ASPxCallbackPanel ID="aspxExport" runat="server"
                                                    ClientInstanceName="aspxExport"
                                                    OnCallback="aspxExport_Callback">
                                                    <ClientSideEvents EndCallback="ExportOnEndCallback" />
                                                    <PanelCollection>
                                                        <dx:PanelContent runat="server">
                                                            <dx:ASPxHyperLink ID="hpl" runat="server"
                                                                Visible="false" AutoPostBack="false">
                                                            </dx:ASPxHyperLink>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>
    </div>
</asp:Content>
