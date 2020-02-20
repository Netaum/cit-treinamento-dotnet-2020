# Dia 05 - Serviços

Tópicos que iremos ver

* Api
* Verbos HTTP no REST
* Tratamento de erros

# O que é API

API's são formas de integrar sistemas, são um tipo de “ponte” que conectam aplicações, podendo ser utilizadas para os mais variados tipos de negócio. A sigla API refere-se ao termo **Application Programming Interface (Interface de Programação de Aplicativos)**.

As API's são baseadas no padrão REST que refere-se ao termo **Representational State Transfer (Transferência Representacional de Estado)** que é um estilo de arquitetura que define um conjunto de restrições para serem usadas na criação de serviços web utilizando verbos HTTP.

Um dos princípios do REST é a utilização de recursos. Um recurso é uma abstração de determinada informação da minha aplicação e por padrão um recurso deve possuir um identificador único.

Essa identificação de recurso deve seguir o conceito de URI que é basicamente o contrato que o cliente deverá utilizar para acessar determinadas informações da minha aplicação.

Exemplos de recursos

`https://swapi.co/api/people`

`https://swapi.co/api/planets`

`https://swapi.co/api/starships`

# Verbos HTTP em serviços REST

Além dos recursos, o outro princípio do REST é a utilização dos verbos HTTP.  Os verbos HTTP mais utilizados nas API's são **GET, POST, PUT e DELETE** e cada um deles podem retornar um conjunto específico de retornos.

Verbo **GET** - específico para efetuar requisições onde o cliente vai obter dados de um recurso.
Normalmente retornam os status **200, 400, 401, 404 e 500**

Verbo **POST** - específico para efetuar requisições onde o cliente vai criar um novo recurso.
Normalmente retornam os status **201, 400, 401, 404 e 500**

Verbo **PUT** - específico para efetuar requisições onde o cliente vai atualizar algum recurso.
Normalmente retornam os status **204, 400, 401, 404 e 500**

Verbe **DELETE** - específico para efetuar requisições onde o cliente vai remover algum recurso.
Normalmente retornam os status **204, 400, 401, 404 e 500**

Podemos visualizar a lista de todos os códigos de retorno abaixo

[https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status)

Agora que já sabemos um pouco mais sobre as API`s e os serviços REST, bora criar nosso projeto.

Mão na massa!

# Criando um projeto ASP.NET Core API

Para criar um projeto Web API vamos utilizar o comando abaixo

`dotnet new webapi -o api`

Para validar se a API está funcionando, vamos executar o comando abaixo

`dotnet run`

Agora vamos acessar a URL abaixo no browser

`https://localhost:5001/weatherforecast`

**Obs**: Para utilizar o Postman para efetuar as requisições precisamos desativar a verificação de SSL

Conforme já aprendemos antes, vamos configurar o EF Core nesse novo projeto para podermos efetuar todo o passo de criar o banco de dados novamente para que nossa aplicação tenha as tabelas que vamos precisar.

**[1]** Agora vamos adicionar as entidades seguindo o modelo abaixo


**[2]** Agora vamos configurar o contexto e a string de conexão.
**Dica**: Para configurar a string de conexão em um projeto Web API precisamos adicionar o código abaixo no arquivo **Startup.cs**

``

# Criando os serviços

