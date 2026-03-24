## Passo a Passo para o projeto funcionar:
Obs.: irei considerar que você clonou o repositório, baixou as expansões necessárias em sua IDE e por fim que você já possui o flutter e o node instalados corretamente. Em relação as dependências do flutter ou next a sua IDE deve baixar automaticamente ao abrir o projeto ou ao tentar executa-lo.

1. Na raiz da pasta do Next, crie um arquivo: '.env' (sem as aspas)
2. No arquivo '.env' adicione a variável:
```bash
DATABASE_URL="sua_url_de_conexao_com_o_banco_de_dados_no_Prisma"
```
Obs.: para obter a url de conexão do banco de dados no Prisma será necessário pedir ao senhorio do repositório, vulgo eu. Ou você pode criar seu próprio banco de dados no Prisma baseado nos esquemas que estão na pasta Next. 

3. No terminal, ainda na pasta do Next, execute o comando:
```bash
npm install --save-dev prisma dotenv
```

4. Em seguida, execute o comando:
```bash
npx prisma generate
```

4. Por fim, execute o comando que irá iniciar o servidor:
```bash
npm run dev
```
Obs.: fique sempre atento ao terminal para o caso de surgir algum problema.

5. Agora na raiz da pasta do flutter, basta apenas você abrir o terminal e digitar o comando:
```bash
flutter run -d chrome
```
Obs.: isso irá rodar o flutter na sua versão web no chrome.

## Informações pertinentes:
1. Para que o flutter consiga interagir com a api, é necessário ligar o servidor (indo na pasta Next e digitando o comando: npm run dev)
2. Na pasta Next há tanto a api para interagir com o banco de dados no Prisma, quanto um front em next.js, ou seja, ao rodar o servidor tanto a api quanto o front estarão ativos.
   
      2.1. Para visualizar o front você precisa digitar essa url no seu navegador: http://localhost:3000
   
      Obs.: a porta (valor padrão = 3000) pode mudar, portanto é aconselhável você pegar essa url no terminal onde você rodou o servidor  

## Link para as ferramentas utilizadas:
  - [Download VSCode](https://code.visualstudio.com/Download)
  - [Download Git](https://git-scm.com/)
  - [Download NodeJs](https://nodejs.org/en/download)
  - [Site do Prisma](https://www.prisma.io/)
  - [Download Flutter](https://docs.flutter.dev/install)

Obs.: os links irão abrir nessa mesma aba, portanto recomendo que faça: "CTRL" + click do mouse, que fará com que o link seja aberto numa outra aba.
