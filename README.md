<p align="center">
<img src="src/frontend/static/icons/maxresdefault.jpg" width="300" alt="Online Boutique" />
  
</p>


![Continuous Integration](https://github.com/GoogleCloudPlatform/microservices-demo/workflows/Continuous%20Integration%20-%20Main/Release/badge.svg)

> **⚠ ATTENTION: Apache Log4j 2 advisory.**  
> Due to [vulnerabilities](https://cloud.google.com/log4j2-security-advisory) present in earlier versions
> of Log4j 2, we have taken down all affected container images. We highly recommend all demos and forks to now
> use images from releases [>= v0.3.4](https://github.com/GoogleCloudPlatform/microservices-demo/releases).

The application MJ Sports is a demo of a cloud-native microservices architecture. It is made of an 11-tier microservices application, 
which is a sophisticated web-based e-commerce platform. Whithin this platform, customers experience a seamless shopping experience,
allowing them to browse through a wide range of sports items. While browsing through the application, customeres will be able to add desired
products to their shopping cart, and complete their purchases securily and easily. 
With this application, MJ Sports satisfies the needs of their customers and provide them with a user-friendly interface. 
This technology also permits scalability, resilience and the agility that's so much needed in modern applications' development.

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

MJ Sports consists of 11 microservices implemented in various programming languages, these different languages communicate with each other trhough gRPC.
gRPC is designed to facilitate the communication between different services in a distributed environment, and it supports several different programming languages.

MJ Sports está compuesto por 11 microservicios implementados en varios lenguajes de programación. Estos diferentes lenguajes se comunican entre sí a través de gRPC.
gRPC está diseñado para facilitar la comunicación entre diferentes servicios en un entorno distribuido, y admite varios lenguajes de programación diferentes.

To learn more about the project's development principles, please refer to the documentation available in the Development Principles document.


[![Architecture of
microservices](./docs/img/architecture-diagram.png)](./docs/img/architecture-diagram.png)

Find **Protocol Buffers Descriptions** at the [`./pb` directory](./pb).

| Service                                              | Language      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](./src/frontend)                           | Go            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](./src/cartservice)                     | C#            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](./src/productcatalogservice) | Go            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](./src/currencyservice)             | Node.js       | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](./src/paymentservice)               | Node.js       | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](./src/shippingservice)             | Go            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](./src/emailservice)                   | Python        | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](./src/checkoutservice)             | Go            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](./src/recommendationservice) | Python        | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](./src/adservice)                         | Java          | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](./src/loadgenerator)                 | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.                                              |
