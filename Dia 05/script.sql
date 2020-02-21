
-- GERANDO UMA CARGA INICIAL

insert into Aliancas (Nome)
values ('Aliança Rebelde')

insert into Membros (AliancaId, Nome)
values (1, 'Luke Skywalker')

insert into Murais (Nome, DataAtualizacao)
values ('Comunicação dos rebeldes', null)

-- CRIANDO UM POST MANUAL PARA TESTAR NOSSA API

insert into Posts (MuralId, MembroId, Conteudo, DataCriacao)
values (1, 1, 'Teste Post', getdate())