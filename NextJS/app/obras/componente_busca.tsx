'use client';

import Link from 'next/link';
import Image from "next/image";
import { useState } from 'react';
import styles from '../../app/css/Home.module.css';
import { Search, Trash2, Pencil } from 'lucide-react';

export default function ComponenteBusca( { obras }: any ) {
    const [ busca, setBusca] = useState('');

    const filtrada = obras.filter(
        (obra: any) => obra.title.toLowerCase().includes(busca.toLowerCase())
    ); 

  return (
   <div className="px-50">

    <input type="text" placeholder='Buscar obras' value={busca} onChange={(e) => setBusca(e.target.value)} className="border p-2 mb-6 rounded"/>

    {
      (filtrada.length === 0) 
        ? (<p className={`styles.text mb-6`}>Nenhuma obra cadastrada com esse nome</p>) 
        : (
        filtrada.map((obra: any) => (
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
            </div>
          
          </div>
        ))
      )
    }  

      <div className='flex gap-4'>
        <Link href='/' className={styles.navButton}>Voltar</Link>
      </div>
    
    </div> 
  );
}
