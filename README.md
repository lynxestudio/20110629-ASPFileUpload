# File Upload con ASP.NET en Linux y Apache con HtmlInputFile (Html Control) y en IIS y Windows con FileUpload (Web Control).
<p align="justify">
Una de las operaciones más frecuentes de las aplicaciones web (Web applications) es la carga de archivos (file upload), que es la acción donde el usuario puede seleccionar un archivo de su computadora y mediante el uso de un formulario en una página web puede transferir el archivo desde el sistema de archivos local hacia el sistema de archivos del servidor donde se encuentre la página web.
ASP .NET tiene dos formas de hacer esta funcionalidad, una mediante un control HtmlInputFile la cual se ha soportado desde el Framework 1.1 y la otra mediante un control FileUpload la cual se soporta a partir del Framework 2.0.
</p>
<p>
A continuación mostramos el listado de un programa en ASP.NET como ejemplo de la implementación de publicación de documentos utilizando el control HtmlInputFile.
</p>
<div>Listado 1.0 ASP.NET upload con un control HtmlInputFile</div>
<img src=""/>
<p>
Como muestra de la implementación ASP.NET con el control FileUpload, presentamos el siguiente listado.
</p>
<div>Listado 2.0 ASP.NET Upload con un control FileUpload</div>
<img src=""/>
<p>
Para ambos casos el archivo de configuración web.config es el mismo, lo que cambia en ambos casos es el valor de la llave publishPath dentro de las etiquetas
<pre>
<appSettings>
</pre>
, ya que para el listado 1.0 que lo ejecutaremos en Linux utilizando Apache y Mono.
</p>
<p>
Por lo que el valor se establece en /home/martin/public_html/Downloads como se muestra en el web.config a continuación:
</p>
<img src=""/>
<p>
En el caso del listado 2.0 lo ejecutaremos en IIS 7.0 y Windows. Por lo que el valor se establece como se muestra en el web.config a continuación:
</p>
<img src=""/>
<p>
Para asignar el valor de la variable publishPath en el listado 1.0 con la siguiente línea:
</p>
<pre>
string publishPath = ConfigurationSettings.AppSettings["publishPath"];
</pre>
<p>
y para el listado 2.0 se asigna con la siguiente línea:
</p>
<pre>
string publishPath = System.Configuration.ConfigurationManager.AppSettings["publishPath"];
</pre>
<p>
Antes de ejecutar la página en Linux debemos habilitar con los permisos de escritura al directorio donde se guardaran los archivos, para hacerlo en Linux siga los siguientes pasos:
</p>
<p>
El directorio donde se subiran los archivos debe tener los permisos de escritura para el grupo www.

Si estamos como usuarios normales, cambiamos a una cuenta con privilegios de superusuario y establecemos y establecemos el grupo del directorio (en este ejemplo /home/martin/public_html/Downloads) como www con el siguiente comando:
</p>
<pre>
# chgrp www Downloads
</pre>
<p>
Ponemos permisos de escritura para el grupo con el siguiente comando:
</p>
<pre>
# chmod 775 Downloads
</pre>
<p>
Estos comandos se muestran a continuación en la siguiente imagen.
</p>
<img src=""/>
<p>
Ahora configuramos la Web Application dentro del archivo httpd.conf del servidor Apache como se muestra en la siguiente imagen:
</p>
<img src=""/>
<p>
Para consultar como crear una aplicación Web en Apache revisar el siguiente documento: ASP.NET con Mono
</p>
<p align="justify">
Igualmente antes de ejecutar la página en Windows debemos de habilitar con los permisos necesarios el directorio del servidor donde vamos a guardar los documentos, en este ejemplo la ruta configurada como directorio de publicación es C:\inetpub\wwwroot\dowloads, por lo que debemos seguir los siguientes pasos:
</p>

Hacer click derecho sobre el directorio, en la ventana Properties seleccionar al usuario IIS_IUSRS (el cuál es el usuario anónimo de IIS), presionar el botón “Edit” para abrir la ventana Permissions.


En la ventana de Permissions en la lista inferior Permissions for IIS_IUSRS seleccionar la casilla con el permiso Write


Creamos la Web Application de forma que se muestre en IIS 7.0 como en la siguiente imagen:

Al ejecutar la página ASP.NET desde FireFox en Linux se mostrará como en las siguientes imágenes:

Al ejecutar la página ASP.NET desde Internet Explorer en Windows se verá como en las siguientes imágenes:
<p>
Un error frecuente tanto para la implementación con HtmlInputFile y FileUpload, es tratar de subir un archivo que tenga un tamaño mayor al máximo permitido por la petición al servidor Web (Request)
</p>
<p>
Para solucionar este error solo hay que agregar la siguiente línea al archivo de configuración, donde definimos el tamaño máximo en Kb del archivo que necesitamos publicar. Por ejemplo en el siguiente web.config se definió un tamaño máximo aproximado a 5 mbs (5120 kb).
</p>
<img src=""/>
<p>
Para más información sobre este error consultar este enlace: HttpException Maximum Request Length.
</p>
