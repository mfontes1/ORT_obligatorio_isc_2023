<p align="center">
<img src="docs/img/MJ Sports logo-2023-06-26.png" width="300" alt="MJ Sports" />

</p>


![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

La aplicación MJ Sports es una demostración de una arquitectura de microservicios nativa de la nube. Está compuesta por una aplicación
de microservicios de 11 niveles, la cual es una sofisticada plataforma de comercio electrónico basada en la web. Dentro de esta plataforma,
los clientes tienen una experiencia de compra sin problemas, lo que les permite navegar por una amplia gama de artículos deportivos.
Mientras navegan por la aplicación, los clientes podrán agregar los productos deseados a su carrito de compras y completar sus compras de
forma segura y fácil. Con esta aplicación, MJ Sports satisface las necesidades de sus clientes y les proporciona una interfaz fácil de usar.
Esta tecnología también permite la escalabilidad, resiliencia y la agilidad que son tan necesarias en el desarrollo de aplicaciones modernas.


## Imágenes

| Home Page                                                                                                         | Checkout Screen                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](docs/img/MJSports-frontend-1.jpg) | [![Screenshot of checkout screen](docs/img/MJSports-frontend-2.jpg) 

## Arquitectura

MJ Sports está compuesto por 11 microservicios implementados en varios lenguajes de programación. Estos diferentes lenguajes se comunican entre sí a través de gRPC.
gRPC está diseñado para facilitar la comunicación entre diferentes servicios en un entorno distribuido, y admite varios lenguajes de programación diferentes.


[![Architecture of
microservices](./docs/img/architecture-diagram.png)](./docs/img/architecture-diagram.png)

Find **Protocol Buffers Descriptions** at the [`./pb` directory](./pb).

| Servicio                                             | Lenguaje      | Descripción                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](./src/frontend)                           | Go            | Expone a un servidor HTTP que sirve al sitio web. No requiere registro/inicio de sesión y genera sesiones automáticamente para todos los usuarios. |
| [cartservice](./src/cartservice)                     | C#            | Almacena en Redis los artículos en el carrito de compras del cliente y los recupera.                                              |
| [productcatalogservice](./src/productcatalogservice) | Go            | Proporciona la lista de productos de un archivo JSON, y la capacidad de buscar y obtener productos individuales.                  |
| [currencyservice](./src/currencyservice)             | Node.js       | Convierte precios a todas las monedas. Utiliza valores reales obtenidos del Banco Central Europeo. Es el servicio de mayor QPS (consultas por segundo). |
| [paymentservice](./src/paymentservice)               | Node.js       | Carga la información de la tarjeta de crédito proporcionada con el monto indicado y devuelve un ID de transacción.                |
| [shippingservice](./src/shippingservice)             | Go            | Proporciona estimaciones de costos de envío basadas en el carrito de compras. Envía los artículos a la dirección proporcionada.   |
| [emailservice](./src/emailservice)                   | Python        | Envía un correo de confirmación a los clientes.                                                                                   |
| [checkoutservice](./src/checkoutservice)             | Go            | Recupera el carrito del cliente, prepara el pedido, coordina el pago y envío, y envía la notificación for correo electrónico.     |
| [recommendationservice](./src/recommendationservice) | Python        | Recomienda otros productos basado en lo que hay en el carrito.                                                                    |
| [adservice](./src/adservice)                         | Java          | Proporciona anuncios basados en el contexto de las palabras proporcionadas.                                                       |
| [loadgenerator](./src/loadgenerator)                 | Python/Locust | Envía solicitudes continuamente imitando flujos reales de compras de usuarios al frontend.                                 

                             
## Descripción de la infraestructura
La infraestructura creada es simple, escalable, robusta y cumple con las necesidades del cliente. 
Está compuesta por un VPC con IP 10.0.0.0/16 en dos zonas de disponibilidad (AZ), us-east-1b con CIDR 10.0.1.0/24 y us-east-1c con CIDR 10.0.2.0/24, donde cada una contiene una instancia EC2. Un ELB (load balancer) del tipo de aplicaciones (Application Load Balancer), que es el adecuado para el balanceo de carga de trafico HTTP y HTTPS. Puede controlar la carga variable del trafico de la aplicacion en una unica o varias AZs.  
Dos instancias EC2 que contiene todos los servicios. Un proxy reverso (Nginx) de alto rendimiento para recibir las solicitudes de los clientes y pasarlas a los servidores web. El proxy reverso mejora la seguridad al evitar que la aplicacion estén expuestas a internet, y también mejora el rendimiento y la disponibilidad de la aplicación. 
Además, se usó un Redis en cada instancia, los que están asociados a un share NFS con el objetivo de compartir y sincronizar datos utilizados por las dos instancias de Redis.

