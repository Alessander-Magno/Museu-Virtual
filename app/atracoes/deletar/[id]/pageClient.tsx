"use client"

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

export default function DeletarAtracaoPageClient( { id }: { id: string } ) {
    const router = useRouter();

    async function deletarAtracao ( e: any ) {
        e.preventDefault();

        await fetch(`/api/atracoes/${id}`, {
            method: "DELETE",
        });

        alert("Atração removida");

        router.push("/atracoes");
    }

    return(
        <div className="max-w-xl mx-auto p-6 flex gap-4">
             <button type='button' onClick={deletarAtracao} className={`${styles.navButton}`}>Deletar atração</button>
             <button type='button' onClick={() => {
                    router.push("/atracoes")
                }} className={`${styles.navButton}`}>Voltar à atrações</button>
        </div>
    );

}
