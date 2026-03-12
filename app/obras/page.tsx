import Link from 'next/link';
import Image from "next/image";
import styles from '../../app/css/Home.module.css';

export default async function AtracaoPage() {
  const res = await fetch("http://localhost:3000/api/obras");
  const obras = await res.json();
  
  return (
   <div className="px-50">

    <h1 className="text-4xl font-bold text-center font-serif mb-10">Obras</h1>

    {obras.map((obra: any) => (
      <div key={obra.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

        <div>
          <h2>Titulo: {obra.title}</h2>
          <p>Descrição: {obra.description}</p>
          <p>Autor(a): {obra.autor}</p>
        </div>

        <div className='flex gap-4'>
          <Link href={`/obras/buscar/${obra.id}`}>
          🔎
          </Link>
          <Link href={`/obras/deletar/${obra.id}`}>
          🗑
          </Link>
          <Link href={`/obras/atualizar/${obra.id}`}>
          ✏ 
          </Link> 
        </div>
      
      </div>
    ))}

    <div className='flex gap-4'>
      <Link href='/' className={styles.navButton}>Voltar</Link>
      <Link href='/obras/cadastrar' className={styles.navButton}>Cadastrar Obra</Link>
    </div>

   </div>
  );
}
