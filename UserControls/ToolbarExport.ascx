<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ToolbarExport.ascx.cs" Inherits="ExportToolbar.ToolbarExport" %>

<style scoped="scoped">
    .exportToolbarCaption {
        height: 38px;
        padding: 0 6px 0 6px;
        text-align: center;
        display: table-cell;
        vertical-align: middle;
        cursor: default;
    }
    li[id*=MenuExportButtons_DXI1_IS] {
        display: none;
    }
</style>
<div class="OptionsBottomMargin">
    <dx:ASPxMenu runat="server" ID="MenuExportButtons" ClientInstanceName="MenuExportButtons" ShowAsToolbar="true" OnItemClick="MenuExportButtons_ItemClick" AutoPostBack="true" Theme="Moderno">
        <Items>
            <dx:MenuItem Name="ToolbarCaption">
                <Template>
                    <div class="exportToolbarCaption">
                        <dx:ASPxLabel runat="server" ID="labelCaption" Text="Export type:" Theme="Moderno" />
                    </div>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</div>