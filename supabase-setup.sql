-- Tabela de demandas (projetos/trabalhos)
create table demandas (
  id bigint generated always as identity primary key,
  cliente text not null,
  projeto text not null,
  etapa text not null,
  prazo date not null,
  status text not null,
  data_gravacao date,
  valor numeric not null default 0,
  com_nf boolean not null default false,
  created_at timestamptz not null default now()
);

-- Tabela financeira (a receber / concluídos)
create table financas (
  id bigint generated always as identity primary key,
  cliente text not null,
  projeto text not null,
  valor numeric not null default 0,
  valor_bruto numeric,
  com_nf boolean not null default false,
  data_trabalho date not null,
  data_pagamento date not null,
  pago boolean not null default false,
  origem_demanda_id bigint references demandas(id) on delete cascade,
  created_at timestamptz not null default now()
);

-- Tabela de gastos (ligados a um projeto)
create table gastos (
  id bigint generated always as identity primary key,
  projeto text not null,
  cliente text not null,
  descricao text not null,
  valor numeric not null default 0,
  data date not null,
  created_at timestamptz not null default now()
);

-- Habilita segurança em nível de linha (exigido pelo Supabase)
alter table demandas enable row level security;
alter table financas enable row level security;
alter table gastos enable row level security;

-- Como o app já tem sua própria tela de login, liberamos leitura/escrita
-- para quem tiver a chave pública do projeto (é assim que o app vai acessar).
create policy "permitir tudo em demandas" on demandas for all using (true) with check (true);
create policy "permitir tudo em financas" on financas for all using (true) with check (true);
create policy "permitir tudo em gastos" on gastos for all using (true) with check (true);

-- Liga a atualização em tempo real (pra sincronizar entre aparelhos)
alter publication supabase_realtime add table demandas;
alter publication supabase_realtime add table financas;
alter publication supabase_realtime add table gastos;
