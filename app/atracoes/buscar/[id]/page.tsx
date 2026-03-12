import Link from 'next/link';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

interface Params {
    params: Promise<{
        id: string,
    }>;
}

export default async function AtracaoPage( { params }: Params ) {
    const { id } = await params;
    const res = await fetch(`http://localhost:3000/api/atracoes/${id}`);
    const atracao = await res.json();
  
    return (
    <div className="px-30">

        <h1 className="text-4xl font-bold text-center font-serif mb-10">{atracao.nome}</h1>

        <div key={atracao.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

        <div>
            <h2>Nome: {atracao.nome}</h2>
            <p>Descrição: {atracao.description}</p>
            <p>Disponivel: {atracao.disponibilidade ? "sim" : 'não'}</p>
        </div>
        
        <div>
            {atracao.obras.map((obra: any, indice: number ) => ( 
                <div key={obra.id} className="border rounded p-3 mb-3 bg-gray-50">
                    <h2 className="bg-gray-50">Obra n°{indice+1}</h2>
                    <h2 className="bg-gray-50">Titulo: {obra.title}</h2>
                    <p>Descrição: {obra.description}</p>
                    <p>Autor: {obra.autor}</p>
                </div>
            ))}
        </div>

        </div>

        <div className='flex gap-4'>
        <Link href='/atracoes' className={styles.navButton}>Voltar à atrações</Link>
        </div>

    </div>
  );
}
