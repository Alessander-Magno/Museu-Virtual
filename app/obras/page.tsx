import Link from 'next/link';
import Image from "next/image";
import styles from '../../app/css/Home.module.css';
import { Search, Trash2, Pencil } from 'lucide-react';

export default async function AtracaoPage() {
  const res = await fetch("http://localhost:3000/api/obras");
  const obras = await res.json();
  
  return (
   <div className="px-50">

    <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Obras</h1>

    {
     (obras.length === 0) ? (<p className={styles.text}>Nenhuma obra cadastrada no momento</p>) : (
        obras.map((obra: any) => (
        <div key={obra.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

          <div>
            <h2>Titulo: {obra.title}</h2>
            <p>Descrição: {obra.description}</p>
            <p>Autor(a): {obra.autor}</p>
          </div>

          <div className='flex gap-4'>
            <Link href={`/obras/buscar/${obra.id}`}>
              <Search size={'20'} height={'30'}></Search>
            </Link>
            <Link href={`/obras/deletar/${obra.id}`}>
              <Trash2 size={'20'} height={'30'}></Trash2>
            </Link>
            <Link href={`/obras/atualizar/${obra.id}`}>
              <Pencil size={'20'} height={'30'}></Pencil>
            </Link> 
          </div>
        
        </div>
      ))
     )
    }

     <div className='flex gap-4'>
      <Link href='/' className={styles.navButton}>Voltar</Link>
      <Link href='/obras/cadastrar' className={styles.navButton}>Cadastrar Obra</Link>
    </div>

   </div>
  );
}
