
# Dia 05 - Serviços

Tópicos que iremos ver

* Api
* Verbos HTTP no REST
* Tratamento de erros usando Middleware
* Logger
* Configurando o Swagger
* CORS

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

Além dos recursos, o outro princípio do REST é a utilização dos verbos HTTP. Os verbos HTTP mais utilizados nas API's são **GET, POST, PUT e DELETE** e cada um deles podem retornar um conjunto específico de retornos.

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

**Mão na massa!**

1. Vamos criar um projeto Web API, para isso vamos utilizar o comando abaixo

    `dotnet new webapi -o api`

2. Agora vamos validar se a API está funcionando utilizando o comando abaixo para rodar a aplicação

    `dotnet run`

3. Agora vamos acessar a URL abaixo no browser

    `https://localhost:5001/weatherforecast`

**Obs**: Também podemos utilizar o Postman para efutuar as requisições, mas precisamos desativar a verificação de SSL senão ele barra as requisições via HTTPS.

# Configurando o acesso ao banco no projeto

Conforme já aprendemos antes, vamos configurar o EF Core nesse novo projeto para podermos efetuar todo o passo de criar o banco de dados novamente para que nossa aplicação tenha as tabelas que vamos precisar.

**Mão na massa!**

1.  Agora vamos adicionar as entidades seguindo o modelo abaixo. Vamos criar uma nova pasta chamada **Models** na raiz do projeto onde vamos criar todas as entidades em arquivos separados.

    ![Modelo de dados](https://github.com/Netaum/cit-treinamento-dotnet-2020/blob/master/Dia%2005/tables.png)

2. Agora vamos criar o contexto dentro de uma nova pasta chamada **Data** na raiz do projeto. 

3. Agora precisamos configurar o contexto com a string de conexão no arquivo **Startup.cs** de nossa API. É muito importante que a string de conexão fique no arquivo **AppSettings.json** por questões de segurança e padronização.

    ***Ajuda**: Para fazer a configuração do contexto em um projeto Web API precisamos adicionar o código abaixo no método **ConfigureService**

    ```
    services.AddDbContext<StarWarsContext>(options => options
        .UseSqlServer(Configuration.GetConnectionString("StarWarsDatabase"))
        .UseLazyLoadingProxies());
    ```

    Também precisamos instalar uma nova dependencia para o LazyLoading funcionar que é o método responsável pelo carregamento automático das entidades relacionadas ao modelo.

    `dotnet add package Microsoft.EntityFrameworkCore.Proxies`

    Esse código efetua o registro do nosso contexto nos serviços gerenciados pela injeção de dependencias.

4. Agora vamos gerar os arquivos de migration e atualizar nosso banco de dados.

# Criando os serviços

Vamos recapitular sobre os recursos REST e os verbos HTTP ... devemos criar recursos referente as informações de nossa aplicação e utilizar o verbo correto para obter dados, inserir, atualizar e remover. Com esse pensamento vamos criar nossos serviços.

**Mão na massa!**

1. Agora vamos criar um novo recurso de posts com dois serviços, um serviço que retorne todos os posts criados e outro serviço que retorne um post específico a partir do id. É importante retornar todas as informações sobre o post e o membro que fez a publicação.

2. Agora vamos executar o script.sql para efetuar uma carga inicial no banco de dados e em seguida vamos fazer requisições no nosso recurso de posts.

3. Agora vamos criar um novo serviço de inclusão de post no recurso de posts.

4. Agora vamos criar um novo recurso de murais com os serviços de obter todos murais, obter mural por id e um serviço para atualizar a data de atualização do mural.

5. Agora vamos criar um novo recurso para os membros com os serviços de obtenção, inclusão, atualização e remoção.

6. Agora vamos criar um novo recurso para as alianças também com os serviços básicos.

Pronto! Agora que temos a base dos nossos recursos podemos seguir com os tratamentos de erros.

# Tratamentos de erros usando Middleware

Para alguns cenários específicos podemos ter erros em nossa aplicação e normalmente os erros são mensagens grandes e mostram todo a pilha de exceção de onde o erro ocorreu, agora imaginem isso sendo apresentado para o usuário.

Para tratar os erros internos de nossa aplicação de uma forma mais elegante e sem replicar muito código usando try catch em todos os métodos  iremos utilizar a técnica de criar um middleware de exceções em nossa API.

Os middlewares foram criados para podermos modularizar nossa aplicação criando um fluxo de execução como se fosse um pipeline, conseguimos configurar vários níveis tanto na ida quanto na volta das requisições na API.

**Mão na massa!**

1. Vamos criar um middleware de exceções que irá tratar as mensagens de erro de todos os recursos.

# Logger

Agora que fizemos o tratamento dos erros internos e não estamos mais exibindo o erro completo e toda a sua pilha de exceção é muito importante que tenhamos um mecanismo de log para que a equipe de desenvolvimento tenha acesso ao erro de verdade e não apenas a mensagem tratada.

Para isso iremos configurar o log para exibição no console da aplicação.

**Mão na massa!**

1. Vamos configurar o log em nosso HostBuilder da API que se encontra no arquivo **Program.cs**.

2. Agora vamos fazer a injeção de dependencia da interface **ILogger** onde iremos utiliza-la para logar os erros.

# Configurando o Swagger

Conforme aprendemos anteriormente as API`s são interfaces de minha aplicação que podem ser consumidas por inúmeros meios, Mobile, Web, etc. Com isso é indispensável termos uma documentação de cada recurso e verbos disponíveis. 

Para nos ajudar com isso vamos utilizar uma ferramenta chamada Swagger. Essa ferramenta foi criada para gerar uma documentação completa de todos os serviços disponíveis em minha aplicacão com uma interface gráfica que podemos até fazer testes reais em nossos recursos.

**Mão na massa!**

1. Primeiro precisamos instalar o pacote utilizando o comando abaixo

    `dotnet add package Swashbuckle.AspNetCore`

2. Agora vamos configurar o swagger no arquivo **Startup.cs**.

3. Agora após rodar a aplicação vamos acessar a url abaixo

    `https://localhost:5001/swagger`

# CORS

O CORS que refere-se a **Cross-origin resource sharing (compartilhamento de recursos de origem cruzada)** é uma especificação de navegadores que define meios para o servidor permitir que seus recursos sejam acessados por uma página web de um domínio diferente. No nosso caso como estamos rodando a aplicação no ambiente local precisamos falar ao servidor que permitimos que o navegador no endereço localhost pode consumir meus recursos.

**Mão na massa!**

1. Vamos adicionar o código abaixo no arquivo **Startup.cs**

    ```
    services.AddCors(options =>
        {
            options.AddPolicy("AllowAllOrigins", builder =>
            {
                builder.AllowAnyOrigin();
                builder.AllowAnyHeader();
                builder.AllowAnyMethod();
            });
        });
    ```

    ```
    app.UseCors("AllowAllOrigins");
    ```

Com isso falamos para o servidor que todas as requisições de qualquer tipo de origem está permitida.

# Refatorando o código

1. 