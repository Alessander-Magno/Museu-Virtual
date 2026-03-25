import Link from 'next/link';
import Image from "next/image";
import styles from '../../../css/Home.module.css';
import AtualizarAtracaoPageClient  from "./pageClient"; 

interface Params {
    params: Promise<{
        id: string,
    }>;
}

export default async function atualizarAtracaoPageServer( Params: Params ) {
    const { params } = await Params;
    const { id } = await params;
    const res = await fetch(`http://localhost:3000/api/atracoes/${id}`);
    const atracao = await res.json();
  
    return (
    <div className="px-30">

        <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Informações atuais da Atração</h1>

        <div key={atracao.id} className="border rounded-lg p-4 shadow-md mb-6 bg-white px-10">

            <div>
                <p>Nome: {atracao.nome}</p>
                <p>Descrição: {atracao.description}</p>
                <p>Disponivel: {atracao.disponibilidade ? "sim" : 'não'}</p>
            </div>

        </div>

        <AtualizarAtracaoPageClient id={ id } name={ atracao.nome } descricao={ atracao.description} />
        

    </div>
  );
}
