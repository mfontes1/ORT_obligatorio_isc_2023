<p align="center">
<img src="src/frontend/static/icons/maxresdefault.jpg" width="300" alt="Online Boutique" />
  
</p>


![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

> **⚠ ATTENTION: Apache Log4j 2 advisory.**  
> Due to [vulnerabilities](https://cloud.google.com/log4j2-security-advisory) present in earlier versions
> of Log4j 2, we have taken down all affected container images. We highly recommend all demos and forks to now
> use images from releases [>= v0.3.4](https://github.com/GoogleCloudPlatform/microservices-demo/releases).

La aplicación MJ Sports es una demostración de una arquitectura de microservicios nativa de la nube. Está compuesta por una aplicación
de microservicios de 11 niveles, la cual es una sofisticada plataforma de comercio electrónico basada en la web. Dentro de esta plataforma,
los clientes experimentan una experiencia de compra sin problemas, lo que les permite navegar por una amplia gama de artículos deportivos.
Mientras navegan por la aplicación, los clientes podrán agregar los productos deseados a su carrito de compras y completar sus compras de
forma segura y fácil. Con esta aplicación, MJ Sports satisface las necesidades de sus clientes y les proporciona una interfaz fácil de usar.
Esta tecnología también permite la escalabilidad, resiliencia y la agilidad que son tan necesarias en el desarrollo de aplicaciones modernas.


## Screenshots

| Home Page                                                                                                         | Checkout Screen                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](.docs/img/maxresdefault.jpg)](.docs/img/maxresdefault.jpg) | [![Screenshot of checkout screen](.docs/img/maxresdefault.jpg)](.docs/img/maxresdefault.jpg) |

## Architecture

MJ Sports está compuesto por 11 microservicios implementados en varios lenguajes de programación. Estos diferentes lenguajes se comunican entre sí a través de gRPC.
gRPC está diseñado para facilitar la comunicación entre diferentes servicios en un entorno distribuido, y admite varios lenguajes de programación diferentes.


[![Architecture of
microservices](./docs/img/architecture-diagram.png)](./docs/img/architecture-diagram.png)

Find **Protocol Buffers Descriptions** at the [`./pb` directory](./pb).

| Service                                              | Language      | Description                                                                                                                       |
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
| [loadgenerator](./src/loadgenerator)                 | Python/Locust | Envía solicitudes continuamente imitando flujos reales de compras de usuarios al frontend.                                        |

