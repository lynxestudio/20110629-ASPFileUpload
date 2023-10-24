<%@ Page Language="C#" AutoEventWireup="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

protected void Page_Load(object sender, EventArgs e)
{

}
//Version 2.0 or above
public void btnPublish_Click(object sender,EventArgs args) {
try
{
string publishPath = System.Configuration.ConfigurationManager.AppSettings["publishPath"];
if (fupInputFile.HasFile && (fupInputFile.PostedFile.ContentLength > 0))
{
    Publish(fupInputFile, publishPath);
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

public void Publish(FileUpload inputFile,string publishPath) {
System.IO.FileInfo fi = new System.IO.FileInfo(inputFile.PostedFile.FileName);
string theFile = publishPath + fi.Name;
inputFile.PostedFile.SaveAs(theFile);
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
</head>
<body>
<form id="form1" runat="server">
<div>

<table style="width:100%;">
<tr>
    <td>
        1-. Seleccione el archivo</td>
</tr>
<tr>
    <td>
        <asp:FileUpload ID="fupInputFile" runat="server" Width="522" />
    </td>
</tr>
<tr>
    <td>
        2-. Pulse el botón publicar</td>
</tr>
<tr>
    <td>
        <asp:Button ID="btnPublish" runat="server" Text="Publicar" OnClick="btnPublish_Click"/>
    </td>
</tr>
</table>
<br />
<asp:Label ID="lblmsg" runat="server"></asp:Label>
</div>
</form>
</body>
</html>
