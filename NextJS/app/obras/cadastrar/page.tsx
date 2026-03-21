"use client"

import { useRouter } from "next/navigation"
import styles from '../../css/Home.module.css';
import { useEffect, useState } from 'react';

type Atracao = {
    id: string,
    nome: string,
    description: string,
    disponibilidade: boolean
};

export default function cadastrarObraPage () {
    const router = useRouter();
    const [ title, setTitle ] = useState("");
    const [ autor, setAutor ] = useState("");
    const [ atracaoId, setAtracaoId ] = useState("");
    const [ description, setDescription ] = useState("");
    const [ atracoes, setAtracoes ] = useState<Atracao[]>([]);

    useEffect(() => {
        fetch("http://localhost:3000/api/atracoes").then(res => res.json()).then(data => setAtracoes(data))
    }, []);

    async function cadastrarObra( e: any ) {
        const regex = /^[a-zA-ZÀ-ÿ\s]+$/;

        e.preventDefault();

        if (!title.trim() || !description.trim() || !atracaoId.trim()) {
            alert("Você deve preencher os campos titulo, descrição e atracaoId");
            return;
        }

        if (!regex.test(title) || !regex.test(description)) {
            alert('É permitido somente letras');
            return;
        }

        if (autor.trim() && !regex.test(autor)) {
            alert('É permitido somente letras');
            return;
        }

        const res = await fetch(`/api/atracoes/${atracaoId}`);

        if (!res.ok) {
            alert("ID da atração está incorreto");
            return;
        }

        const atracaoIdremovedSpace = atracaoId.trim();
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
                atracaoId: atracaoIdremovedSpace
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

                {/* <input type="text" placeholder='AtracaoId' value={atracaoId} onChange={(e) => setAtracaoId(e.target.value)} className="border p-2 rounded"/> */}
                
                <select value={atracaoId} onChange={(e) => setAtracaoId(e.target.value)} className='border p-2 rounded'>
                    <option value="">Selecione uma atração</option>
                    {atracoes.map((atracao) => (
                        <option key={atracao.id} value={atracao.id}>{atracao.nome}</option>
                    ))}
                </select>

                <textarea placeholder="Descrição" value={description} onChange={(e) => setDescription(e.target.value)} className="border p-2 rounded"></textarea >

                <button className={`${styles.navButton}`} type='submit'>Cadastrar Obra</button>

                <button className={`${styles.navButton}`} type='button' onClick={() => {
                    router.push('/')
                }}>Voltar a Home</button>

            </form>
        </div>
    )
}