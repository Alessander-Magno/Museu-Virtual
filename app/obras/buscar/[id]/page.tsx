import Link from 'next/link';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

interface Params {
    params: Promise<{
        id: string,
    }>;
}

export default async function ObraPage( { params }: Params ) {
    const { id } = await params;
    const res = await fetch(`http://localhost:3000/api/obras/${id}`);
    const obra = await res.json();
  
    return (
    <div className="px-30">

        <h1 className="text-4xl font-bold text-center font-serif mb-10">{obra.title}</h1>

        <div key={obra.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

        <div>
            <p>ID: {obra.id}</p>
            <p>Titulo: {obra.title}</p>
            <p>Descrição: {obra.description}</p>
            <p>Autor: {obra.autor}</p>
        </div>

        </div>

        <div className='flex gap-4'>
        <Link href='/obras' className={styles.navButton}>Voltar à obras</Link>
        </div>

    </div>
  );
}
