"use client"

import { useState } from 'react';
import { useRouter } from "next/navigation"
import styles from '../../css/Home.module.css';

export default function cadastrarAtracaoPage () {
    const router = useRouter();
    const [ nome, setNome ] = useState("");
    const [ description, setDescription ] = useState("");

    async function cadastrarAtracao( e: any ) {
        e.preventDefault();

        if (!nome.trim() || !description.trim()) {
            alert("Preencha todos os campos");
            return;
        }

        await fetch("/api/atracoes", {
            method: 'POST',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nome,
                description,
            })
        })

        alert("Atração criada!");

        router.push("/atracoes")
    }

    return (
        <div className="max-w-xl mx-auto p-6">
            <h1 className="text-3xl font-bold mb-6">Nova Atração</h1>
            <form onSubmit={cadastrarAtracao} className="flex flex-col gap-4">
               
                <input type="text" placeholder='Titulo' value={nome} onChange={(e) => setNome(e.target.value)} className="border p-2 rounded"/>

                <textarea placeholder="Descrição" value={description} onChange={(e) => setDescription(e.target.value)} className="border p-2 rounded"></textarea >

                <button className={`${styles.navButton}`} type='submit'>Cadastrar Atração</button>

                <button className={`${styles.navButton}`} type='button' onClick={() => {
                    router.push('/')
                }}>Voltar a Home</button>

            </form>
        </div>
    )
}