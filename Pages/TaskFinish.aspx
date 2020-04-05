<%@ Page Title="Task Report" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeBehind="TaskFinish.aspx.cs" Inherits="WebApplication.Pages.TaskFinish" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <script type="text/javascript" src="../Scripts/jquery.dragsort-0.5.2.min.js"></script>
    <script>
        function OnEndCallback(s, e) {
            if (s.cpAlert != '' && (typeof s.cpAlert !== 'undefined')) {
                alert(s.cpAlert);
            }
        }
        function gvTaskFinishEndCallback(s, e) {
            if (s.cptaskAlert != '') {
                alert(s.cptaskAlert);
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#TopPanel_NavMenu ul li:eq(6)").addClass("dxm-selected");
        })
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
    </style>
    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel3" runat="server" Width="100%"
        ClientInstanceName="cp" OnCallback="ASPxCallbackPanel3_Callback">
        <ClientSideEvents EndCallback="OnEndCallback" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <div class="row container marginTop20">
                    <div class="col-md-12 box-content">
                        <div class="row">
                            <div class="col-md-12 marginTop20 marginBot20">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>Trạng thái</label>
                                        <dx:ASPxRadioButtonList ID="rbStatusF" RepeatDirection="Horizontal" ClientInstanceName="rbStatusF" runat="server">
                                           <ClientSideEvents ValueChanged="function(s, e) { cp.PerformCallback('filter'); }" />
                                            <Items>
                                                <dx:ListEditItem Text="Tất cả" Value="-1" Selected="true" />
                                                <dx:ListEditItem Text="Đã khảo sát" Value="1" />
                                                <dx:ListEditItem Text="Chưa khảo sát" Value="0" />
                                            </Items>
                                        </dx:ASPxRadioButtonList>
                                    </div>
                                    <div class="col-md-3">
                                        <label style="color:#fff">Export</label><br />
                                        <dx:ASPxButton ID="ASPxButton1" AutoPostBack="false" runat="server" CssClass="btn btn-warning" Text="Download">
                                            <ClientSideEvents Click="function(s, e) {  ImageExcelCallbackPanel.PerformCallback(); }"></ClientSideEvents>
                                        </dx:ASPxButton>
                                        <dx:ASPxCallbackPanel runat="server" ID="ImageExcelCallbackPanel" Style="float: right; margin-right: 10px; margin-top: 5px;" ClientInstanceName="ImageExcelCallbackPanel"
                                            OnCallback="ImageExcelCallbackPanel_Callback" SettingsLoadingPanel-Text="Exporting Data, please wait.">
                                            <ClientSideEvents EndCallback="OnEndCallback" />
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent3" runat="server">
                                                    <asp:HyperLink ID="hplexcel" runat="server"></asp:HyperLink>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                    </div>
                                </div>
                                <dx:ASPxGridView runat="server" OnLoad="gvTaskFinish_Load" AutoGenerateColumns="False" ID="gvTaskFinish" ClientInstanceName="gvTaskFinish" Width="100%"
                                    KeyFieldName="Id" DataSourceID="odsTask">
                                        <ClientSideEvents EndCallback="gvTaskFinishEndCallback" />
                                    <Styles>
                                        <Header Wrap="True" VerticalAlign="Middle" HorizontalAlign="Center"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle"></Cell>
                                        <AlternatingRow Enabled="true" />
                                    </Styles>
                                    <Columns>
                                        <dx:GridViewDataColumn VisibleIndex="0" Width="100px" Caption="Stt">
                                            <CellStyle HorizontalAlign="Center"></CellStyle>
                                            <DataItemTemplate>
                                                <%# Container.ItemIndex+1 %>
                                            </DataItemTemplate>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataTextColumn FieldName="Region" Caption="Region" VisibleIndex="1">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ShopName" Caption="Cửa hàng" VisibleIndex="2">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupName" Caption="Sup" VisibleIndex="3">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="EmployeeCode" Caption="EmployeeCode" VisibleIndex="4">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="EmployeeName" Caption="EmployeeName" VisibleIndex="5">
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Left"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SurveyDate" VisibleIndex="6" Caption="SurveyDate">
                                            <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd"></PropertiesTextEdit>
                                            <EditFormSettings Visible="False" />
                                            <CellStyle VerticalAlign="Middle" HorizontalAlign="Center"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>
                                    <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="370" VerticalScrollBarMode="Visible" />
                                    <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" />
                                    <Styles>
                                        <Header HorizontalAlign="Center" Wrap="True" Paddings-Padding="3px"></Header>
                                        <Cell Wrap="True" VerticalAlign="Middle" Paddings-Padding="5px"></Cell>
                                    </Styles>
                                    <SettingsPager PageSize="12"></SettingsPager>
                                </dx:ASPxGridView>
                                <asp:ObjectDataSource ID="odsTask" runat="server" SelectMethod="ReportFinish" TypeName="LogicTier.Controllers.TaskBL">
                                    <SelectParameters>
                                        <asp:Parameter Name="TaskId" Type="Int32" />
                                        <asp:Parameter Name="AccountId" Type="Int32" />
                                        <asp:Parameter Name="Finish" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </div>
                        </div>
                    </div>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</asp:Content>