<h2 align="center">Diagrama de Arquitectura</h2>
   
<p align="center">
 <img src="docs/img/Diagrama_arquitectura.png" alt="Diagrama de Arquitectura">
</p>
                                                                                        
Se usó Terraform para la automatización del despliegue de la infraestructura, despliegue de las imágenes y de los contenedores.
La estructura de Terraform para este proyecto se ve como se muestra en la foto.

<h2 align="center">Estructura del Proyecto</h2>
   
<p align="center">
 <img src="docs/img/Estructura_proyecto.png" alt="Estructura del Proyecto">
</p>

En la raíz del directorio “terraform” se encuentran los archivos main.tf, provider.tf, terraform.tfstate y el backup, valores.tfvars y variables.tf.
En el **main.tf** se definió la parametrización del código, con los parametros contenidoes en el modulo dev_deploy_isc y se especifica la ruta en el source. También se proporciona los valores de entrada utilizando las variables de la ami, instance type, name instance, name vpc, vpc cidr, public subnets, las AZ y los security groups. El bloque output define la salida del módulo, se llama "dns-output" y se indica donde se encuentra su valor, que está en "dev_deploy_isc".

La parametrización es beneficiosa porque si se requiere un cambio en los datos, se va al archivo valores.tfvars, se hace el cambio y luego ese cambio se replica en todos los archivos relacionados.

En el archivo **provider.tf** se definio la región y el profile. 
El archivo **variables.tf** es donde se definieron las variables. Permite flexibilidad y tambien que se puedan reutilizar.
En **valores.tfvars** es donde se agregaron los valores de esas variables y es de donde se harán los cambios necesarios. 
El archivo **terraform.tfstate** es muy importante y crítico para el funcionamiento de terraform, así que es importante mantenerlo seguro. Guarda estado actual de los recursos de esta infraestructura, incluyendo identificadores únicos de los recursos, configuraciones aplicadas, dependencias, entre otras cosas, que son necesarias para administrar y actualizar la infraestructura de manera controlada.

Además, en la raíz de terraform, se encuentra el directorio **modules** el cual contiene los datos de la parametrización necesaria para el despliegue automatizado de la infraestructura. También dentro de modules tenemos archivos y directorios.

Uno de ellos es el directorio **dev_deploy_isc**, el que contiene los archivos para el despliegue de la infraestructura.
El archivo **instances.tf**, es donde se indicaron las instancias que se van a crear. Si hay necesidad de crear más instancias se crearán en este archivo. Se crearon web1 y web2. Cada instancia se configuró para hacer lo mismo con mínimas variaciones. En el bloque provisioner se configuró una serie de comandos que hacen lo siguiente,  instala Git, curl, Docker, luego instala docker-compose en su última versión, le da permisos al archivo de Docker-compose y agrega al usuario "ec2-user" al grupo Docker. Luego se mueve al directorio home del usuario y comienza el clonado del repositorio.  

**Nota importante para quien ejecute las instancias:** en el bloque “connection”, se debe cambiar el path en el file para que apunte a la private_key de quien sea el ejecutante.

Archivo **network.tf**, acá es donde se definieron los recursos de red, se parametrizaron los valores. Se definió la VPC, la subnet1 y 2, se definió el Gateway, la default route table para el VPC, también una ruta para el load balancer, se definió el load balancer con sus subnets 1 y 2 además del security group para el lb. Se definieron los listeners en el puerto 80, le hace forward al target group que recibe en el puerto 8080, HTTP, este contiene los attachments 1 y 2. 

