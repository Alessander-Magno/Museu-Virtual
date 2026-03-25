import Link from 'next/link';
import Image from "next/image";
import styles from '../../../css/Home.module.css';
import AtualizarObraPageClient  from "./pageClient"; 

interface Params {
    params: Promise<{
        id: string,
    }>;
}

export default async function atualizarObraPageServer( Params: Params ) {
    const { params } = await Params;
    const { id } = await params;
    const res = await fetch(`http://localhost:3000/api/obras/${id}`);
    const obra = await res.json();
  
    return (
    <div className="px-30">

        <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Informações atuais da Obra</h1>

        <div key={obra.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

            <div>
                <p>Titulo: {obra.title}</p>
                <p>Descrição: {obra.description}</p>
                <p>Autor(a): {obra.autor}</p>
            </div>

        </div>

        <AtualizarObraPageClient id={ id } titulo={ obra.title } author={ obra.autor } descricao={ obra.description } />     

    </div>
  );
}
