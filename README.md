# File Upload con ASP.NET en Linux y Apache con HtmlInputFile (Html Control) y en IIS y Windows con FileUpload (Web Control).

Una de las operaciones más frecuentes de las aplicaciones web (Web applications) es la carga de archivos (file upload), que es la acción donde el usuario puede seleccionar un archivo de su computadora y mediante el uso de un formulario en una página web puede transferir el archivo desde el sistema de archivos local hacia el sistema de archivos del servidor donde se encuentre la página web.
ASP .NET tiene dos formas de hacer esta funcionalidad, una mediante un control HtmlInputFile la cual se ha soportado desde el Framework 1.1 y la otra mediante un control FileUpload la cual se soporta a partir del Framework 2.0.



A continuación mostramos el listado de un programa en ASP.NET como ejemplo de la implementación de publicación de documentos utilizando el control HtmlInputFile.


Listado 1.0 ASP.NET upload con un control HtmlInputFile
<pre>
<%@ Page Language="C#" AutoEventWireup="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

public void publish(System.Web.UI.HtmlControls.HtmlInputFile inputFile,
string publishPath)
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
        <asp:Button ID="btnPublish" runat="server" Text="Publicar" 
OnClick="btnPublish_click"/>
    </td>
</tr>
</table>
<br />
<asp:Label ID="lblmsg" runat="server"></asp:Label>
</div>
</form>
</body>
</html>
</pre>

Como muestra de la implementación ASP.NET con el control FileUpload, presentamos el siguiente listado.


Listado 2.0 ASP.NET Upload con un control FileUpload

<pre>
<%@ Page Language="C#" AutoEventWireup="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
public void Publish(FileUpload inputFile,
string publishPath) {
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
        <asp:Button ID="btnPublish" runat="server" Text="Publicar" 
OnClick="btnPublish_Click"/>
    </td>
</tr>
</table>
<br />
<asp:Label ID="lblmsg" runat="server"></asp:Label>
</div>
</form>
</body>
</html>
</pre>

Para ambos casos el archivo de configuración web.config es el mismo, lo que cambia en ambos casos es el valor de la llave publishPath dentro de las etiquetas

<appSettings>
, ya que para el listado 1.0 que lo ejecutaremos en Linux utilizando Apache y Mono.
Por lo que el valor se establece en /home/martin/public_html/Downloads como se muestra en el web.config a continuación:

<pre>
<?xml version="1.0"?>
<configuration>
  <appSettings>
    <add key="publishPath" value="/home/martin/public_html/Downloads/"/>
  </appSettings>
        <connectionStrings/>
        <system.web>
                <compilation debug="true">
                </compilation>
                <authentication mode="Windows"/>
        </system.web>
</configuration>
</pre>
En el caso del listado 2.0 lo ejecutaremos en IIS 7.0 y Windows. Por lo que el valor se establece como se muestra en el web.config a continuación:

<pre>
<?xml version="1.0"?>
<configuration>
  <appSettings>
    <add key="publishPath" value="C:\inetpub\Downloads\"/>
  </appSettings>
        <connectionStrings/>
        <system.web>
                <compilation debug="true">
                </compilation>
                <authentication mode="Windows"/>
        </system.web>
</configuration>
</pre>

Para asignar el valor de la variable publishPath en el listado 1.0 con la siguiente línea:


string publishPath = ConfigurationSettings.AppSettings["publishPath"];

y para el listado 2.0 se asigna con la siguiente línea:


string publishPath = System.Configuration.ConfigurationManager.AppSettings["publishPath"];

Antes de ejecutar la página en Linux debemos habilitar con los permisos de escritura al directorio donde se guardaran los archivos, para hacerlo en Linux siga los siguientes pasos:


El directorio donde se subiran los archivos debe tener los permisos de escritura para el grupo www.

Si estamos como usuarios normales, cambiamos a una cuenta con privilegios de superusuario y establecemos y establecemos el grupo del directorio (en este ejemplo /home/martin/public_html/Downloads) como www con el siguiente comando:
# chgrp www Downloads

Ponemos permisos de escritura para el grupo con el siguiente comando:
# chmod 775 Downloads

Estos comandos se muestran a continuación en la siguiente imagen.

Ahora configuramos la Web Application dentro del archivo httpd.conf del servidor Apache como se muestra en la siguiente imagen:

Para consultar como crear una aplicación Web en Apache revisar el siguiente documento: ASP.NET con Mono

Igualmente antes de ejecutar la página en Windows debemos de habilitar con los permisos necesarios el directorio del servidor donde vamos a guardar los documentos, en este ejemplo la ruta configurada como directorio de publicación es C:\inetpub\wwwroot\dowloads, por lo que debemos seguir los siguientes pasos:


Hacer click derecho sobre el directorio, en la ventana Properties seleccionar al usuario IIS_IUSRS (el cuál es el usuario anónimo de IIS), presionar el botón “Edit” para abrir la ventana Permissions.


En la ventana de Permissions en la lista inferior Permissions for IIS_IUSRS seleccionar la casilla con el permiso Write


Creamos la Web Application de forma que se muestre en IIS 7.0 como en la siguiente imagen:

Al ejecutar la página ASP.NET desde FireFox en Linux se mostrará como en las siguientes imágenes:

Al ejecutar la página ASP.NET desde Internet Explorer en Windows se verá como en las siguientes imágenes:

Un error frecuente tanto para la implementación con HtmlInputFile y FileUpload, es tratar de subir un archivo que tenga un tamaño mayor al máximo permitido por la petición al servidor Web (Request)


Para solucionar este error solo hay que agregar la siguiente línea al archivo de configuración, donde definimos el tamaño máximo en Kb del archivo que necesitamos publicar. Por ejemplo en el siguiente web.config se definió un tamaño máximo aproximado a 5 mbs (5120 kb).
<pre>
<?xml version="1.0"?>
<configuration>
  <appSettings>
    <add key="publishPath" value="C:\inetpub\Downloads\"/>
  </appSettings>
        <connectionStrings/>
        <system.web>
                <compilation debug="true">
                </compilation>
                <authentication mode="Windows"/>
                <httpRuntime maxRequestLength="5120"/>
        </system.web>
</configuration>
</pre>

Para más información sobre este error consultar este enlace: HttpException Maximum Request Length.