Archivo **security-groups.tf**, contiene la configuración para definir y administrar los security groups. Se definieron las reglas de ingreso y salida para las instancias web 1 y 2, el load balancer y el share NFS. Para las web permite acceso SSH en los puertos 22 y HTTP en el 80, para el LB en el puerto 80 y para NFS en el puerto 2049 para TCP. Las reglas de firewall son manejadas a nivel de los security groups para proteger las comunicaciones y controlar el tráfico entrante y saliente.

El **EFS (Elastic File System)**, describe los recursos con sus puntos de montaje asociados en cada subred. Esto permite compartir los archivos almacenados y escalar a necesidad. Estos archivos son accesibles desde ambas instancias EC2 en la misma VPC. Si la cantidad de instancias EC2 aumenta, también tendrán acceso a los archivos de forma segura.   

Archivo **variables.tf**, contiene las variables de input allí definidas que aplican al directorio modules. Con esta parametrizacion se logra flexibilidad para personalizar y reutilizar la infraestructura a necesidad. 

Dentro de **modules**, también se encuentra el directorio *docker-compose**, el cual contiene todos los microservicios que serán desplegados por docker-compose.

**Nota:** se decidió utilizar docker-compose en lugar de Kubernetes por una serie de razones.

**1-**	El proyecto no requiere un escalamiento masivo, por lo tanto, Docker satisface el nivel de escalamiento requerido y provee otras ventajas que hacen que valga la pena su uso. 
    Se adapta bien al tamaño del proyecto.
    
**2-**	Kubernetes es bastante más complejo. Docker es más simple en su uso. 

**3-**	Las fallas en Docker son más fáciles de identificar, ya que contienen menos cosas que pueden fallar.

**4-**	Los archivos de Docker son en texto plano y se pueden compartir fácilmente, en cambio los archivos de un despliegue de Kubernetes son almacenados en sus manifiestos que     
    utilizan un formato más complejo.
    
**Docker-compose** contiene todos los servicios mencionados en la arquitectura del documento más arriba. Dentro de cada servicio hay un archivo que es importante, el **Dockerfile**. Contiene datos sensibles porque se usa para crear imágenes, para instalar software, copiar archivos y hasta configuraciones. Todo lo que se quiera modificar o actualizar se va a hacer desde este archivo. 

El otro archivo es **docker-compose.yml**, en la estructura esta fuera de todos los servicios. Es el archivo de configuración utilizado por Docker-compose. En el archivo se describieron los servicios, redes y volúmenes necesarios pare ejecutar la aplicación en este proyecto el cual está compuesto por varios contenedores de Docker. Todos los servicios deben estar presentes en este archivo con detalles de los puertos expuestos, los volúmenes con el path, dependencias y otras configuraciones específicas del servicio. Cuando se ejecute el docker-compose, este archivo va a ser leído para saber dónde levantar las imágenes de cada servicio, para lo cual el path de cada servicio va a apuntar hacia su dockerfile. Este path debe estar correctamente ingresado, de lo contrario se obtendrá un error por respuesta. 

Finalmente para desplegar la infraestructura con este codigo se debe tener presente lo siguente:
**1-** En AWS se debe tener una cuenta, AWS cli instalado, credenciales en ./aws/credentials y la clave SSH en formato .pem, guardado para ser utilizado con frecuencia en la ejecución del código.
**2-** Tener Terraform instalado
**3-** En Git: clonar el repositorio:"https://github.com/mfontes1/ORT_obligatorio_isc_2023.git" 
       En el directorio del repo ir a: /ORT/Cloud/ORT_obligatorio_isc_2023/terraform
       Hacer "Terraform init" para iniciallizar el directorio de trabajo de terraform
       Finalmente ejecutar: "terraform apply -var-file=valores.tfvars" para que se carguen los valores de las variables ya definidos.
        
**Nota** Para la implementación de este proyecto no se realizó el almacenamiento de estado remoto. La razón fue evitar perder tiempo en una configuración que, si bien proporciona seguridad y es lo correcto, llevaria tiempo que se prefirió invertir en el proyecto mismo ya que habria que crear otro proyecto separado. Se entiende que en la vida real el método a usar debería ser configurando el almacenamiento de estado remoto.

La documentacion usada durante el proyecto fue la sigueiente:
- https://aulas.ort.edu.uy/
- https://terraform-docs.io/
- https://docs.docker.com/
- https://chat.openai.com/
- http://nginx.org/

