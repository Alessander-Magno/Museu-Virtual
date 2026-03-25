'use client';

import Link from 'next/link';
import Image from "next/image";
import { useState } from 'react';
import styles from '../../app/css/Home.module.css';
import { Search, Trash2, Pencil } from 'lucide-react';

export default function ComponenteBusca( { atracoes }: any ) {
    const [ busca, setBusca] = useState('');

    const filtrada = atracoes.filter(
        (atracao: any) => atracao.nome.toLowerCase().includes(busca.toLowerCase())
    ); 

  return (
   <div className="px-50">

    <input type="text" placeholder='Buscar atrações' value={busca} onChange={(e) => setBusca(e.target.value)} className="border p-2 mb-6 rounded"/>

    {
        (filtrada.length === 0) 
        ? (<p className={`styles.text mb-6`}>Nenhuma atração cadastrada com esse nome</p>) 
        : (
          filtrada.map((atracao: any) => (
          <div key={atracao.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

            <div>
              <h2>Nome: {atracao.nome}</h2>
              <p>Descrição: {atracao.description}</p>
              <p>Disponivel: {atracao.disponibilidade ? "sim" : 'não'}</p>
            </div>

            <div className='flex gap-4'>
              <Link href={`/atracoes/buscar/${atracao.id}`}>
                <Search size={'20'} height={'30'}></Search>
              </Link>
              <Link href={`/atracoes/deletar/${atracao.id}`}>
                <Trash2 size={'20'} height={'30'}></Trash2>
              </Link>
              <Link href={`/atracoes/atualizar/${atracao.id}`}>
                <Pencil size={'20'} height={'30'}></Pencil>
              </Link> 
            </div>
          
          </div>
          ))
        ) 
    }  

    <div className='flex gap-4'>
      <Link href='/' className={styles.navButton}>Voltar</Link>
      <Link href='/atracoes/cadastrar' className={styles.navButton}>Cadastrar Atração</Link>
    </div>

   </div>
  );
}
