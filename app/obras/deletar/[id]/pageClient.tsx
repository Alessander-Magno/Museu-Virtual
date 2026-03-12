"use client"

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

export default function DeletarObraPageClient( { id }: { id: string } ) {
    const router = useRouter();

    async function deletarObra ( e: any ) {
        e.preventDefault();

        await fetch(`/api/obras/${id}`, {
            method: "DELETE",
        });

        alert("Obra removida");

        router.push("/obras");
    }

    return(
        <div className="max-w-xl mx-auto p-6 flex gap-4">
             <button type='button' onClick={deletarObra} className={`${styles.navButton}`}>Deletar obra</button>
             <button type='button' onClick={() => {
                    router.push("/obras")
                }} className={`${styles.navButton}`}>Voltar à obras</button>
        </div>
    );

}
