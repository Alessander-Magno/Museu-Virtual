"use client"

import Link from 'next/link';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

export default function AtualizarAtracaoPageClient( { id, name, descricao,  }: { id: string;  name: string; descricao: string }) {
    const router = useRouter();
    const [ nome, setNome] = useState(name);
    const [ description, setDescription ] = useState(descricao);

    async function atualizarAtracao ( e: any ) {
        const regex = /^[a-zA-ZÀ-ÿ\s]+$/;
        
        e.preventDefault();

        if ( !nome.trim() || !description.trim() ) {
            alert("Preencha todos os campos");
            return;
        }

        if (!regex.test(nome) || !regex.test(description)) {
            alert('É permitido somente letras');
            return;
        }

        console.log(nome, description);

        await fetch(`/api/atracoes/${id}`, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nome,
                description
            })
        });

        alert("Atração atualizada");

        router.push("/atracoes");
    }

    return(
        <div className="max-w-xl mx-auto p-6">
            <h1 className="text-3xl text-center font-bold mb-6">Atualização de Atração</h1>
            <form onSubmit={atualizarAtracao} className="flex flex-col gap-4">
                
                <input type="text" placeholder='Nome' value={nome} onChange={(e) => setNome(e.target.value)} className="border p-2 rounded"/>

                <textarea placeholder='Descrição' value={description} onChange={(e) => setDescription(e.target.value)} className="border p-2 rounded"></textarea>

                <button type='submit' className={`${styles.navButton}`}>Atualizar Atração</button>
                <button type='button' onClick={() => {
                    router.push("/atracoes")
                }} className={`${styles.navButton}`}>Voltar à atrações</button>

            </form>
        </div>
    );

}
