import Link from 'next/link';
import Image from "next/image";
import styles from '../../app/css/Home.module.css';

export default async function AtracaoPage() {
  const res = await fetch("http://localhost:3000/api/atracoes");
  const atracoes = await res.json();
  
  return (
   <div className="px-50">

    <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Atrações</h1>

    {atracoes.map((atracao: any) => (
      <div key={atracao.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

        <div>
          <h2>Nome: {atracao.nome}</h2>
          <p>Descrição: {atracao.description}</p>
          <p>Disponivel: {atracao.disponibilidade ? "sim" : 'não'}</p>
        </div>

        <div className='flex gap-4'>
          <Link href={`/atracoes/buscar/${atracao.id}`}>
          🔎
          </Link>
          <Link href={`/atracoes/deletar/${atracao.id}`}>
          🗑
          </Link>
          <Link href={`/atracoes/atualizar/${atracao.id}`}>
          ✏ 
          </Link> 
        </div>
      
      </div>
    ))}

    <div className='flex gap-4'>
      <Link href='/' className={styles.navButton}>Voltar</Link>
      <Link href='/atracoes/cadastrar' className={styles.navButton}>Cadastrar Atração</Link>
    </div>

   </div>
  );
}
