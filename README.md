# Painel do Diretor — Norman Film Crew

App de gestao de demandas, agenda, financeiro e gastos para producao de video.
Os dados agora ficam num banco de dados real (Supabase), sincronizado
automaticamente entre qualquer aparelho.

## 1. Configure o Supabase (uma vez só)

1. Crie uma conta gratis em supabase.com e um novo projeto.
2. Va em "SQL Editor" -> "New query", cole o conteudo do arquivo
   supabase-setup.sql (nesta mesma pasta) e clique em Run. Isso cria as
   tabelas do app.
3. Va em "Project Settings" -> "API". Copie o "Project URL" e a chave
   "anon public".
4. Nesta pasta do projeto, copie o arquivo .env.example para um novo
   arquivo chamado .env, e cole os dois valores:

   VITE_SUPABASE_URL=https://seu-projeto.supabase.co
   VITE_SUPABASE_ANON_KEY=sua-chave-anon-aqui

   O arquivo .env nunca deve ser enviado ao GitHub (ja esta no .gitignore).

## 2. Testar no seu computador

Pre-requisito: Node.js instalado (versao 18 ou mais recente).

npm install
npm run dev

Abra o endereco que aparecer no terminal (geralmente http://localhost:5173).

## 3. Login

O app pede usuario e senha antes de abrir. As credenciais padrao estao no
inicio do arquivo src/App.jsx, na constante CREDENCIAIS:

const CREDENCIAIS = { usuario: 'norman', senha: 'filmcrew2026' };

Troque isso antes de publicar. Esse login e uma trava simples do lado do
navegador, nao e autenticacao segura de verdade — quem ve o codigo-fonte
consegue ver a senha. Os DADOS, porem, ja estao protegidos de verdade no
Supabase (nao dependem dessa senha).

## 4. Sincronizacao entre aparelhos

Agora sim, os dados sao compartilhados: o que voce cadastra no computador
aparece no celular (e vice-versa) automaticamente, sem precisar atualizar a
pagina — o app escuta mudancas em tempo real.

## 5. Excluir itens

Demandas, lancamentos do Financeiro e gastos podem ser excluidos, sempre com
confirmacao antes. Excluir uma demanda remove junto o lancamento financeiro
ligado a ela (o banco cuida disso sozinho).

## 6. Publicar online (Vercel — gratis)

1. Crie uma conta em github.com e em vercel.com.
2. Suba esta pasta para um repositorio no GitHub:
   git init
   git add .
   git commit -m "primeira versao do painel"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/painel-diretor.git
   git push -u origin main
3. Na Vercel, clique em Add New -> Project, selecione o repositorio.
4. ANTES de clicar em Deploy, va em "Environment Variables" e adicione
   VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY com os mesmos valores do seu
   arquivo .env local. Sem isso o site publicado nao vai conseguir acessar
   o banco de dados.
5. Clique em Deploy. Em poucos minutos voce recebe um link publico.

## Proximo passo opcional: login de verdade

O login atual e uma trava simples. Se no futuro isso precisar ser seguro de
verdade (por exemplo, times diferentes com permissoes diferentes), o Supabase
tambem resolve isso com Supabase Auth — e um passo a mais, nao incluido
nesta versao.

## Estrutura

src/
  App.jsx            -> todo o painel (Login, Demandas, Agenda, Financeiro, Gastos)
  supabaseClient.js   -> conexao com o banco de dados
  main.jsx            -> ponto de entrada do React
  index.css           -> estilos globais (Tailwind)
supabase-setup.sql    -> script para criar as tabelas no Supabase
