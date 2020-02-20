# Dia 04 - Acesso a dados

Tópicos que iremos ver

* Acesso aos dados
* Banco de dados
* Entity Framework
* Contexto e Migrations
* Selects, Inserts, Deletes e Updates utilizando o EF Core

# Acesso aos dados

Para uma aplicação funcionar corretamente é necessário fazer o acesso aos dados para obter as informações, e na maioria das vezes é um banco de dados. Existem inúmeros banco de dados hoje para atender a cada uma das necessidades das aplicações. Existem banco de dados relacionais (Oracle, SQL Server, MySQL, PostgreSQL, etc) e banco de dados não relacionais (MongoDB, Cassandra, etc). Não iremos entrar nos detalhes nesse treinamento já que não vamos focar em banco de dados, mas é importante todos terem conhecimento sobre esse assunto.

Para podermos dar continuidade com o treinamento, precisamos configurar um banco de dados local.

# Banco de dados

Para fazermos algumas brincadeiras com os dados de um banco precisamos primeiro ter um banco de dados rodando localmente. Para isso iremos executar o comando abaixo para rodar um banco de dados SQL Server

`docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Teste_123456' -p 1433:1433 -d mcr.microsoft.com/mssql/server:latest`

Para garantir que o banco de dados está rodando corretamente iremos acessa-lo utilizando a ferramenta Azure Data Studio encontrado no link:

[https://docs.microsoft.com/pt-br/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15](https://docs.microsoft.com/pt-br/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)

Para acessar o banco de dados, vamos utilizar as informações abaixo:

Server: **localhost**

User Name: **sa** 

Password: **Teste_123456** 

Para testar que tudo está ok, vamos executar os passos abaixo

- Botão direito em `localhost` > `New Query`
- `SELECT 1` > `Run`

Pronto! nosso banco de dados está rodando localmente.

# Entity Framework Core

Agora que nosso banco de dados já está funcionando localmente, vamos entender como vamos trabalhar com essas informações.

A Microsoft disponibiliza um framework chamado Entity Framework Core que possibilita o desenvolvedor trabalhar com informações do banco dados usando objetos .NET e eliminando a maior parte do trabalho relacionado a escrever códigos para acessar o banco de dados que são mais conhecidos como scripts SQL.

O acesso a dados do EF Core é feito através de **Models**, que representa uma Entidade (Tabela), e um contexto **DbContext** que representa a sessão com o banco de dados, assim permitindo efetuar selects, inserts, updates e deletes de registros no banco de dados direto pelo código sem utilizar nenhuma linha de scripts SQL.

Para podermos brincar com alguns dados no nosso banco de dados vamos ter que criar um novo projeto que iremos utilizar ao longo do treinamento e fazer as configurações para o EF Core funcionar corretamente.

Mão na massa!

# Criando um projeto Console do .NET Core e configurando o Entity Framework Core

Para verificar se o ASP.NET Core SDK 3.1 já está instalado na máquina utilize o comando abaixo

`dotnet --version`

Caso a versão do SDK não seja a `3.1.101` efetuar o download e a instação do SDK pelo link:
[https://dotnet.microsoft.com/download/dotnet-core/3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1)

Para podermos configurar o Entity Framework e entendermos como ele trabalha vamos criar um projeto Console Application utilizando o comando abaixo

`dotnet new console -o PrimeiroContatoEntityFramework`

Para validar que o projeto está funcionando, vamos executar o comando abaixo

`dotnet run`

Agora que nosso projeto está criado vamos começar a configurar nosso código para podermos trabalhar com o Entity Framework Core. Para isso vamos começar instalando as dependências que o .Net Core precisa para utilizar o EF

`dotnet add package Microsoft.EntityFrameworkCore.SqlServer`

`dotnet add package Microsoft.EntityFrameworkCore.Design`

**[1]** Agora chegamos no momento onde precisamos criar nossos modelos que representam as tabelas do nosso banco de dados, para isso vamos criar as entidades **Mural** e **Post** em um novo arquivo chamado **Models.cs**

**[2]** Em seguida precisamos configurar o contexto do banco de dados. O contexto é a classe onde contêm todas as entidades do banco de dados e também é quem cria a sessão do usuário com o banco para poder obter e alterar os dados.

***Dica**: as entidades devem ser configuradas como **DbSet** no Contexto.

**[3]** Agora precisamos sobrescrever o método **OnConfiguring** que é necessário para a configuração da string de conexão do banco para o EF conseguir se conectar no nosso banco de dados.

***Dica**: utilizar a string de conexão `Server=localhost;Database=StarWars;User Id=sa;Password=Teste_123456;`

# Migrations

O recurso de migrações no EF Core oferece uma maneira de atualizar de forma incremental o esquema de banco de dados para mantê-lo em sincronia com o modelo de dados do nosso aplicativo, preservando os dados existentes no banco de dados.

Para o migrations funcionar iremos primeiro instalar a ferramenta do Entity Framework Core  executando o código abaixo

`dotnet tool install --global dotnet-ef`

**Obs**: Caso a instalação apresente o problema de variável de ambiente PATH, precisamos adicionar a pasta `/.dotnet/tools` na variável de ambiente.

Agora iremos executar o comando para criar a nossa primeira versão de migração que irá criar o nosso banco de dados com o nome presente em nossa string de conexão `StarWars` e também criar as tabelas que são referentes as entidades que criamos anteriormente

`dotnet ef migrations add CriacaoInicial`

Agora podemos ver que foi criada uma pasta em nosso projeto chamada `Migrations`. Nessa pasta existe todo o histórico de alterações de nossos modelos de entidades para que o EF consiga controlar as alterações de estrutura do banco e efetuar as migrações.

Agora vamos executar o comando para o EF Core criar o banco de dados e a estrutura de nossas entidades.

`dotnet ef database update`

Agora olhando para o nosso cliente do Azure Data Studio podemos ver que o banco de dados foi criado e também todas as tabelas com todos os campos que especificamos em nossas entidades no arquivo **Models.cs**.

Agora podemos começar a brincarmos com registros em nossas novas tabelas.

# Efetuando Selects, Inserts, Deletes e Updates

**[1]** Agora vamos evoluir nosso método `Main` para buscar todos os posts do nosso banco de dados utilizando o **StarWarsContext**.

**[2]** Agora vamos incluir um post com o título **Teste** e conteúdo **Testando inclusão de post**. 

***Dica**: sempre que ocorrer alguma ação de inclusão, atualização ou remoção de registros devemos utilizar o método **SaveChanges()** para persistir essa ação no banco de dados. 

**[3]** Agora vamos melhorar nosso código adicionando uma verificação para não incluir um novo mural com o nome repetido, e caso exista adicione o novo post para o mural já existente.

**[4]** Para termos um controle melhor do nosso mural vamos adicionar a regra de que que devemos remover o post mais antigo para cada nova inclusão se já existir mais que 5 posts no mural.

**[5]** Agora vamos evoluir nosso mural para que tenhamos a informação da última atualização. A atualização deve ocorrer sempre que um novo post seja criado no mural.

**[6]** Refatorar o código
