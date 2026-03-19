"use client"

import Link from 'next/link';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Image from "next/image";
import styles from '../../../css/Home.module.css';

export default function AtualizarObraPageClient( { id }: { id: string } ) {
    const router = useRouter();
    const [ title, setTitle] = useState("");
    const [ autor, setAutor ] = useState("");
    const [ description, setDescription ] = useState("");

    async function atualizarObra ( e: any ) {
        const regex = /^[a-zA-ZÀ-ÿ\s]+$/;
        
        e.preventDefault();

        if (!title.trim() || !description.trim()) {
            alert("Você deve preencher os campos titulo e descrição");
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

        const autorFinal = autor.trim() === "" ? 'desconhecido' : autor;

        await fetch(`/api/obras/${id}`, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                title,
                description,
                autor: autorFinal
            })
        });

        alert("Obra atualizada");

        router.push("/obras");
    }

    return(
        <div className="max-w-xl mx-auto p-6">
            <h1 className="text-3xl text-center font-bold mb-6">Atualização de Obra</h1>
            <form onSubmit={atualizarObra} className="flex flex-col gap-4">
                
                <input type="text" placeholder='Titulo' value={title} onChange={(e) => setTitle(e.target.value)} className="border p-2 rounded"/>

                <input type="text" placeholder='Autor(opcional)' value={autor} onChange={(e) => setAutor(e.target.value)} className="border p-2 rounded"/>
                
                <textarea placeholder="Descrição" value={description} onChange={(e) => setDescription(e.target.value)} className="border p-2 rounded"></textarea >

                <button type='submit' className={`${styles.navButton}`}>Atualizar Obra</button>
                <button type='button' onClick={() => {
                    router.push("/obras")
                }} className={`${styles.navButton}`}>Voltar à obras</button>

            </form>
        </div>
    );

}
