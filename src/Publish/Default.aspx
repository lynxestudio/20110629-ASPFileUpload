<%@ Page Language="C#" AutoEventWireup="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

protected void Page_Load(object sender, EventArgs e)
{

}
//Version 1.1
protected void btnPublish_click(object sender, EventArgs args) {
try
{
string publishPath = ConfigurationSettings.AppSettings["publishPath"];
if(publishPath == null)
  sspublishPath = "/home/martin/public_html/Downloads/";
if ((htmlinputFile.PostedFile != null) && (htmlinputFile.PostedFile.ContentLength > 0))
{
    publish(htmlinputFile, publishPath);
    lblmsg.ForeColor = System.Drawing.Color.Black;
    lblmsg.Text = "Archivo públicado con éxito";
}
else
{
    lblmsg.ForeColor = System.Drawing.Color.Red;
    lblmsg.Text = "Falta archivo para publicar";
}
}
catch (Exception ex) {
lblmsg.ForeColor = System.Drawing.Color.Red;
lblmsg.Text = ex.Message;
}
}

public void publish(System.Web.UI.HtmlControls.HtmlInputFile inputFile, string publishPath)
{
System.IO.FileInfo fi = new System.IO.FileInfo(inputFile.PostedFile.FileName);
string theFile = publishPath + fi.Name;
inputFile.PostedFile.SaveAs(theFile);
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title></title>
</head>
<body>
<form id="form1" runat="server" enctype="multipart/form-data">
<div>


<table width="33%">
<tr>
    <td>
        1-. Seleccione el archivo</td>
</tr>
<tr>
    <td>
        <input id="htmlinputFile" maxlength="5120" name="htmlinputFile" size="48" 
            type="file" runat="server" /></td>
</tr>
<tr>
    <td>
        2-. Pulse el botón publicar</td>
</tr>
<tr>
    <td>
        <asp:Button ID="btnPublish" runat="server" Text="Publicar" OnClick="btnPublish_click"/>
    </td>
</tr>
</table>
<br />
<asp:Label ID="lblmsg" runat="server"></asp:Label>
</div>
</form>
</body>
</html>
