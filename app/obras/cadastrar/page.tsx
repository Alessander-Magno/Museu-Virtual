"use client"

import { useState } from 'react';
import { useRouter } from "next/navigation"
import styles from '../../css/Home.module.css';

export default function cadastrarAtracaoPage () {
    const router = useRouter();
    const [ title, setTitle ] = useState("");
    const [ autor, setAutor ] = useState("");
    const [ atracaoId, setAtracaoId ] = useState("");
    const [ description, setDescription ] = useState("");

    async function cadastrarObra( e: any ) {
        e.preventDefault();

        if (!title.trim() || !description.trim()) {
            alert("Você deve preencher os campos titulo, descrição e atracaoId");
            return;
        }

        const atracaoIdremoveSpace = atracaoId.trim();
        const autorFinal = autor.trim() === "" ? 'desconhecido' : autor;

        await fetch("/api/obras", {
            method: 'POST',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                title,
                description,
                autor: autorFinal,
                atracaoId: atracaoIdremoveSpace
            })
        })

        alert("Obra cadastrada!");

        router.push("/obras")
    }

    return (
        <div className="max-w-xl mx-auto p-6">
            <h1 className="text-3xl font-bold mb-6">Nova Obra</h1>
            <form onSubmit={cadastrarObra} className="flex flex-col gap-4">
               
                <input type="text" placeholder='Titulo' value={title} onChange={(e) => setTitle(e.target.value)} className="border p-2 rounded"/>

                <input type="text" placeholder='Autor(opcional)' value={autor} onChange={(e) => setAutor(e.target.value)} className="border p-2 rounded"/>

                <input type="text" placeholder='AtracaoId' value={atracaoId} onChange={(e) => setAtracaoId(e.target.value)} className="border p-2 rounded"/>
                
                <textarea placeholder="Descrição" value={description} onChange={(e) => setDescription(e.target.value)} className="border p-2 rounded"></textarea >

                <button className={`${styles.navButton}`} type='submit'>Cadastrar Obra</button>

                <button className={`${styles.navButton}`} type='button' onClick={() => {
                    router.push('/')
                }}>Voltar a Home</button>

            </form>
        </div>
    )
}