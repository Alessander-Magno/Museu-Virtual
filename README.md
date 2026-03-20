# Instruções do Next

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.

# Minhas instruções

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

## Link para as ferramentas utilizadas:
  - [Download VSCode](https://code.visualstudio.com/Download)
  - [Download Git](https://git-scm.com/)
  - [Download NodeJs](https://nodejs.org/en/download)
  - [Download Flutter](https://docs.flutter.dev/install)

Obs.: os links irão abrir nessa mesma aba, portanto recomendo que faça: "CTRL" + click do mouse, que fará com que o link seja aberto numa outra aba.
